from __future__ import annotations

from ast import Expression
from collections import namedtuple
from typing import Any, List

import pytest

from as3.exceptions import ASSyntaxError
from as3.parser import Parser, ContextType, Context
from as3.scanner import Token, TokenType

context = Context(ContextType.CODE_BLOCK)


@pytest.mark.parametrize('tokens, expected', [
    (
        # `5 /* five */`
        [Token(TokenType.INTEGER, 5, 0, 0), Token(TokenType.COMMENT, ' five ', 0, 0)],
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
            Token(TokenType.MULTIPLY, '*', 0, 0),
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
            Token(TokenType.MULTIPLY, '*', 0, 0),
            Token(TokenType.INTEGER, 2, 0, 0),
        ],
        8,
    ),
    (
        # `foo.bar`
        [
            Token(TokenType.IDENTIFIER, 'foo', 0, 0),
            Token(TokenType.DOT, '.', 0, 0),
            Token(TokenType.IDENTIFIER, 'bar', 0, 0),
        ],
        42,
    ),
    (
        # `foo.bar + foo.bar`
        [
            Token(TokenType.IDENTIFIER, 'foo', 0, 0),
            Token(TokenType.DOT, '.', 0, 0),
            Token(TokenType.IDENTIFIER, 'bar', 0, 0),
            Token(TokenType.PLUS, '+', 0, 0),
            Token(TokenType.IDENTIFIER, 'foo', 0, 0),
            Token(TokenType.DOT, '.', 0, 0),
            Token(TokenType.IDENTIFIER, 'bar', 0, 0),
        ],
        84,
    ),
    (
        # `+-42`
        [
            Token(TokenType.PLUS, '+', 0, 0),
            Token(TokenType.MINUS, '-', 0, 0),
            Token(TokenType.INTEGER, 42, 0, 0),
        ],
        -42,
    ),
])
def test_expression(tokens: List[Token], expected: Any):
    actual = eval(compile(Expression(Parser(tokens).parse_expression(context)), '<ast>', 'eval'), {
        'foo': namedtuple('Foo', 'bar')(bar=42),
    })
    assert actual == expected, f'actual: {actual}'


@pytest.mark.parametrize('tokens', [
    [],

    # `42 +`
    [
        Token(TokenType.INTEGER, 42, 0, 0),
        Token(TokenType.PLUS, '+', 0, 0),
    ],
])
def test_expression_syntax_error(tokens: List[Token]):
    with pytest.raises(ASSyntaxError):
        Parser(tokens).parse_expression(context)
