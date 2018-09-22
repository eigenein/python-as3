from __future__ import annotations

from typing import Any, Dict

from as3 import stdlib
from as3.ast_ import AST
from as3.interpreter import evaluate
from as3.parser import Parser
from as3.scanner import scan

filename_ = '<ast>'


def parse(source: str, filename: str = filename_) -> Parser:
    return Parser(scan(source, filename), filename)


def parse_script(source: str, filename: str = filename_) -> AST:
    return parse(source, filename).parse_script()


def parse_expression(source: str, filename: str = filename_) -> AST:
    return parse(source, filename).parse_expression()


# noinspection PyDefaultArgument
def evaluate_expression(source: str, filename: str = filename_, override_globals: Dict[str, Any] = {}) -> Any:
    return evaluate(parse_expression(source, filename), {**stdlib.names, **override_globals})
