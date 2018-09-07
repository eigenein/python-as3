"""
Contains functions that build larger AST's from smaller AST's or tokens.
"""

from __future__ import annotations

import ast
from ast import AST
from itertools import chain
from typing import Callable, Iterable, List, Tuple, TypeVar

from as3.ast_ import ASTBuilder, make_ast
from as3.constants import init_name, name_constants, this_name
from as3.enums import TokenType
from as3.scanner import Token

T = TypeVar('T')


def parenthesized(args: Tuple[Token, AST, Token]) -> T:
    _, node, _ = args
    return node


def integer(token: Token) -> AST:
    return ASTBuilder \
        .name(token, 'int') \
        .call(token, args=[ASTBuilder.number(token).node]) \
        .node


def name(token: Token) -> AST:
    # Build `__resolve__(name)[name]`. See also `as3.runtime.__resolve__`.
    name_node = ASTBuilder.string(token).node
    return ASTBuilder \
        .name(token, '__resolve__') \
        .call(token, [name_node]) \
        .subscript(token, name_node) \
        .node


def name_constant(token: Token) -> AST:
    return make_ast(token, ast.NameConstant, value=name_constants[token.type_])


def script(args: Tuple[Iterable[Iterable[AST]], None]) -> AST:
    statements_lists, _ = args
    return ast.Module(body=list(chain.from_iterable(statements_lists)))


def unary(args: Tuple[List[Token], AST]) -> AST:
    tokens, node = args
    builder = ASTBuilder(node)
    for token in reversed(tokens):
        builder.unary_operation(token)
    return builder.node


def this(token: Token) -> AST:
    return make_ast(token, ast.Name, id=this_name, ctx=ast.Load())


def super_expression(args: Tuple[Token, Tuple[Token, Callable[[AST], AST]]]) -> AST:
    super_token, (next_token, super_handler) = args
    builder = ASTBuilder.identifier(super_token).call(super_token)  # `super()`
    if next_token.type_ == TokenType.PARENTHESIS_OPEN:
        # Call super constructor, so pass `super().__init__` to the call handler.
        builder.attribute(super_token, init_name)
    # Call super method, so pass `super()` to the attribute handler.
    return super_handler(builder.node)


def attribute_expression(args: Tuple[Token, Token]) -> Tuple[Token, Callable[[AST], AST]]:
    dot_token, attribute_token = args

    # Left node is not known at the moment, so return a callable that will perform the operation.
    def handle_attribute_expression(node: AST) -> AST:
        return ASTBuilder(node).attribute(dot_token, attribute_token.value).node
    return dot_token, handle_attribute_expression


def call_expression(args: Tuple[Token, List[AST], Token]) -> Tuple[Token, Callable[[AST], AST]]:
    call_token, arguments, _ = args

    # Left node is not known at the moment, so return a callable that will perform the operation.
    def handle_call_expression(node: AST) -> AST:
        return ASTBuilder(node).call(call_token, arguments).node
    return call_token, handle_call_expression


def call_argument(args: Tuple[AST, Token]) -> AST:
    argument, _ = args
    return argument


def primary_expression(args: Tuple[AST, List[Tuple[Token, Callable[[AST], AST]]]]) -> AST:
    node, handlers = args
    for _, handler in handlers:
        node = handler(node)
    return node
