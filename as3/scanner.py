"""
Scanner aka lexer.
"""

from __future__ import annotations

import re
from dataclasses import dataclass
from typing import Any, Dict, Iterable

from as3.enums import TokenType
from as3.exceptions import ASSyntaxError

# Group names must match `TokenType` members.
specification = re.compile(r'''
    # Special tokens used by the scanner.
    (?P<NEW_LINE>\r?\n) |
    (?P<WHITESPACE>[ \t\f\v]+) |
    
    # Normal tokens.
    (?P<PERCENT>%) |
    (?P<BITWISE_XOR>\^) |
    (?P<QUESTION_MARK>\?) |
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
    (?P<IDENTIFIER>[_a-zA-Z§][\w§]*) |
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
    (?P<STRING>(\"(\\.|[^\\"])*\"|\'(\\.|[^\\'])*\')) |  # http://www.lysator.liu.se/c/ANSI-C-grammar-l.html
    
    # Fallback token to detect syntax errors.
    (?P<UNKNOWN>.)
''', re.VERBOSE | re.DOTALL)


@dataclass
class Token:
    line_number: int
    position: int
    type_: TokenType
    value: Any


def scan(source: str, filename: str = '<string>') -> Iterable[Token]:
    current_line_number = 1
    current_line_start_index = 0

    for match in specification.finditer(source):
        type_ = TokenType[match.lastgroup]
        value = match.group(match.lastgroup)
        position = match.start() - current_line_start_index + 1  # indexing starts from one
        if type_ == TokenType.UNKNOWN:
            raise ASSyntaxError(f'{filename}: unexpected character "{value}" at line {current_line_number} position {position}')
        if type_ == TokenType.WHITESPACE:
            # Don't flood the parser with whitespaces.
            continue
        if type_ == TokenType.NEW_LINE:
            # Used just to track the current position.
            current_line_start_index = match.end()
            current_line_number += 1
            continue
        if type_ == TokenType.IDENTIFIER and value in keyword_to_token_type:
            type_ = keyword_to_token_type[value]
        yield Token(type_=type_, value=value, line_number=current_line_number, position=position)


keyword_to_token_type: Dict[str, TokenType] = {
    'as': TokenType.AS,
    'break': TokenType.BREAK,
    'catch': TokenType.CATCH,
    'class': TokenType.CLASS,
    'const': TokenType.CONST,
    'each': TokenType.EACH,
    'else': TokenType.ELSE,
    'extends': TokenType.EXTENDS,
    'false': TokenType.FALSE,
    'finally': TokenType.FINALLY,
    'for': TokenType.FOR,
    'function': TokenType.FUNCTION,
    'if': TokenType.IF,
    'get': TokenType.GET,
    'implements': TokenType.IMPLEMENTS,
    'import': TokenType.IMPORT,
    'in': TokenType.IN,
    'interface': TokenType.INTERFACE,
    'internal': TokenType.INTERNAL,
    'is': TokenType.IS,
    'new': TokenType.NEW,
    'null': TokenType.NULL,
    'override': TokenType.OVERRIDE,
    'package': TokenType.PACKAGE,
    'private': TokenType.PRIVATE,
    'protected': TokenType.PROTECTED,
    'public': TokenType.PUBLIC,
    'return': TokenType.RETURN,
    'static': TokenType.STATIC,
    'super': TokenType.SUPER,
    'this': TokenType.THIS,
    'throw': TokenType.THROW,
    'true': TokenType.TRUE,
    'try': TokenType.TRY,
    'undefined': TokenType.UNDEFINED,
    'var': TokenType.VAR,
    'void': TokenType.VOID,
    'while': TokenType.WHILE,
}
