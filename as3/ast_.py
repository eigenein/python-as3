"""
Wrappers around standard `ast` module.
"""

from __future__ import annotations

import ast
from typing import Any, List, Type

import as3.parser
from as3.constants import augmented_assign_operations, binary_operations, compare_operations, unary_operations
from as3.scanner import Token, TokenType


class AST:
    """
    Helper class to build AST nodes.
    """

    @classmethod
    def identifier(cls, with_token: Token) -> AST:
        assert with_token.type_ in (TokenType.IDENTIFIER, TokenType.SUPER)
        return cls.name(with_token, with_token.value)

    @classmethod
    def name(cls, with_token: Token, identifier: str) -> AST:
        # Creating with `Load` context by default, it may be changed by assignment operations.
        return AST(make_ast(with_token, ast.Name, id=identifier, ctx=ast.Load()))

    @classmethod
    def string(cls, with_token: Token) -> AST:
        return AST(make_ast(with_token, ast.Str, s=with_token.value))

    @classmethod
    def number(cls, with_token: Token) -> AST:
        return AST(make_ast(with_token, ast.Num, n=int(with_token.value)))

    @classmethod
    def name_constant(cls, with_token: Token, value: Any) -> AST:
        return AST(make_ast(with_token, ast.NameConstant, value=value))

    @classmethod
    def script(cls, statements: List[ast.AST]) -> AST:
        return AST(ast.Module(body=statements))

    @classmethod
    def argument(cls, with_token: Token, name: str) -> AST:
        return AST(make_ast(with_token, ast.arg, arg=name, annotation=None))

    @classmethod
    def super_constructor_call(cls, with_token: Token) -> AST:
        """
        `super().__init__()`
        """
        return AST \
            .name(with_token, 'super') \
            .call(with_token) \
            .attribute(with_token, '__init__') \
            .call(with_token) \
            .as_expression(with_token)

    @classmethod
    def type_default_value(cls, with_token: Token, type_node: ast.AST) -> AST:
        """
        `type_.__default__`
        """
        return AST(type_node).attribute(with_token, '__default__')

    @classmethod
    def expression_statement(cls, value: ast.AST) -> AST:
        builder = AST(value)
        return builder if isinstance(value, ast.stmt) else builder.expr()

    @classmethod
    def integer_expression(cls, with_token: Token) -> AST:
        return cls \
            .name(with_token, 'int') \
            .call(with_token, args=[AST.number(with_token).node])

    @classmethod
    def name_expression(cls, with_token: Token) -> AST:
        """
        `__resolve__(name)[name]`.
        """
        name_node = cls.string(with_token).node
        return AST \
            .name(with_token, '__resolve__') \
            .call(with_token, [name_node]) \
            .subscript(with_token, name_node)

    def __init__(self, node: ast.AST) -> None:
        self.node = node

    def call(self, with_token: Token, args: List[ast.AST] = None) -> AST:
        self.node = make_ast(with_token, ast.Call, func=self.node, args=(args or []), keywords=[])
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

    def attribute(self, with_token: Token, name: str) -> AST:
        self.node = make_ast(with_token, ast.Attribute, value=self.node, attr=name, ctx=ast.Load())
        return self

    def as_expression(self, with_token: Token) -> AST:
        self.node = make_ast(with_token, ast.Expr, value=self.node)
        return self

    def assign(self, with_token: Token, value: ast.AST) -> AST:
        if not isinstance(self.node, ast.Assign):
            # Assign to the current node.
            set_store_context(with_token, self.node)
            self.node = make_ast(with_token, ast.Assign, targets=[self.node], value=value)
        else:
            # Chained assignment. Former value becomes a target.
            set_store_context(with_token, self.node.value)
            self.node.targets.append(self.node.value)
            # Value at the right becomes the assigned value.
            self.node.value = value  # type: ignore
        return self

    def aug_assign(self, with_token: Token, value: ast.AST) -> AST:
        set_store_context(with_token, self.node)
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
        else:
            raise KeyError(with_token.type_)
        return self

    def return_it(self, with_token: Token) -> AST:
        self.node = make_ast(with_token, ast.Return, value=self.node)
        return self

    def expr(self) -> AST:
        self.node = ast.Expr(value=self.node, lineno=self.node.lineno, col_offset=0)
        return self


def make_ast(with_token: Token, init: Type[ast.AST], **kwargs) -> ast.AST:
    # noinspection PyProtectedMember
    assert all(field in kwargs for field in init._fields), f'missing: {set(init._fields) - kwargs.keys()}'
    return init(**kwargs, lineno=with_token.line_number, col_offset=with_token.position)


def set_store_context(with_token: Token, node: ast.AST) -> ast.AST:
    if not hasattr(node, 'ctx'):
        as3.parser.raise_syntax_error(f"{ast.dump(node)} can't be assigned to", with_token)
    node.ctx = ast.Store()  # type: ignore
    return node


def make_function(
    with_token: Token,
    name: str,
    body: List[ast.AST] = None,
    args: List[ast.AST] = None,
    defaults: List[ast.AST] = None,
    decorators: List[ast.AST] = None,
) -> ast.AST:
    return make_ast(
        with_token,
        ast.FunctionDef,
        name=name,
        args=ast.arguments(
            args=(args or []),
            vararg=None,
            kwonlyargs=[],
            kw_defaults=[],
            kwarg=None,
            defaults=(defaults or []),
        ),
        body=[*(body or []), make_ast(with_token, ast.Pass)],  # always add `pass` to make sure body is not empty
        decorator_list=(decorators or []),
        returns=None,
    )
