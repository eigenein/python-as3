import ast
import string
from _ast import AST
from typing import Dict

from as3.enums import TokenType

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
    '-': TokenType.MINUS,
    '*': TokenType.MULTIPLY,
    '=': TokenType.ASSIGN,
    '.': TokenType.DOT,
}

keyword_to_token_type = {
    'break': TokenType.BREAK,
    'class': TokenType.CLASS,
    'extends': TokenType.EXTENDS,
    'function': TokenType.FUNCTION,
    'if': TokenType.IF,
    'import': TokenType.IMPORT,
    'override': TokenType.OVERRIDE,
    'package': TokenType.PACKAGE,
    'public': TokenType.PUBLIC,
    'return': TokenType.RETURN,
    'static': TokenType.STATIC,
    'var': TokenType.VAR,
}

unary_operations: Dict[TokenType, AST] = {
    TokenType.PLUS: ast.UAdd(),
    TokenType.MINUS: ast.USub(),
}

binary_operations: Dict[TokenType, AST] = {
    TokenType.MINUS: ast.Sub(),
    TokenType.PLUS: ast.Add(),
    TokenType.DIVIDE: ast.Div(),
    TokenType.MULTIPLY: ast.Mult(),
}

augmented_assign_operations: Dict[TokenType, AST] = {
    TokenType.ASSIGN_ADD: ast.Add(),
}
