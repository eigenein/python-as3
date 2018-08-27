"""
AST helpers.
"""
import ast
from typing import Callable, List, Optional

import as3.parser
from as3.scanner import Token, TokenType


def make_ast(token: Token, init: Callable[..., ast.AST], **kwargs) -> ast.AST:
    return init(**kwargs, lineno=token.line_number, col_offset=token.position)


def make_ast_from_source(token: Token, source: str) -> ast.AST:
    node, = ast.parse(source).body
    node.lineno = token.line_number
    node.col_offset = token.position
    return ast.fix_missing_locations(node)


def make_name(name_token: Token, custom_name: Optional[str] = None, ctx=ast.Load()) -> ast.AST:
    assert custom_name or name_token.type_ == TokenType.IDENTIFIER
    return make_ast(name_token, ast.Name, id=(custom_name or name_token.value), ctx=ctx)


def make_function(
    function_token: Token,
    name: str,
    body: List[ast.AST],
    args: List[ast.AST] = None,
    returns=None,
    decorator_list: List[ast.AST] = None,
) -> ast.AST:
    return make_ast(
        function_token,
        ast.FunctionDef,
        name=name,
        args=ast.arguments(args=(args or []), vararg=None, kwonlyargs=[], kw_defaults=[], kwarg=None, defaults=[]),
        body=body,
        decorator_list=(decorator_list or []),
        returns=returns,
    )


def set_store_context(node: ast.AST, assignment_token: Token) -> ast.AST:
    if not hasattr(node, 'ctx'):
        as3.parser.raise_syntax_error(f"{ast.dump(node)} can't be assigned to", assignment_token)
    node.ctx = ast.Store()
    return node
