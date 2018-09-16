"""
Wrappers around standard `ast` module.
"""

from __future__ import annotations

import ast
from ast import dump
from typing import Any, List, Optional, Type, TypeVar, cast

import as3.parser
from as3.constants import (
    augmented_assign_operations,
    binary_operations,
    boolean_operations,
    compare_operations,
    init_name,
    resolve_name,
    static_prefix,
    this_name,
    unary_operations,
)
from as3.runtime import ASInteger, ASNumber, ASObject
from as3.scanner import Location, Token, TokenType

TAST = TypeVar('TAST', bound=ast.AST)


class AST:
    """
    Helper class to build AST nodes.
    """

    @staticmethod
    def identifier(with_token: Token) -> AST:
        assert with_token.type_ in (TokenType.IDENTIFIER, TokenType.SUPER)
        return AST.name(with_token, with_token.value)

    @staticmethod
    def name(location: Location, identifier: str) -> AST:
        # Creating with `Load` context by default, it may be changed by assignment operations.
        return AST(make_ast(location, ast.Name, id=identifier, ctx=ast.Load()))

    @staticmethod
    def string(location: Location, value: str) -> AST:
        return AST(make_ast(location, ast.Str, s=value))

    @staticmethod
    def name_constant(with_token: Token, value: Any) -> AST:
        return AST(make_ast(with_token, ast.NameConstant, value=value))

    @staticmethod
    def script(statements: List[ast.AST]) -> AST:
        return AST(ast.Module(body=statements))

    @staticmethod
    def argument(location: Location, name: str) -> AST:
        return AST(make_ast(location, ast.arg, arg=name, annotation=None))

    @staticmethod
    def super_constructor_call(location: Location) -> AST:
        """
        `super().__init__()`
        """
        return AST \
            .name(location, 'super') \
            .call(location) \
            .attribute(location, '__init__') \
            .call(location) \
            .as_expression(location)

    @staticmethod
    def type_default_value(with_token: Token, type_node: ast.AST) -> AST:
        """
        `type_.__default__`
        """
        return AST(type_node).attribute(with_token, '__default__')

    @staticmethod
    def expression_statement(value: ast.AST) -> AST:
        builder = AST(value)
        return builder if isinstance(value, ast.stmt) else builder.expr()

    @staticmethod
    def number_expression(with_token: Token) -> AST:
        value = ast.literal_eval(with_token.value)
        return AST \
            .name(with_token, ASInteger.__alias__ if isinstance(value, int) else ASNumber.__alias__) \
            .call(with_token, args=[make_ast(with_token, ast.Num, n=value)])

    @staticmethod
    def string_expression(with_token: Token) -> AST:
        return AST \
            .name(with_token, 'String') \
            .call(with_token, args=[AST.string(with_token, ast.literal_eval(with_token.value)).node])

    @staticmethod
    def name_expression(with_token: Token) -> AST:
        """
        `__resolve__(name).name`.
        """
        name_node = AST.string(with_token, with_token.value).node
        return AST \
            .name(with_token, resolve_name) \
            .call(with_token, [name_node]) \
            .attribute(with_token, with_token.value)

    @staticmethod
    def class_(*, location: Location, name: str, base: Optional[ast.AST], body: List[ast.AST]) -> AST:
        class_body: List[ast.AST] = []
        initializers: List[ast.stmt] = []
        init: Optional[ast.FunctionDef] = None

        for statement in body:
            if isinstance(statement, ast.Assign):
                value = statement.value
                for target in statement.targets:
                    assert isinstance(target, ast.Name), f'unexpected target: {dump(target)}'
                    if target.id.startswith(static_prefix):
                        # Static field initializer. Strip the prefix and initialize it right away.
                        target.id = target.id[len(static_prefix):]
                        class_body.append(make_ast(location_of(statement), ast.Assign, targets=[target], value=value))
                    else:
                        # Non-static field initializer. Prepend `__this__` and postpone it until `__init__`.
                        target = cast(ast.expr, AST.this_target(target).node)
                        initializers.append(make_ast(location_of(statement), ast.Assign, targets=[target], value=value))
                continue
            if isinstance(statement, ast.FunctionDef):
                # It's a method.
                statement_location = location_of(statement)
                # Prepend `__this__` argument.
                statement.args.args.insert(0, cast(ast.arg, AST.argument(statement_location, this_name).node))
                if statement.name == name:
                    init = statement
                    # It's a constructor. Rename it to `__init__`.
                    statement.name = init_name
                    if not has_super_call(statement):
                        # ActionScript calls `super()` implicitly if not called explicitly.
                        statement.body.insert(0, cast(ast.stmt, AST.super_constructor_call(statement_location).node))
            class_body.append(statement)

        # Create a default constructor if not defined.
        init = init or make_function(
            location, init_name, arguments=[cast(ast.arg, AST.argument(location, this_name).node)])
        # Prepend field initializers before the constructor body.
        init.body = [*initializers, *init.body]

        return AST(make_ast(
            location,
            ast.ClassDef,
            name=name,
            bases=[base or AST.name(location, ASObject.__name__).node],
            keywords=[],
            body=[*class_body, init],
            decorator_list=[],
        ))

    @staticmethod
    def this_target(target: ast.Name) -> AST:
        """
        `__this__.target`.
        """
        location = location_of(target)
        return AST.name(location, this_name).attribute(location, target.id).set_store_context()

    @staticmethod
    def arguments(args: List[ast.arg] = None, defaults: List[ast.AST] = None) -> AST:
        return AST(ast.arguments(
            args=(args or []),
            vararg=None,
            kwonlyargs=[],
            kw_defaults=[],
            kwarg=None,
            defaults=(defaults or []),
        ))

    @staticmethod
    def break_(location: Location) -> AST:
        return AST(make_ast(location, ast.Break))

    @staticmethod
    def while_(location: Location, test: ast.AST, body: List[ast.AST]) -> AST:
        return AST(make_ast(location, ast.While, test=test, body=[*body, make_ast(location, ast.Pass)], orelse=[]))

    def __init__(self, node: ast.AST) -> None:
        self.node = node

    def set_store_context(self) -> AST:
        set_store_context(self.node)
        return self

    def call(self, location: Location, args: List[ast.AST] = None) -> AST:
        self.node = make_ast(location, ast.Call, func=self.node, args=(args or []), keywords=[])
        return self

    def subscript(self, with_token: Token, index: ast.AST) -> AST:
        self.node = make_ast(
            with_token,
            ast.Subscript,
            value=self.node,
            slice=make_ast(with_token, ast.Index, value=index),
            ctx=ast.Load(),
        )
        return self

    def attribute(self, location: Location, name: str) -> AST:
        self.node = make_ast(location, ast.Attribute, value=self.node, attr=name, ctx=ast.Load())
        return self

    def as_expression(self, location: Location) -> AST:
        self.node = make_ast(location, ast.Expr, value=self.node)
        return self

    def assign(self, location: Location, value: ast.AST) -> AST:
        if not isinstance(self.node, ast.Assign):
            # Assign to the current node.
            self.set_store_context()
            self.node = make_ast(location, ast.Assign, targets=[self.node], value=value)
        else:
            # Chained assignment. Former value becomes a target.
            set_store_context(self.node.value)
            self.node.targets.append(self.node.value)
            # Value at the right becomes the assigned value.
            self.node.value = value  # type: ignore
        return self

    def aug_assign(self, with_token: Token, value: ast.AST) -> AST:
        self.set_store_context()
        operation = augmented_assign_operations[with_token.type_]
        self.node = make_ast(with_token, ast.AugAssign, target=self.node, op=operation, value=value)
        return self

    def unary_operation(self, with_token: Token) -> AST:
        operation = unary_operations[with_token.type_]
        self.node = make_ast(with_token, ast.UnaryOp, op=operation, operand=self.node)
        return self

    def binary_operation(self, with_token: Token, right: ast.AST) -> AST:
        type_ = with_token.type_
        if type_ in binary_operations:
            self.node = make_ast(with_token, ast.BinOp, left=self.node, op=binary_operations[type_], right=right)
        elif type_ in compare_operations:
            self.node = make_ast(with_token, ast.Compare, left=self.node, ops=[compare_operations[type_]], comparators=[right])
        elif type_ in boolean_operations:
            self.node = make_ast(with_token, ast.BoolOp, values=[self.node, right], op=boolean_operations[type_])
        elif type_ == TokenType.AS:
            pass  # do nothing
        else:
            raise KeyError(with_token.type_)
        return self

    def return_it(self, with_token: Token) -> AST:
        self.node = make_ast(with_token, ast.Return, value=self.node)
        return self

    def expr(self) -> AST:
        self.node = ast.Expr(value=self.node, lineno=self.node.lineno, col_offset=0)
        return self

    def increment(self, location: Location) -> AST:
        self.set_store_context()
        value = make_ast(location, ast.Num, n=1)
        self.node = make_ast(location, ast.AugAssign, target=self.node, op=ast.Add(), value=value)
        return self

    def decrement(self, location: Location) -> AST:
        self.set_store_context()
        value = make_ast(location, ast.Num, n=1)
        self.node = make_ast(location, ast.AugAssign, target=self.node, op=ast.Sub(), value=value)
        return self

    def if_expression(self, location: Location, body: ast.AST, or_else: ast.AST) -> AST:
        self.node = make_ast(location, ast.IfExp, test=self.node, body=body, orelse=or_else)
        return self


