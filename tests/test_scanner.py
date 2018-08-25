from __future__ import annotations

from io import StringIO
from typing import List

import pytest
from more_itertools import consume

from as3.exceptions import ASSyntaxError
from as3.scanner import Scanner, Token
from as3.enums import TokenType


def test_empty():
    assert list(Scanner(StringIO(''))) == []


@pytest.mark.parametrize('input_, expected', [
    ('package', Token(type_=TokenType.PACKAGE, value='package', line_number=1, position=1)),
    ('{', Token(type_=TokenType.CURLY_BRACKET_OPEN, value='{', line_number=1, position=1)),
    ('(', Token(type_=TokenType.PARENTHESIS_OPEN, value='(', line_number=1, position=1)),
    ('[', Token(type_=TokenType.BRACKET_OPEN, value='[', line_number=1, position=1)),
    (';', Token(type_=TokenType.SEMICOLON, value=';', line_number=1, position=1)),
    (':', Token(type_=TokenType.COLON, value=':', line_number=1, position=1)),
    ('+', Token(type_=TokenType.PLUS, value='+', line_number=1, position=1)),
    ('-', Token(type_=TokenType.MINUS, value='-', line_number=1, position=1)),
    ('<', Token(type_=TokenType.LESS, value='<', line_number=1, position=1)),
    ('<<', Token(type_=TokenType.LEFT_SHIFT, value='<<', line_number=1, position=1)),
    ('+=', Token(type_=TokenType.ASSIGN_ADD, value='+=', line_number=1, position=1)),
    ('/', Token(type_=TokenType.DIVIDE, value='/', line_number=1, position=1)),
    ('/* ololo */', Token(type_=TokenType.COMMENT, value=' ololo ', line_number=1, position=1)),
    ('// abc', Token(type_=TokenType.COMMENT, value=' abc', line_number=1, position=1)),
    ('*', Token(type_=TokenType.MULTIPLY, value='*', line_number=1, position=1)),
])
def test_single_token(input_: str, expected: Token):
    tokens = list(Scanner(StringIO(input_)))
    assert len(tokens) == 1
    assert tokens[0] == expected


@pytest.mark.parametrize('input_, expected', [
    (
        'a = 42;',
        [
            Token(type_=TokenType.IDENTIFIER, value='a', line_number=1, position=1),
            Token(type_=TokenType.ASSIGN, value='=', line_number=1, position=3),
            Token(type_=TokenType.INTEGER, value=42, line_number=1, position=5),
            Token(type_=TokenType.SEMICOLON, value=';', line_number=1, position=7),
        ],
    ),
    (
        'a = /* what? */ 42',
        [
            Token(type_=TokenType.IDENTIFIER, value='a', line_number=1, position=1),
            Token(type_=TokenType.ASSIGN, value='=', line_number=1, position=3),
            Token(type_=TokenType.COMMENT, value=' what? ', line_number=1, position=5),
            Token(type_=TokenType.INTEGER, value=42, line_number=1, position=17),
        ],
    ),
])
def test_multiple_tokens(input_: str, expected: List[Token]):
    assert list(Scanner(StringIO(input_))) == expected


@pytest.mark.parametrize('input_', [
    '/* end of file',
])
def test_syntax_error(input_: str):
    with pytest.raises(ASSyntaxError):
        consume(Scanner(StringIO(input_)))


