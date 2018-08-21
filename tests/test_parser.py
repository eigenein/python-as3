from __future__ import annotations

from ast import Expression
from typing import Any, List

import pytest

from as3.exceptions import ASSyntaxError
from as3.parser import Parser
from as3.scanner import Token, TokenType


@pytest.mark.parametrize('tokens, expected', [
    (
        # `5`
        [Token(TokenType.INTEGER, 5, 0, 0)],
        5,
    ),
    (
        # `42 + 7`
        [
            Token(TokenType.INTEGER, 42, 0, 0),
            Token(TokenType.PLUS, '+', 0, 0),
            Token(TokenType.INTEGER, 7, 0, 0),
        ],
        49,
    ),
    (
        # `2 + 2 * 2`
        [
            Token(TokenType.INTEGER, 2, 0, 0),
            Token(TokenType.PLUS, '+', 0, 0),
            Token(TokenType.INTEGER, 2, 0, 0),
            Token(TokenType.STAR, '*', 0, 0),
            Token(TokenType.INTEGER, 2, 0, 0),
        ],
        6,
    ),
    (
        # `(2 + 2) * 2`
        [
            Token(TokenType.PARENTHESIS_OPEN, '(', 0, 0),
            Token(TokenType.INTEGER, 2, 0, 0),
            Token(TokenType.PLUS, '+', 0, 0),
            Token(TokenType.INTEGER, 2, 0, 0),
            Token(TokenType.PARENTHESIS_CLOSE, ')', 0, 0),
            Token(TokenType.STAR, '*', 0, 0),
            Token(TokenType.INTEGER, 2, 0, 0),
        ],
        8,
    ),
])
def test_expression(tokens: List[Token], expected: Any):
    assert eval(compile(Expression(Parser(tokens).parse_expression()), '<ast>', 'eval')) == expected


@pytest.mark.parametrize('tokens', [
    [],
    [Token(TokenType.INTEGER, 42, 0, 0), Token(TokenType.PLUS, '+', 0, 0)],
])
def test_expression_syntax_error(tokens: List[Token]):
    with pytest.raises(ASSyntaxError):
        Parser(tokens).parse_expression()
