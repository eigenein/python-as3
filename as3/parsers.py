"""
Parser functions that potentially accept any custom syntax.
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


def parse(tokens: Iterable[Token], with_parser: TParser[T]) -> T:
    return with_parser(Peekable(tokens))


def sequence(*parsers: TParser[Any]) -> TParser[Tuple[Any, ...]]:
    """
    Sequence of inner parsers. Result of each parser is captured and all of them are returned in a tuple.
    """
    def parse_sequence(tokens: Peekable[Token]) -> T:
        return tuple(parser(tokens) for parser in parsers)
    return parse_sequence


def switch(*parsers: TParser[T]) -> TParser[T]:
    """
    Equivalent of syntax rule "or" expression.
    """
    def parse_either(tokens: Peekable[Token]) -> T:
        position = tokens.position
        for parser in parsers:
            try:
                # First successful parser.
                return parser(tokens)
            except ASSyntaxError:
                if tokens.position != position:
                    raise  # parser advanced and then failed
        # All cases failed.
        try:
            token = tokens.peek()
        except StopIteration:
            raise ASSyntaxError(f'unexpected end of stream')
        else:
            raise ASSyntaxError(
                f'unexpected {token.type_.name} "{token.value}"'
                f' at line {token.line_number} position {token.position}'
            )
    return parse_either


def maybe(parser: TParser[T]) -> TParser[Optional[T]]:
    """
    Specifies optional syntax construction.
    """
    def parse_optional(tokens: Peekable[T]) -> Optional[T]:
        position = tokens.position
        try:
            return parser(tokens)
        except ASSyntaxError:
            if tokens.position != position:
                raise  # parser advanced and then failed
            return None
    return parse_optional


def many(parser: TParser[T]) -> TParser[List[T]]:
    """
    Zero to multiple repetitions of the same syntax expression.
    """
    def parse_many(tokens: Peekable[T]) -> List[T]:
        results: List[T] = []
        while True:
            position = tokens.position
            try:
                results.append(parser(tokens))
            except ASSyntaxError:
                if tokens.position != position:
                    raise  # parser advanced and then failed
                return results
    return parse_many


def expect(*types: TokenType) -> TParser[T]:
    """
    Expects single token of one of specified types.
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


def end_of_stream(tokens: Peekable[Token]):
    """
    Expects end of stream. Used to handle not parsed leftovers properly.
    """
    try:
        token = tokens.peek()
    except StopIteration:
        pass
    else:
        raise ASSyntaxError(
            f'unexpected {token.type_.name} "{token.value}"'
            f' at line {token.line_number} position {token.position},'
            f' expected end of stream'
        )


def handled(parser: TParser[Any], with_handler: THandler[T]) -> TParser[T]:
    """
    Return handled result of inner parser.
    """
    def handle_parsed(tokens: Peekable[Token]) -> T:
        return with_handler(parser(tokens))
    return handle_parsed