def make_ast(location: Location, init: Type[TAST], **kwargs) -> TAST:
    # noinspection PyProtectedMember
    assert all(field in kwargs for field in init._fields), f'missing: {set(init._fields) - kwargs.keys()}'
    return init(**kwargs, lineno=location.line_number, col_offset=location.position)


def set_store_context(node: ast.AST) -> ast.AST:
    if not hasattr(node, 'ctx'):
        as3.parser.raise_syntax_error(f"{ast.dump(node)} can't be assigned to", location_of(node))
    node.ctx = ast.Store()  # type: ignore
    return node


def make_function(
    location: Location,
    name: str,
    body: List[ast.AST] = None,
    arguments: List[ast.arg] = None,
    defaults: List[ast.AST] = None,
    is_class_method=False,
) -> ast.FunctionDef:
    body = body or []
    body = [*body, make_ast(location, ast.Pass)]  # always add `pass` to make sure body is not empty
    args = cast(ast.arguments, AST.arguments(arguments, defaults).node)
    decorator_list = []
    if is_class_method:
        decorator_list.append(make_ast(location, ast.Name, id='classmethod', ctx=ast.Load()))
    return make_ast(
        location, ast.FunctionDef, name=name, args=args, body=body, decorator_list=decorator_list, returns=None)


def has_super_call(node: ast.AST) -> bool:
    """
    Tests if the node contains `super().__init__` anywhere inside.
    """
    return any((
        isinstance(child, ast.Attribute)
        and child.attr == init_name
        and isinstance(child.value, ast.Call)
        and isinstance(child.value.func, ast.Name)
        and child.value.func.id == 'super'
    ) for child in ast.walk(node))


def location_of(node: ast.AST) -> Location:
    return Location(line_number=node.lineno, position=node.col_offset)
