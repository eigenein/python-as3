"""
Contains functions that build larger AST's from smaller AST's or tokens.
"""

from __future__ import annotations

import ast
from ast import AST
from typing import TypeVar

from as3.ast_ import ASTBuilder, make_ast
from as3.constants import name_constants
from as3.scanner import Token

T = TypeVar('T')


def handle_parenthesized(node: T) -> T:
    return node


def handle_integer(token: Token) -> AST:
    return ASTBuilder \
        .name(token, 'int') \
        .call(token, args=[ASTBuilder.number(token).node]) \
        .node


def handle_identifier(token: Token) -> AST:
    # Build `__resolve__(name)[name]`. See also `as3.runtime.__resolve__`.
    name_node = ASTBuilder.string(token).node
    return ASTBuilder \
        .name(token, '__resolve__') \
        .call(token, [name_node]) \
        .subscript(token, name_node) \
        .node


def handle_name_constant(token: Token) -> AST:
    return make_ast(token, ast.NameConstant, value=name_constants[token.type_])
