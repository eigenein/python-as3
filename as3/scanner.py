from __future__ import annotations

import string
from dataclasses import dataclass
from enum import Enum, auto
from itertools import chain
from typing import Any, Iterator, TextIO, NoReturn, Container, Iterable

from more_itertools import peekable, take, consume

from as3.exceptions import ASSyntaxError


@dataclass
class Token:
    type_: TokenType
    value: Any


class Scanner(Iterator[Token]):
    def __init__(self, io: TextIO):
        self.chars = peekable(chain.from_iterable(line for line in io))

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
        return Token(type_=TokenType.IDENTIFIER, value=self.read_while_in(identifier_chars))

    def read_integer(self) -> Token:
        return Token(type_=TokenType.INTEGER, value=int(self.read_while_in(digits)))

    def read_single(self, type_: TokenType) -> Token:
        return Token(type_=type_, value=self.chars.next())

    def read_while_in(self, chars: Container[str]) -> str:
        return ''.join(self.iterate_while_in(chars))

    def iterate_while_in(self, chars: Container[str]) -> Iterable[str]:
        while self.chars and self.chars.peek() in chars:
            yield self.chars.next()

    def raise_syntax_error(self, message: str) -> NoReturn:
        raise ASSyntaxError(f'syntax error: {message} near: "{"".join(take(80, self.chars))}"')


class TokenType(Enum):
    IDENTIFIER = auto()
    CURLY_BRACKET_OPEN = auto()
    CURLY_BRACKET_CLOSE = auto()
    BRACKET_OPEN = auto()
    BRACKET_CLOSE = auto()
    PARENTHESIS_OPEN = auto()
    PARENTHESIS_CLOSE = auto()
    COLON = auto()
    SEMICOLON = auto()
    COMMA = auto()
    BINARY_OPERATOR = auto()
    INTEGER = auto()
    FLOAT = auto()
    PLUS = auto()
    MINUS = auto()
    DIVIDE = auto()
    STAR = auto()
    LESS = auto()
    ASSIGN = auto()


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
    '/': TokenType.DIVIDE,
    '*': TokenType.STAR,
    '<': TokenType.LESS,
    '=': TokenType.ASSIGN,
}