def test_scanner_get_elemental_penetration():
    text = '''
        public static function getElementalPenetration(param1:Number, param2:Number) : int
        {
            if(param2 < 0)
            {
                param2 = 0;
            }
            return int(param1 / (Number(1 + param2 / 300000)));
        }
    '''
    assert list(Scanner(StringIO(text))) == [
        Token(type_=TokenType.PUBLIC, value='public', line_number=2, position=9),
        Token(type_=TokenType.STATIC, value='static', line_number=2, position=16),
        Token(type_=TokenType.FUNCTION, value='function', line_number=2, position=23),
        Token(type_=TokenType.IDENTIFIER, value='getElementalPenetration', line_number=2, position=32),
        Token(type_=TokenType.PARENTHESIS_OPEN, value='(', line_number=2, position=55),
        Token(type_=TokenType.IDENTIFIER, value='param1', line_number=2, position=56),
        Token(type_=TokenType.COLON, value=':', line_number=2, position=62),
        Token(type_=TokenType.IDENTIFIER, value='Number', line_number=2, position=63),
        Token(type_=TokenType.COMMA, value=',', line_number=2, position=69),
        Token(type_=TokenType.IDENTIFIER, value='param2', line_number=2, position=71),
        Token(type_=TokenType.COLON, value=':', line_number=2, position=77),
        Token(type_=TokenType.IDENTIFIER, value='Number', line_number=2, position=78),
        Token(type_=TokenType.PARENTHESIS_CLOSE, value=')', line_number=2, position=84),
        Token(type_=TokenType.COLON, value=':', line_number=2, position=86),
        Token(type_=TokenType.IDENTIFIER, value='int', line_number=2, position=88),

        Token(type_=TokenType.CURLY_BRACKET_OPEN, value='{', line_number=3, position=9),

        Token(type_=TokenType.IF, value='if', line_number=4, position=13),
        Token(type_=TokenType.PARENTHESIS_OPEN, value='(', line_number=4, position=15),
        Token(type_=TokenType.IDENTIFIER, value='param2', line_number=4, position=16),
        Token(type_=TokenType.LESS, value='<', line_number=4, position=23),
        Token(type_=TokenType.INTEGER, value=0, line_number=4, position=25),
        Token(type_=TokenType.PARENTHESIS_CLOSE, value=')', line_number=4, position=26),

        Token(type_=TokenType.CURLY_BRACKET_OPEN, value='{', line_number=5, position=13),

        Token(type_=TokenType.IDENTIFIER, value='param2', line_number=6, position=17),
        Token(type_=TokenType.ASSIGN, value='=', line_number=6, position=24),
        Token(type_=TokenType.INTEGER, value=0, line_number=6, position=26),
        Token(type_=TokenType.SEMICOLON, value=';', line_number=6, position=27),

        Token(type_=TokenType.CURLY_BRACKET_CLOSE, value='}', line_number=7, position=13),

        Token(type_=TokenType.RETURN, value='return', line_number=8, position=13),
        Token(type_=TokenType.IDENTIFIER, value='int', line_number=8, position=20),
        Token(type_=TokenType.PARENTHESIS_OPEN, value='(', line_number=8, position=23),
        Token(type_=TokenType.IDENTIFIER, value='param1', line_number=8, position=24),
        Token(type_=TokenType.DIVIDE, value='/', line_number=8, position=31),
        Token(type_=TokenType.PARENTHESIS_OPEN, value='(', line_number=8, position=33),
        Token(type_=TokenType.IDENTIFIER, value='Number', line_number=8, position=34),
        Token(type_=TokenType.PARENTHESIS_OPEN, value='(', line_number=8, position=40),
        Token(type_=TokenType.INTEGER, value=1, line_number=8, position=41),
        Token(type_=TokenType.PLUS, value='+', line_number=8, position=43),
        Token(type_=TokenType.IDENTIFIER, value='param2', line_number=8, position=45),
        Token(type_=TokenType.DIVIDE, value='/', line_number=8, position=52),
        Token(type_=TokenType.INTEGER, value=300000, line_number=8, position=54),
        Token(type_=TokenType.PARENTHESIS_CLOSE, value=')', line_number=8, position=60),
        Token(type_=TokenType.PARENTHESIS_CLOSE, value=')', line_number=8, position=61),
        Token(type_=TokenType.PARENTHESIS_CLOSE, value=')', line_number=8, position=62),
        Token(type_=TokenType.SEMICOLON, value=';', line_number=8, position=63),

        Token(type_=TokenType.CURLY_BRACKET_CLOSE, value='}', line_number=9, position=9),
    ]
