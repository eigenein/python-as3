from __future__ import annotations

from typing import List

from pytest import mark, param

from as3.enums import TokenType
from as3.scanner import Token, scan


def make_test_params(value: str, type_: TokenType, xfail: bool = False):
    marks = mark.xfail(strict=True) if xfail else ()
    return param(value, Token(type_=type_, value=value, line_number=1, position=1), marks=marks)


def test_empty():
    assert list(scan('')) == []


@mark.parametrize('input_, expected', [
    # Positive cases.
    make_test_params('just_some_identifier', TokenType.IDENTIFIER),
    make_test_params('package', TokenType.PACKAGE),
    make_test_params('{', TokenType.CURLY_BRACKET_OPEN),
    make_test_params('(', TokenType.PARENTHESIS_OPEN),
    make_test_params('[', TokenType.BRACKET_OPEN),
    make_test_params(';', TokenType.SEMICOLON),
    make_test_params(':', TokenType.COLON),
    make_test_params('+', TokenType.PLUS),
    make_test_params('-', TokenType.MINUS),
    make_test_params('<', TokenType.LESS),
    make_test_params('<<', TokenType.LEFT_SHIFT),
    make_test_params('+=', TokenType.ASSIGN_ADD),
    make_test_params('/', TokenType.DIVIDE),
    make_test_params('*', TokenType.MULTIPLY),
    make_test_params('!', TokenType.LOGICAL_NOT),
    make_test_params('!=', TokenType.NOT_EQUALS),
    make_test_params('>>', TokenType.RIGHT_SHIFT),
    make_test_params('==', TokenType.EQUALS),
    make_test_params('++', TokenType.INCREMENT),
    make_test_params('--', TokenType.DECREMENT),
    make_test_params('.', TokenType.DOT),
    make_test_params('/* ololo */', TokenType.COMMENT),
    make_test_params('// abc', TokenType.COMMENT),
    make_test_params('"string"', TokenType.STRING),
    make_test_params("'string'", TokenType.STRING),
    make_test_params(r'"string\n"', TokenType.STRING),
    make_test_params(r'"string\""', TokenType.STRING),
    make_test_params(r"'string\''", TokenType.STRING),
    make_test_params('<=', TokenType.LESS_OR_EQUAL),
    make_test_params('>', TokenType.GREATER),
    make_test_params('>=', TokenType.GREATER_OR_EQUAL),
    make_test_params('===', TokenType.STRICTLY_EQUAL),
    make_test_params('||', TokenType.LOGICAL_OR),
    make_test_params('&&', TokenType.LOGICAL_AND),
    make_test_params('new', TokenType.NEW),
    make_test_params('.<', TokenType.GENERIC_OPEN),
    make_test_params('42', TokenType.NUMBER),
    make_test_params('0xABCDEF', TokenType.NUMBER),
    make_test_params('0777', TokenType.NUMBER),
    make_test_params('0.75', TokenType.NUMBER),
    make_test_params('1.', TokenType.NUMBER),
    make_test_params('.9', TokenType.NUMBER),
    make_test_params('1e-10', TokenType.NUMBER),
    make_test_params('?', TokenType.QUESTION_MARK),

    # Expected failures.
    make_test_params('>>>', TokenType.UNSIGNED_RIGHT_SHIFT, True),
])
def test_single_token(input_: str, expected: Token):
    tokens = list(scan(input_))
    assert len(tokens) == 1
    assert tokens[0] == expected


@mark.parametrize('input_, expected', [
    (
        'a = 42;',
        [
            Token(type_=TokenType.IDENTIFIER, value='a', line_number=1, position=1),
            Token(type_=TokenType.ASSIGN, value='=', line_number=1, position=3),
            Token(type_=TokenType.NUMBER, value='42', line_number=1, position=5),
            Token(type_=TokenType.SEMICOLON, value=';', line_number=1, position=7),
        ],
    ),
    (
        'a = /* what? */ 42',
        [
            Token(type_=TokenType.IDENTIFIER, value='a', line_number=1, position=1),
            Token(type_=TokenType.ASSIGN, value='=', line_number=1, position=3),
            Token(type_=TokenType.COMMENT, value='/* what? */', line_number=1, position=5),
            Token(type_=TokenType.NUMBER, value='42', line_number=1, position=17),
        ],
    ),
    (
        ' \n/**/',
        [
            Token(type_=TokenType.COMMENT, value='/**/', line_number=2, position=1),
        ],
    ),
])
def test_multiple_tokens(input_: str, expected: List[Token]):
    assert list(scan(input_)) == expected


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
    assert list(scan(text)) == [
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
        Token(type_=TokenType.NUMBER, value='0', line_number=4, position=25),
        Token(type_=TokenType.PARENTHESIS_CLOSE, value=')', line_number=4, position=26),

        Token(type_=TokenType.CURLY_BRACKET_OPEN, value='{', line_number=5, position=13),

        Token(type_=TokenType.IDENTIFIER, value='param2', line_number=6, position=17),
        Token(type_=TokenType.ASSIGN, value='=', line_number=6, position=24),
        Token(type_=TokenType.NUMBER, value='0', line_number=6, position=26),
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
        Token(type_=TokenType.NUMBER, value='1', line_number=8, position=41),
        Token(type_=TokenType.PLUS, value='+', line_number=8, position=43),
        Token(type_=TokenType.IDENTIFIER, value='param2', line_number=8, position=45),
        Token(type_=TokenType.DIVIDE, value='/', line_number=8, position=52),
        Token(type_=TokenType.NUMBER, value='300000', line_number=8, position=54),
        Token(type_=TokenType.PARENTHESIS_CLOSE, value=')', line_number=8, position=60),
        Token(type_=TokenType.PARENTHESIS_CLOSE, value=')', line_number=8, position=61),
        Token(type_=TokenType.PARENTHESIS_CLOSE, value=')', line_number=8, position=62),
        Token(type_=TokenType.SEMICOLON, value=';', line_number=8, position=63),

        Token(type_=TokenType.CURLY_BRACKET_CLOSE, value='}', line_number=9, position=9),
    ]
