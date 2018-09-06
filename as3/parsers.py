"""
Contains function that allow to construct syntax rules from a simpler ones.
"""

from __future__ import annotations

from typing import Any, Callable, Iterable, List, Optional, Tuple, TypeVar

from as3.enums import TokenType
from as3.exceptions import ASSyntaxError
from as3.itertools_ import Peekable
from as3.scanner import Token

T = TypeVar('T')
THandler = Callable[..., T]
TParser = Callable[[Peekable[Token]], T]


def parse(with_parser: TParser[T], tokens: Iterable[Token]) -> T:
    return with_parser(Peekable(tokens))


def sequence(*parsers: TParser[Any]) -> TParser[Tuple[Any, ...]]:
    """
    Sequence of inner parsers. Result of each parser is captured and passed into the handler.
    """
    def parse_sequence(tokens: Peekable[Token]) -> T:
        return tuple(parser(tokens) for parser in parsers)
    return parse_sequence


def switch(*parsers: TParser[T]) -> TParser[T]:
    """
    Specifies syntax alternatives.
    Important: inner parsers must not advance the token iterator in case of unsuccess.
    """
    def parse_either(tokens: Peekable[Token]) -> T:
        for parser in parsers:
            try:
                # First successful parser.
                return parser(tokens)
            except ASSyntaxError:
                continue
        # All cases failed.
        try:
            token = tokens.peek()
        except StopIteration:
            # Because of end of stream.
            raise ASSyntaxError(f'unexpected end of stream')
        else:
            # Because the token is unexpected.
            raise ASSyntaxError(
                f'unexpected {token.type_.name} "{token.value}"'
                f' at line {token.line_number} position {token.position}'
            )
    return parse_either


def maybe(parser: TParser[T]) -> TParser[Optional[T]]:
    """
    Specifies optional syntax construction.
    Important: inner parser must not advance the token iterator in case of unsuccess.
    """
    def parse_optional(tokens: Peekable[T]) -> Optional[T]:
        try:
            return parser(tokens)
        except ASSyntaxError:
            return None
    return parse_optional


def many(parser: TParser[T]) -> TParser[List[T]]:
    """
    Many occurrences of the same syntax construct.
    Important: inner parser must not advance the token iterator in case of unsuccess.
    """
    def parse_many(tokens: Peekable[T]) -> List[T]:
        results: List[T] = []
        while True:
            try:
                results.append(parser(tokens))
            except ASSyntaxError:
                return results
    return parse_many


def expect(*types: TokenType) -> TParser[T]:
    """
    Expect single token of one specified types.
    """
    def parse_expected_token(tokens: Peekable[Token]) -> T:
        try:
            token = tokens.peek()
        except StopIteration:
            # noinspection PyUnresolvedReferences
            raise ASSyntaxError(f'unexpected end of stream, expected one of: {", ".join(type_.name for type_ in types)}')
        if token.type_ not in types:
            # noinspection PyUnresolvedReferences
            raise ASSyntaxError(
                f'unexpected {token.type_.name} "{token.value}"'
                f' at line {token.line_number} position {token.position},'
                f' expected one of: {", ".join(type_.name for type_ in types)}'
            )
        return tokens.next()
    return parse_expected_token


def handled(parser: TParser[Any], with_handler: THandler[T]) -> TParser[T]:
    """
    Return handled result of inner parser.
    TODO: see the note in `handlers.py`.
    """
    def handle_parsed(tokens: Peekable[Token]) -> T:
        return with_handler(parser(tokens))
    return handle_parsed
