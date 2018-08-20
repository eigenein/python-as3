from __future__ import annotations

from io import StringIO

import pytest

from as3.scanner import Scanner, Token, TokenType


def test_empty():
    assert list(Scanner(StringIO(''))) == []


@pytest.mark.parametrize('input_, expected', [
    ('package', Token(type_=TokenType.IDENTIFIER, value='package')),
    ('{', Token(type_=TokenType.CURLY_BRACKET_OPEN, value='{')),
    ('(', Token(type_=TokenType.PARENTHESIS_OPEN, value='(')),
    ('[', Token(type_=TokenType.BRACKET_OPEN, value='[')),
    (';', Token(type_=TokenType.SEMICOLON, value=';')),
    (':', Token(type_=TokenType.COLON, value=':')),
    ('+', Token(type_=TokenType.PLUS, value='+')),
    ('-', Token(type_=TokenType.MINUS, value='-')),
])
def test_single_token(input_: str, expected: Token):
    assert list(Scanner(StringIO(input_))) == [expected]


def test_scanner_get_elemental_penetration():
    text = """
        public static function getElementalPenetration(param1:Number, param2:Number) : int
        {
            if(param2 < 0)
            {
                param2 = 0;
            }
            return int(param1 / (Number(1 + param2 / 300000)));
        }
    """
    assert list(Scanner(StringIO(text))) == [
        Token(type_=TokenType.IDENTIFIER, value='public'),
        Token(type_=TokenType.IDENTIFIER, value='static'),
        Token(type_=TokenType.IDENTIFIER, value='function'),
        Token(type_=TokenType.IDENTIFIER, value='getElementalPenetration'),
        Token(type_=TokenType.PARENTHESIS_OPEN, value='('),
        Token(type_=TokenType.IDENTIFIER, value='param1'),
        Token(type_=TokenType.COLON, value=':'),
        Token(type_=TokenType.IDENTIFIER, value='Number'),
        Token(type_=TokenType.COMMA, value=','),
        Token(type_=TokenType.IDENTIFIER, value='param2'),
        Token(type_=TokenType.COLON, value=':'),
        Token(type_=TokenType.IDENTIFIER, value='Number'),
        Token(type_=TokenType.PARENTHESIS_CLOSE, value=')'),
        Token(type_=TokenType.COLON, value=':'),
        Token(type_=TokenType.IDENTIFIER, value='int'),
        Token(type_=TokenType.CURLY_BRACKET_OPEN, value='{'),
        Token(type_=TokenType.IDENTIFIER, value='if'),
        Token(type_=TokenType.PARENTHESIS_OPEN, value='('),
        Token(type_=TokenType.IDENTIFIER, value='param2'),
        Token(type_=TokenType.LESS, value='<'),
        Token(type_=TokenType.INTEGER, value=0),
        Token(type_=TokenType.PARENTHESIS_CLOSE, value=')'),
        Token(type_=TokenType.CURLY_BRACKET_OPEN, value='{'),
        Token(type_=TokenType.IDENTIFIER, value='param2'),
        Token(type_=TokenType.ASSIGN, value='='),
        Token(type_=TokenType.INTEGER, value=0),
        Token(type_=TokenType.SEMICOLON, value=';'),
        Token(type_=TokenType.CURLY_BRACKET_CLOSE, value='}'),
        Token(type_=TokenType.IDENTIFIER, value='return'),
        Token(type_=TokenType.IDENTIFIER, value='int'),
        Token(type_=TokenType.PARENTHESIS_OPEN, value='('),
        Token(type_=TokenType.IDENTIFIER, value='param1'),
        Token(type_=TokenType.DIVIDE, value='/'),
        Token(type_=TokenType.PARENTHESIS_OPEN, value='('),
        Token(type_=TokenType.IDENTIFIER, value='Number'),
        Token(type_=TokenType.PARENTHESIS_OPEN, value='('),
        Token(type_=TokenType.INTEGER, value=1),
        Token(type_=TokenType.PLUS, value='+'),
        Token(type_=TokenType.IDENTIFIER, value='param2'),
        Token(type_=TokenType.DIVIDE, value='/'),
        Token(type_=TokenType.INTEGER, value=300000),
        Token(type_=TokenType.PARENTHESIS_CLOSE, value=')'),
        Token(type_=TokenType.PARENTHESIS_CLOSE, value=')'),
        Token(type_=TokenType.PARENTHESIS_CLOSE, value=')'),
        Token(type_=TokenType.SEMICOLON, value=';'),
        Token(type_=TokenType.CURLY_BRACKET_CLOSE, value='}'),
    ]
