import ast
import re
from typing import Dict

from as3.enums import TokenType

keyword_to_token_type = {
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

unary_operations: Dict[TokenType, ast.AST] = {
    TokenType.LOGICAL_NOT: ast.Not(),
    TokenType.MINUS: ast.USub(),
    TokenType.PLUS: ast.UAdd(),
}

binary_operations: Dict[TokenType, ast.AST] = {
    TokenType.BITWISE_XOR: ast.BitXor(),
    TokenType.DIVIDE: ast.Div(),
    TokenType.MINUS: ast.Sub(),
    TokenType.MULTIPLY: ast.Mult(),
    TokenType.PLUS: ast.Add(),
}

augmented_assign_operations: Dict[TokenType, ast.AST] = {
    TokenType.ASSIGN_ADD: ast.Add(),
}

compare_operations: Dict[TokenType, ast.AST] = {
    # `STRICTLY_EQUALS` should be handled separately because it has to test types as well.
    TokenType.EQUALS: ast.Eq(),
    TokenType.GREATER: ast.Gt(),
    TokenType.GREATER_OR_EQUAL: ast.GtE(),
    TokenType.IN: ast.In(),
    TokenType.LESS: ast.Lt(),
    TokenType.LESS_OR_EQUAL: ast.LtE(),
    TokenType.NOT_EQUALS: ast.NotEq(),
}

boolean_operations: Dict[TokenType, ast.AST] = {
    TokenType.LOGICAL_AND: ast.And(),
    TokenType.LOGICAL_OR: ast.Or(),
}

this_name = '__this__'
init_name = '__init__'
packages_path_key = '__packages_path__'
resolve_key = '__resolve__'
import_key = '__import_name__'
import_cache_key = '__import_cache__'
operand_stack_key = '__operand_stack__'
static_field_key = '__static_field__'
field_key = '__field__'
imports_key = '__imports__'
class_property_key = 'classproperty'

actionscript_suffix = '.as'

mocked_imports = re.compile(r'''
    flash\.(
        display\. |
        events\. |
        filters\. |
        text\. |
        (utils\.(getTimer|setInterval|setTimeout))
    ).*
''', re.VERBOSE)
