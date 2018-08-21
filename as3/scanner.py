from __future__ import annotations

import string
from dataclasses import dataclass
from enum import Enum, auto
from typing import Any, Container, Iterable, Iterator, NoReturn, TextIO

from more_itertools import consume, peekable, side_effect

from as3.exceptions import ASSyntaxError


@dataclass
class Token:
    type_: TokenType
    value: Any
    line_number: int
    position: int


class Scanner(Iterator[Token]):
    def __init__(self, io: TextIO):
        self.chars = peekable(
            char
            for line in side_effect(self.increment_line, io)
            for char in side_effect(self.increment_position, line)
        )
        self.line_number = 0
        self.position = 0

    def increment_line(self, _: str):
        self.line_number += 1
        self.position = 0

    def increment_position(self, _: str):
        self.position += 1

    def __iter__(self) -> Iterator[Token]:
        return self

    def __next__(self) -> Token:
        consume(self.iterate_while_in(whitespaces))

        char = self.chars.peek()
        if char in identifier_first_chars:
            return self.read_identifier()
        if char in character_to_token_type:
            return self.read_single(character_to_token_type[char])
        if char in digits:
            return self.read_integer()

        self.raise_syntax_error('unrecognized token')

    def read_identifier(self) -> Token:
        line_number, position = self.line_number, self.position
        value = self.read_while_in(identifier_chars)
        return Token(
            type_=keyword_to_token.get(value, TokenType.IDENTIFIER),
            value=value,
            line_number=line_number,
            position=position,
        )

    def read_integer(self) -> Token:
        line_number, position = self.line_number, self.position
        return Token(
            type_=TokenType.INTEGER,
            value=int(self.read_while_in(digits)),
            line_number=line_number,
            position=position,
        )

    def read_single(self, type_: TokenType) -> Token:
        line_number, position = self.line_number, self.position
        return Token(type_=type_, value=self.chars.next(), line_number=line_number, position=position)

    def read_while_in(self, chars: Container[str]) -> str:
        return ''.join(self.iterate_while_in(chars))

    def iterate_while_in(self, chars: Container[str]) -> Iterable[str]:
        while self.chars and self.chars.peek() in chars:
            yield self.chars.next()

    def raise_syntax_error(self, message: str) -> NoReturn:
        raise ASSyntaxError(f'syntax error: {message} at line {self.line_number} position {self.position}')


class TokenType(Enum):
    # Brackets.
    BRACKET_CLOSE = auto()
    BRACKET_OPEN = auto()
    CURLY_BRACKET_CLOSE = auto()
    CURLY_BRACKET_OPEN = auto()
    PARENTHESIS_CLOSE = auto()
    PARENTHESIS_OPEN = auto()

    # Punctuation.
    COLON = auto()
    COMMA = auto()
    DOT = auto()
    SEMICOLON = auto()

    # Literals.
    FLOAT = auto()
    INTEGER = auto()

    # Binary operators.
    ASSIGN = auto()
    LESS = auto()
    MINUS = auto()
    PLUS = auto()
    SLASH = auto()
    STAR = auto()

    # Identifiers.
    BREAK = auto()
    CLASS = auto()
    FUNCTION = auto()
    IDENTIFIER = auto()
    IMPORT = auto()
    PACKAGE = auto()
    PUBLIC = auto()
    RETURN = auto()
    STATIC = auto()
    VAR = auto()


identifier_first_chars = {*string.ascii_letters, '_'}
identifier_chars = {*string.ascii_letters, *string.digits, '_'}
whitespaces = set(string.whitespace)
digits = set(string.digits)

character_to_token_type = {
    '{': TokenType.CURLY_BRACKET_OPEN,
    '}': TokenType.CURLY_BRACKET_CLOSE,
    '[': TokenType.BRACKET_OPEN,
    ']': TokenType.BRACKET_CLOSE,
    '(': TokenType.PARENTHESIS_OPEN,
    ')': TokenType.PARENTHESIS_CLOSE,
    ':': TokenType.COLON,
    ';': TokenType.SEMICOLON,
    ',': TokenType.COMMA,
    '+': TokenType.PLUS,
    '-': TokenType.MINUS,
    '/': TokenType.SLASH,
    '*': TokenType.STAR,
    '<': TokenType.LESS,
    '=': TokenType.ASSIGN,
    '.': TokenType.DOT,
}

keyword_to_token = {
    'break': TokenType.BREAK,
    'class': TokenType.CLASS,
    'function': TokenType.FUNCTION,
    'import': TokenType.IMPORT,
    'package': TokenType.PACKAGE,
    'public': TokenType.PUBLIC,
    'return': TokenType.RETURN,
    'static': TokenType.STATIC,
    'var': TokenType.VAR,
}
