from __future__ import annotations

from ast import AST
from io import StringIO
from types import CodeType
from typing import TextIO, Union, Optional
from pathlib import Path

from as3.parser import Parser
from as3.scanner import Scanner


def parse_script(script: Union[str, TextIO, Path]) -> AST:
    if isinstance(script, str):
        script = StringIO(script)
    elif isinstance(script, Path):
        script = script.open('rt', encoding='utf-8')
    return Parser(Scanner(script)).parse_script()


def compile_script(script: Union[str, TextIO, Path], filename: str) -> CodeType:
    return compile(parse_script(script), filename, 'exec')


def execute_script(
    script: Union[str, TextIO, Path],
    filename: str,
    globals_: Optional[dict] = None,
    locals_: Optional[dict] = None,
):
    exec(compile_script(script, filename), globals_, locals_)
