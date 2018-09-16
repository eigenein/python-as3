from __future__ import annotations

from ast import AST, Expression
from types import CodeType
from typing import Any, Dict

from as3.parser import Parser
from as3.runtime import default_globals
from as3.scanner import scan


def parse(source: str) -> Parser:
    return Parser(scan(source))


def parse_script(source: str) -> AST:
    return parse(source).parse_script()


def compile_script(source: str, filename: str = '<ast>') -> CodeType:
    return compile(parse_script(source), filename, 'exec')


def execute_script(source: str, filename: str = '<ast>', **override_globals: Any) -> Dict[str, Any]:
    globals_ = {**default_globals, **override_globals}
    exec(compile_script(source, filename), globals_)
    return globals_


def parse_expression(source: str) -> AST:
    return parse(source).parse_expression()


def compile_expression(source: str, filename: str = '<ast>') -> CodeType:
    return compile(Expression(parse_expression(source)), filename, 'eval')


def evaluate_expression(source: str, filename: str = '<ast>', **override_globals: Any) -> Dict[str, Any]:
    globals_ = {**default_globals, **override_globals}
    return eval(compile_expression(source, filename), globals_)
