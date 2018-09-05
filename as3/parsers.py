from __future__ import annotations

from typing import Any, Callable, Tuple, TypeVar, Iterable

from more_itertools import peekable

from as3.enums import TokenType
from as3.exceptions import ASSyntaxError
from as3.scanner import Token

T = TypeVar('T')
THandler = Callable[..., T]
TParser = Callable[[peekable], T]


def parse(with_parser: TParser[T], tokens: Iterable[Token]) -> T:
    return with_parser(peekable(tokens))


def sequence(handler: THandler[T], *parsers: Tuple[str, TParser[Any]]) -> TParser[T]:
    def sequence_parser(tokens: peekable) -> T:
        kwargs = {key: parser(tokens) for key, parser in parsers}
        kwargs.pop('', None)  # drop unneeded values
        return handler(**kwargs)
    return sequence_parser


def switch(*parsers: TParser[T]) -> TParser[T]:
    def switch_parser(tokens: peekable) -> T:
        for parser in parsers:
            try:
                # First successful parser.
                return parser(tokens)
            except ASSyntaxError:
                continue
        # All cases failed.
        raise tokens.peek().raise_unexpected()
    return switch_parser


def expect(handler: THandler[T], *types: TokenType) -> TParser[T]:
    def parser(tokens: peekable) -> T:
        # Expect single token.
        tokens.peek().raise_if_not(*types)
        return handler(tokens.next())
    return parser


def skip(*types: TokenType) -> TParser[T]:
    return expect(lambda _: None, *types)
