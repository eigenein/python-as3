"""
Contains functions that build larger AST's from smaller AST's or tokens.
"""

from __future__ import annotations

import ast
from ast import AST
from itertools import chain
from typing import Iterable, List, Tuple, TypeVar

from as3.ast_ import ASTBuilder, make_ast
from as3.constants import name_constants
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
