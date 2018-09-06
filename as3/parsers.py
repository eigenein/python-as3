"""
Contains function that allow to construct syntax rules from a simpler ones.
"""

from __future__ import annotations

from typing import Any, Callable, Iterable, Tuple, TypeVar, Optional

from as3.enums import TokenType
from as3.exceptions import ASSyntaxError
from as3.itertools_ import Peekable
from as3.scanner import Token

T = TypeVar('T')
THandler = Callable[..., T]
TParser = Callable[[Peekable[Token]], T]


def parse(with_parser: TParser[T], tokens: Iterable[Token]) -> T:
    return with_parser(Peekable(tokens))


def sequence(handler: THandler[T], parsers: Iterable[Tuple[str, TParser[Any]]]) -> TParser[T]:
    """
    Sequence of inner parsers. Result of each parser is captured and passed into the handler.
    """
    def sequence_parser(tokens: Peekable[Token]) -> T:
        kwargs = {key: parser(tokens) for key, parser in parsers}
        kwargs.pop('', None)  # drop unneeded values
        return handler(**kwargs)
    return sequence_parser


def switch(*parsers: TParser[T]) -> TParser[T]:
    """
    Specifies syntax alternatives.
    Important: inner parsers must not advance the token iterator in case of unsuccess.
    """
    def switch_parser(tokens: Peekable[Token]) -> T:
        for parser in parsers:
            try:
                # First successful parser.
                return parser(tokens)
            except ASSyntaxError:
                continue
        # All cases failed.
        raise tokens.peek().raise_unexpected()
    return switch_parser


def maybe(parser: TParser[T]) -> TParser[Optional[T]]:
    """
    Specifies optional syntax construction.
    Important: inner parser must not advance the token iterator in case of unsuccess.
    """
    def maybe_parser(tokens: Peekable[T]) -> Optional[T]:
        try:
            return parser(tokens)
        except ASSyntaxError:
            return None
    return maybe_parser


def expect(handler: THandler[T], *types: TokenType) -> TParser[T]:
    def parser(tokens: Peekable[T]) -> T:
        # Expect single token.
        tokens.peek().raise_if_not(*types)
        return handler(tokens.next())
    return parser


def skip(*types: TokenType) -> TParser[T]:
    return expect(lambda _: None, *types)
