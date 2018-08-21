from __future__ import annotations

import ast
from typing import List

import pytest

from as3.exceptions import ASSyntaxError
from as3.scanner import Token, TokenType
from as3.parser import Parser


@pytest.mark.parametrize('tokens, expected', [
    (
        [Token(TokenType.INTEGER, 5, 0, 0)],
        'Num(n=5)',
    ),
    (
        [
            Token(TokenType.INTEGER, 42, 0, 0),
            Token(TokenType.PLUS, '+', 0, 0),
            Token(TokenType.INTEGER, 7, 0, 0),
        ],
        'BinOp(left=Num(n=42), op=Add(), right=Num(n=7))',
    ),
    (
        [
            Token(TokenType.INTEGER, 42, 0, 0),
            Token(TokenType.PLUS, '+', 0, 0),
            Token(TokenType.INTEGER, 100500, 0, 0),
            Token(TokenType.STAR, '*', 0, 0),
            Token(TokenType.INTEGER, 7, 0, 0),
        ],
        'BinOp(left=Num(n=42), op=Add(), right=BinOp(left=Num(n=100500), op=Mult(), right=Num(n=7)))',
    ),
])
def test_expression(tokens: List[Token], expected: str):
    assert ast.dump(Parser(tokens).parse_expression()) == expected


@pytest.mark.parametrize('tokens', [
    [],
    [Token(TokenType.INTEGER, 42, 0, 0), Token(TokenType.PLUS, '+', 0, 0)],
])
def test_expression_syntax_error(tokens: List[Token]):
    with pytest.raises(ASSyntaxError):
        Parser(tokens).parse_expression()
