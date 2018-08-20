from __future__ import annotations

import ast
from typing import List

import pytest

from as3.exceptions import ASSyntaxError
from as3.scanner import Token, TokenType
from as3.parser import Parser


@pytest.mark.parametrize('tokens, expected', [
    ([Token(TokenType.INTEGER, 5)], 'Num(n=5)'),
    ([
        Token(TokenType.INTEGER, 42),
        Token(TokenType.PLUS, '+'),
        Token(TokenType.INTEGER, 7),
    ], 'BinOp(left=Num(n=42), op=Add(), right=Num(n=7))'),
    ([
        Token(TokenType.INTEGER, 42),
        Token(TokenType.PLUS, '+'),
        Token(TokenType.INTEGER, 100500),
        Token(TokenType.STAR, '*'),
        Token(TokenType.INTEGER, 7),
    ], 'BinOp(left=Num(n=42), op=Add(), right=BinOp(left=Num(n=100500), op=Mult(), right=Num(n=7)))'),
])
def test_expression(tokens: List[Token], expected: str):
    assert ast.dump(Parser(tokens).parse_expression()) == expected


@pytest.mark.parametrize('tokens', [
    [],
    [Token(TokenType.INTEGER, 42), Token(TokenType.PLUS, '+')],
])
def test_expression_syntax_error(tokens: List[Token]):
    with pytest.raises(ASSyntaxError):
        Parser(tokens).parse_expression()
