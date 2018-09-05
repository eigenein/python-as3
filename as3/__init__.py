from __future__ import annotations

from ast import AST
from types import CodeType
from typing import Optional, TextIO, Union

from as3.parser import Parser
from as3.scanner import scan


def parse_script(source: str) -> AST:
    return Parser(scan(source)).parse_script()


def compile_script(source: str, filename: str) -> CodeType:
    return compile(parse_script(source), filename, 'exec')


def execute_script(
    source: str,
    filename: str,
    globals_: Optional[dict] = None,
    locals_: Optional[dict] = None,
) -> CodeType:
    code = compile_script(source, filename)
    exec(code, globals_, locals_)
    # FIXME: only exports should be allowed in `globals_` on exit.
    return code
