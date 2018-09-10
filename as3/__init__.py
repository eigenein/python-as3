from __future__ import annotations

from ast import AST
from types import CodeType
from typing import Any, Dict

from as3.parser import Parser
from as3.runtime import default_globals
from as3.scanner import scan


def parse_script(source: str) -> AST:
    return Parser(scan(source)).parse_script()


def compile_script(source: str, filename: str) -> CodeType:
    return compile(parse_script(source), filename, 'exec')


def execute_script(source: str, filename: str, **override_globals: Any) -> Dict[str, Any]:
    code = compile_script(source, filename)
    globals_ = {**default_globals, **override_globals}
    exec(code, globals_)
    return globals_
