"""
Wrappers around standard `ast` module.
"""

from __future__ import annotations

import ast
from ast import AST
from typing import List, Optional, Type

import as3.parser
from as3.constants import augmented_assign_operations, binary_operations, compare_operations, unary_operations
from as3.scanner import Token, TokenType


class ASTBuilder:
    """
    Helper class to build AST nodes.
    Operations performed on a helper instance are converted into corresponding node transformations.
    """

    @classmethod
    def identifier(cls, with_token: Token) -> ASTBuilder:
        assert with_token.type_ in (TokenType.IDENTIFIER, TokenType.SUPER)
        return cls.name(with_token, with_token.value)

    @classmethod
    def name(cls, with_token: Token, identifier: str) -> ASTBuilder:
        # Creating with `Load` context by default, it may be changed by assignment operations.
        return ASTBuilder(make_ast(with_token, ast.Name, id=identifier, ctx=ast.Load()))

    @classmethod
    def string(cls, with_token: Token) -> ASTBuilder:
        return ASTBuilder(make_ast(with_token, ast.Str, s=with_token.value))

    @classmethod
    def number(cls, with_token: Token) -> ASTBuilder:
        return ASTBuilder(make_ast(with_token, ast.Num, n=int(with_token.value)))

    def __init__(self, node: Optional[AST]):
        self.node = node

    def call(self, with_token: Token, args: List[AST] = None) -> ASTBuilder:
        self.node = make_ast(with_token, ast.Call, func=self.node, args=(args or []), keywords=[])
        return self

    def subscript(self, with_token: Token, index: AST) -> ASTBuilder:
        self.node = make_ast(
            with_token,
            ast.Subscript,
            value=self.node,
            slice=make_ast(with_token, ast.Index, value=index),
            ctx=ast.Load(),
        )
        return self

    def attribute(self, with_token: Token, name: str) -> ASTBuilder:
        self.node = make_ast(with_token, ast.Attribute, value=self.node, attr=name, ctx=ast.Load())
        return self

    def as_expression(self, with_token: Token) -> ASTBuilder:
        self.node = make_ast(with_token, ast.Expr, value=self.node)
        return self

    def assign(self, with_token: Token, value: AST) -> ASTBuilder:
        if not isinstance(self.node, ast.Assign):
            # Assign to the current node.
            set_store_context(with_token, self.node)
            self.node = make_ast(with_token, ast.Assign, targets=[self.node], value=value)
        else:
            # Chained assignment. Former value becomes a target.
            set_store_context(with_token, self.node.value)
            self.node.targets.append(self.node.value)
            # Value at the right becomes the assigned value.
            self.node.value = value
        return self

    def aug_assign(self, with_token: Token, value: AST) -> ASTBuilder:
        set_store_context(with_token, self.node)
        operation = augmented_assign_operations[with_token.type_]
        self.node = make_ast(with_token, ast.AugAssign, target=self.node, op=operation, value=value)
        return self

    def unary_operation(self, with_token: Token) -> ASTBuilder:
        operation = unary_operations[with_token.type_]
        self.node = make_ast(with_token, ast.UnaryOp, op=operation, operand=self.node)
        return self

    def binary_operation(self, with_token: Token, right: AST) -> ASTBuilder:
        type_ = with_token.type_
        if type_ in binary_operations:
            self.node = make_ast(with_token, ast.BinOp, left=self.node, op=binary_operations[type_], right=right)
        elif type_ in compare_operations:
            self.node = make_ast(with_token, ast.Compare, left=self.node, ops=[compare_operations[type_]], comparators=[right])
        else:
            raise KeyError(with_token.type_)
        return self

    def return_(self, with_token: Token) -> ASTBuilder:
        self.node = make_ast(with_token, ast.Return, value=self.node)
        return self


def make_ast(with_token: Token, init: Type[AST], **kwargs) -> AST:
    # noinspection PyProtectedMember
    assert all(field in kwargs for field in init._fields), f'missing: {set(init._fields) - kwargs.keys()}'
    return init(**kwargs, lineno=with_token.line_number, col_offset=with_token.position)


def set_store_context(with_token: Token, node: AST) -> AST:
    if not hasattr(node, 'ctx'):
        as3.parser.raise_syntax_error(f"{ast.dump(node)} can't be assigned to", with_token)
    node.ctx = ast.Store()
    return node


def make_type_default_value(with_token: Token, type_node: AST) -> AST:
    # `type_.__default__`
    return ASTBuilder(type_node).attribute(with_token, '__default__').node


def make_super_constructor_call(with_token: Token) -> AST:
    # `super().__init__()`
    return ASTBuilder \
        .name(with_token, 'super') \
        .call(with_token) \
        .attribute(with_token, '__init__') \
        .call(with_token) \
        .as_expression(with_token) \
        .node


def make_function(
    with_token: Token,
    name: str,
    body: List[AST] = None,
    args: List[AST] = None,
    defaults: List[AST] = None,
    decorators: List[AST] = None,
) -> AST:
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


def make_argument(with_token: Token, name: str) -> AST:
    return make_ast(with_token, ast.arg, arg=name, annotation=None)
