"""
AST helpers.
"""
import ast
from ast import AST
from typing import List, Optional, Type

import as3.parser
from as3.constants import this_name
from as3.scanner import Token, TokenType


def make_ast(token: Token, init: Type[AST], **kwargs) -> AST:
    # noinspection PyProtectedMember
    assert all(field in kwargs for field in init._fields), f'missing: {set(init._fields) - kwargs.keys()}'
    return init(**kwargs, lineno=token.line_number, col_offset=token.position)


def make_ast_from_source(token: Token, source: str) -> AST:
    # FIXME: I don't really like to use this function so replace with something better.
    node, = ast.parse(source).body
    node.lineno = token.line_number
    node.col_offset = token.position
    return ast.fix_missing_locations(node)


def make_name(name_token: Token, custom_name: Optional[str] = None, ctx=ast.Load()) -> AST:
    assert custom_name or name_token.type_ in (TokenType.IDENTIFIER, TokenType.SUPER)
    return make_ast(name_token, ast.Name, id=(custom_name or name_token.value), ctx=ctx)


def make_call(call_token: Token, func: AST, args: List[AST] = None) -> AST:
    return make_ast(call_token, ast.Call, func=func, args=(args or []), keywords=[])


def make_function(
    function_token: Token,
    name: str,
    body: List[AST],
    args: List[AST] = None,
    returns=None,
    decorator_list: List[AST] = None,
) -> AST:
    # Always add `pass` to be sure the body is not empty.
    return make_ast(
        function_token,
        ast.FunctionDef,
        name=name,
        args=ast.arguments(args=(args or []), vararg=None, kwonlyargs=[], kw_defaults=[], kwarg=None, defaults=[]),
        body=[*body, make_ast(function_token, ast.Pass)],
        decorator_list=(decorator_list or []),
        returns=returns,
    )


def make_field_initializer(name_token: Token, value: AST) -> AST:
    # `self.field = value`
    return make_ast(name_token, ast.Assign, targets=[make_ast(
        name_token,
        ast.Attribute,
        value=make_ast(name_token, ast.Name, id=this_name, ctx=ast.Load()),
        attr=name_token.value,
        ctx=ast.Store(),
    )], value=value)


def set_store_context(node: AST, assignment_token: Token) -> AST:
    if not hasattr(node, 'ctx'):
        as3.parser.raise_syntax_error(f"{ast.dump(node)} can't be assigned to", assignment_token)
    node.ctx = ast.Store()
    return node
