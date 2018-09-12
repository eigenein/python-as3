"""
Scanner aka lexer.
"""

from __future__ import annotations

import re
from dataclasses import dataclass
from typing import Any, Iterable

from as3 import constants
from as3.enums import TokenType
from as3.exceptions import ASSyntaxError

# Group names must match `TokenType` members.
specification = re.compile(r'''
    # Special tokens used by the scanner.
    (?P<NEW_LINE>\r?\n) |
    (?P<WHITESPACE>[ \t\f\v]+) |
    
    # Normal tokens.
    (?P<GENERIC_OPEN>\.<) |
    (?P<LOGICAL_OR>\|\|) |
    (?P<LOGICAL_AND>&&) |
    (?P<STRICTLY_EQUAL>===) |
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
    (?P<NUMBER>[-+]?(0[xX][\dA-Fa-f]+|(\d+(\.\d*)?|\.\d+)([eE][-+]?\d+)?)) |
    (?P<LESS_OR_EQUAL><=) |
    (?P<GREATER_OR_EQUAL>>=) |
    (?P<LESS><) |
    (?P<GREATER>>) |
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
    (?P<STRING_1>\"(\\.|[^\\"])*\") |  # http://www.lysator.liu.se/c/ANSI-C-grammar-l.html
    (?P<STRING_2>\'(\\.|[^\\'])*\') |  # http://www.lysator.liu.se/c/ANSI-C-grammar-l.html
    
    # Fallback token to detect syntax errors.
    (?P<UNKNOWN>.)
''', re.VERBOSE)


@dataclass
class Location:
    line_number: int
    position: int


@dataclass
class Token(Location):
    # I have to re-define these two fields because my IDE is complaining.
    line_number: int
    position: int
    type_: TokenType
    value: Any


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
