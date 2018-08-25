from __future__ import annotations

from dataclasses import dataclass
from typing import Any, Callable, Iterable, Iterator, NoReturn, TextIO

from more_itertools import consume, peekable, side_effect

from as3 import constants
from as3.enums import TokenType
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
        consume(self.iterate_while(lambda char_: char_ in constants.whitespaces))

        char = self.chars.peek()
        if char in constants.identifier_first_chars:
            return self.read_identifier()
        if char in constants.character_to_token_type:
            return self.read_single(constants.character_to_token_type[char])
        if char == '+':
            return self.read_plus()
        if char == '<':
            return self.read_less()
        if char == '/':
            return self.read_slash()
        if char in constants.digits:
            return self.read_integer()

        self.raise_syntax_error(f'unrecognized token "{char}"')

    def read_identifier(self) -> Token:
        line_number, position = self.line_number, self.position
        value = ''.join(self.iterate_while(lambda char: char in constants.identifier_chars))
        return Token(
            type_=constants.keyword_to_token_type.get(value, TokenType.IDENTIFIER),
            value=value,
            line_number=line_number,
            position=position,
        )

    def read_integer(self) -> Token:
        line_number, position = self.line_number, self.position
        return Token(
            type_=TokenType.INTEGER,
            value=int(''.join(self.iterate_while(lambda char: char in constants.digits))),
            line_number=line_number,
            position=position,
        )

    def read_single(self, type_: TokenType) -> Token:
        line_number, position = self.line_number, self.position
        return Token(type_=type_, value=self.chars.next(), line_number=line_number, position=position)

    def read_less(self) -> Token:
        line_number, position = self.line_number, self.position
        self.expect('<')
        if not self.skip('<'):
            return Token(type_=TokenType.LESS, value='<', line_number=line_number, position=position)
        return Token(type_=TokenType.LEFT_SHIFT, value='<<', line_number=line_number, position=position)

    def read_plus(self) -> Token:
        line_number, position = self.line_number, self.position
        self.expect('+')
        if not self.skip('='):
            return Token(type_=TokenType.PLUS, value='+', line_number=line_number, position=position)
        return Token(type_=TokenType.ASSIGN_ADD, value='+=', line_number=line_number, position=position)

    def read_slash(self) -> Token:
        line_number, position = self.line_number, self.position
        self.expect('/')

        # Single-line comment.
        if self.skip('/'):
            return Token(
                type_=TokenType.COMMENT,
                value=''.join(self.iterate_while(lambda char: char not in '\r\n')),
                line_number=line_number,
                position=position,
            )

        # Multi-line comment.
        if self.skip('*'):
            chars = []
            while self.chars:
                if self.skip('*') and self.skip('/'):
                    return Token(
                        type_=TokenType.COMMENT,
                        value=''.join(chars),
                        line_number=line_number,
                        position=position,
                    )
                chars.append(self.chars.next())
            self.raise_syntax_error('unexpected end of file inside a block comment')

        # Just normal division.
        return Token(type_=TokenType.DIVIDE, value='/', line_number=line_number, position=position)

    def expect(self, char: str):
        if not self.chars:
            self.raise_syntax_error('unexpected end of file')
        if self.chars.peek() != char:
            self.raise_syntax_error(f'expected: "{char}", found: "{self.chars.peek()}"')
        self.chars.next()

    def skip(self, char: str) -> bool:
        if self.chars and self.chars.peek() == char:
            self.chars.next()
            return True
        return False

    def iterate_while(self, predicate: Callable[[str], bool]) -> Iterable[str]:
        while self.chars and predicate(self.chars.peek()):
            yield self.chars.next()

    def raise_syntax_error(self, message: str) -> NoReturn:
        raise ASSyntaxError(f'syntax error: {message} at line {self.line_number} position {self.position}')
