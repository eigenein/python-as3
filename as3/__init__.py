from __future__ import annotations

from ast import AST, Expression
from types import CodeType
from typing import Any, Dict

from as3 import constants
from as3.parser import Parser
from as3.runtime import default_globals
from as3.scanner import scan


def parse(source: str, filename: str) -> Parser:
    return Parser(scan(source, filename), filename)


def parse_script(source: str, filename: str) -> AST:
    return parse(source, filename).parse_script()


def compile_script(source: str, filename: str) -> CodeType:
    return compile(parse_script(source, filename), filename, 'exec')


def execute_script(source: str, filename: str = '<ast>', **override_globals: Any) -> Dict[str, Any]:
    globals_: Dict[str, Any] = {**default_globals, constants.import_cache_name: {}, **override_globals}
    exec(compile_script(source, filename), globals_)
    return globals_


def parse_expression(source: str, filename: str) -> AST:
    return parse(source, filename).parse_expression()


def compile_expression(source: str, filename: str) -> CodeType:
    return compile(Expression(parse_expression(source, filename)), filename, 'eval')


def evaluate_expression(source: str, filename: str = '<ast>', **override_globals: Any) -> Dict[str, Any]:
    globals_: Dict[str, Any] = {**default_globals, constants.import_cache_name: {}, **override_globals}
    return eval(compile_expression(source, filename), globals_)
