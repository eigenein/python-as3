from __future__ import annotations

import re
from dataclasses import dataclass
from typing import Any, Iterable

from as3 import constants
from as3.enums import TokenType
from as3.exceptions import ASSyntaxError

specification = re.compile(r'''
    # Special tokens used by the scanner.
    (?P<NEW_LINE>\n) |
    (?P<WHITESPACE>\s+) |
    
    # Normal tokens.
    (?P<EQUALS>==) |
    (?P<NOT_EQUALS>!=) |
    (?P<ASSIGN_ADD>\+=) |
    (?P<UNSIGNED_LEFT_SHIFT><<<) |
    (?P<LEFT_SHIFT><<) |
    (?P<RIGHT_SHIFT>>>) |
    (?P<DECREMENT>--) |
    (?P<INCREMENT>\+\+) |
    (?P<ASSIGN>=) |
    (?P<COLON>:) |
    (?P<COMMA>,) |
    (?P<COMMENT>(//[^\n]*)|(/\*.*?\*/)) |
    (?P<CURLY_BRACKET_CLOSE>}) |
    (?P<CURLY_BRACKET_OPEN>{) |
    (?P<DIVIDE>/) |
    (?P<IDENTIFIER>[_a-zA-Z]\w*) |
    (?P<INTEGER>\d+) |
    (?P<LESS><) |
    (?P<LOGICAL_NOT>!) |
    (?P<MULTIPLY>\*) |
    (?P<PARENTHESIS_CLOSE>\)) |
    (?P<PARENTHESIS_OPEN>\() |
    (?P<BRACKET_CLOSE>\]) |
    (?P<BRACKET_OPEN>\[) |
    (?P<PLUS>\+) |
    (?P<MINUS>-) |
    (?P<SEMICOLON>;) |
    (?P<DOT>\.) |
    
    # Fallback token to detect syntax errors.
    (?P<UNKNOWN>.)
''', re.VERBOSE)


@dataclass
class Token:
    type_: TokenType
    value: Any
    line_number: int
    position: int


def scan(source: str) -> Iterable[Token]:
    current_line_number = 1
    current_line_start_index = 0

    for match in specification.finditer(source):
        type_ = TokenType[match.lastgroup]
        value = match.group(match.lastgroup)
        position = match.start() - current_line_start_index + 1  # indexing starts from one
        if type_ == TokenType.UNKNOWN:
            raise ASSyntaxError(f'unexpected character "{value}" at line {current_line_number} position {position}')
        if type_ == TokenType.WHITESPACE:
            # Don't flood the parser with whitespaces.
            continue
        if type_ == TokenType.NEW_LINE:
            # Used just to track the current position.
            current_line_start_index = match.end()
            current_line_number += 1
            continue
        if type_ == TokenType.IDENTIFIER and value in constants.keyword_to_token_type:
            type_ = constants.keyword_to_token_type[value]
        yield Token(type_=type_, value=value, line_number=current_line_number, position=position)
