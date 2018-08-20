from __future__ import annotations

from ast import AST
from io import StringIO

from as3.parser import Parser
from as3.scanner import Scanner


def import_script(script: str) -> AST:
    return Parser(Scanner(StringIO(script))).parse_script()
