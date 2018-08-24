from __future__ import annotations

from ast import AST
from io import StringIO
from types import CodeType
from typing import TextIO, Union, Optional

from as3.parser import Parser
from as3.scanner import Scanner


def parse_script(script: Union[str, TextIO]) -> AST:
    if isinstance(script, str):
        script = StringIO(script)
    return Parser(Scanner(script)).parse_script()


def compile_script(script: Union[str, TextIO], filename: str) -> CodeType:
    return compile(parse_script(script), filename, 'exec')


def execute_script(
    script: Union[str, TextIO],
    filename: str,
    globals_: Optional[dict] = None,
    locals_: Optional[dict] = None,
) -> CodeType:
    code = compile_script(script, filename)
    exec(code, globals_, locals_)
    return code
