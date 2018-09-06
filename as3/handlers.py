"""
Contains functions that build larger AST's from smaller AST's or tokens.
TODO: I feel like this should instead build ActionScript AST which then will be transformed into Python AST.
TODO: then I'll be able to test the syntax and the transformer separately.
"""

from __future__ import annotations

import ast
from ast import AST
from itertools import chain
from typing import Iterable, Tuple, TypeVar

from as3.ast_ import ASTBuilder, make_ast
from as3.constants import name_constants
from as3.scanner import Token

T = TypeVar('T')


def handle_parenthesized(args: Tuple[Token, AST, Token]) -> T:
    _, node, _ = args
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


def handle_script(statements_lists: Iterable[Iterable[AST]]) -> AST:
    return ast.Module(body=list(chain.from_iterable(statements_lists)))
