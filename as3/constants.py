import ast
from typing import Any, Dict

from as3.enums import TokenType

keyword_to_token_type = {
    'break': TokenType.BREAK,
    'class': TokenType.CLASS,
    'else': TokenType.ELSE,
    'extends': TokenType.EXTENDS,
    'false': TokenType.FALSE,
    'function': TokenType.FUNCTION,
    'if': TokenType.IF,
    'import': TokenType.IMPORT,
    'override': TokenType.OVERRIDE,
    'package': TokenType.PACKAGE,
    'public': TokenType.PUBLIC,
    'return': TokenType.RETURN,
    'static': TokenType.STATIC,
    'super': TokenType.SUPER,
    'this': TokenType.THIS,
    'true': TokenType.TRUE,
    'var': TokenType.VAR,
}

unary_operations: Dict[TokenType, ast.AST] = {
    TokenType.PLUS: ast.UAdd(),
    TokenType.MINUS: ast.USub(),
}

binary_operations: Dict[TokenType, ast.AST] = {
    TokenType.MINUS: ast.Sub(),
    TokenType.PLUS: ast.Add(),
    TokenType.DIVIDE: ast.Div(),
    TokenType.MULTIPLY: ast.Mult(),
}

augmented_assign_operations: Dict[TokenType, ast.AST] = {
    TokenType.ASSIGN_ADD: ast.Add(),
}

compare_operations: Dict[TokenType, ast.AST] = {
    TokenType.NOT_EQUALS: ast.NotEq(),
}

name_constants: Dict[TokenType, Any] = {
    TokenType.TRUE: True,
    TokenType.FALSE: False,
}

# `__this__` may be an instance _or_ a class itself.
# Also, avoid confusion with possible `self` variable which is valid in ActionScript.
this_name = '__this__'
init_name = '__init__'
