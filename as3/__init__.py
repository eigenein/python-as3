from __future__ import annotations

from typing import Any, Dict

from as3 import stdlib, ast_, interpreter
from as3.parser import Parser
from as3.scanner import scan

filename_ = '<ast>'


def parse(source: str, filename: str = filename_) -> ast_.Block:
    return Parser(scan(source, filename), filename).parse_script()


# noinspection PyDefaultArgument
def execute(source: str, filename: str = filename_, override_globals: Dict[str, Any] = {}) -> Any:
    return interpreter.execute(parse(source, filename), {**stdlib.names, **override_globals})
