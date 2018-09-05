"""
Describes ActionScript syntax.
"""

from __future__ import annotations

from as3 import handlers
from as3.constants import name_constants
from as3.enums import TokenType
from as3.parsers import expect, sequence, skip, switch

integer = expect(handlers.handle_integer, TokenType.INTEGER)
identifier = expect(handlers.handle_identifier, TokenType.IDENTIFIER)
name_constant = expect(handlers.handle_name_constant, *name_constants.keys())
terminal = switch(integer, identifier)

parenthesized = sequence(
    handlers.handle_parenthesized,
    [
        ('', skip(TokenType.PARENTHESIS_OPEN)),
        ('node', lambda tokens: expression(tokens)),
        ('', skip(TokenType.PARENTHESIS_CLOSE)),
    ],
)

terminal_or_parenthesized = switch(terminal, parenthesized)
expression = terminal_or_parenthesized
