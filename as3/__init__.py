from __future__ import annotations

from typing import Any, Optional

from as3 import ast_, interpreter, stdlib
from as3.runtime import global_environment
from as3.parser import Parser
from as3.scanner import scan

filename_ = '<ast>'


def parse(source: str, filename: str = filename_) -> ast_.Block:
    return Parser(scan(source, filename), filename).parse_script()


def execute(source: str, filename: str = filename_, environment: Optional[dict] = None) -> Any:
    environment = environment or {}
    environment['__proto__'] = global_environment
    return interpreter.execute(parse(source, filename), environment)


__all__ = ['execute', 'parse']
