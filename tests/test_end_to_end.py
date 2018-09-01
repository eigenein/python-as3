from __future__ import annotations

from ast import Expression
from collections import namedtuple
from io import StringIO
from typing import Any, Dict

from pytest import mark, raises

from as3 import execute_script
from as3.examples import bad_scripts, expressions, scripts
from as3.exceptions import ASSyntaxError
from as3.parser import Parser
from as3.runtime import default_globals
from as3.scanner import Scanner


@mark.parametrize('expression, expected', expressions)
def test_expression(expression: str, expected: Any):
    actual = eval(compile(Expression(Parser(Scanner(StringIO(expression))).parse_expression()), '<ast>', 'eval'), {
        **default_globals,
        'foo': namedtuple('Foo', 'bar baz')(bar=42, baz=2),
        'bar': lambda a, b: a + b,
        'baz': lambda: 42,
    })
    assert actual == expected, f'actual: {actual}'


@mark.parametrize('expression', [
    '2 +',
    'abs(',
    'abs((',
    'math..abs',
])
def test_parse_expression_syntax_error(expression: str):
    with raises(ASSyntaxError):
        Parser(Scanner(StringIO(expression))).parse_expression()


@mark.parametrize('script, expected', scripts + bad_scripts)
def test_execute_script(script: str, expected: Dict[str, Any]):
    globals_ = {
        **default_globals,
        'foo': lambda x: x,
    }
    execute_script(script, '<ast>', globals_)
    for key, value in expected.items():
        assert globals_[key] == value, f'actual: {globals_[key]}'


@mark.parametrize('script', [
    'a = 1',
    '{ var a = 42; } trace(a);',
    '{ var a = 42; } a = 43;',
])
def test_execute_script_name_error(script: str):
    with raises(NameError):
        execute_script(script, '<ast>')
