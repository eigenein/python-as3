from __future__ import annotations

from ast import Expression
from collections import namedtuple
from typing import Any, Dict

from pytest import mark, param, raises

from as3 import default_globals, execute_script
from as3.examples import bad_scripts, expressions, scripts
from as3.exceptions import ASSyntaxError
from as3.parser import Parser
from as3.scanner import scan


@mark.parametrize('expression, expected', expressions)
def test_evaluate_expression(expression: str, expected: Any):
    actual = eval(compile(Expression(Parser(scan(expression)).parse_expression()), '<ast>', 'eval'), {
        **default_globals,
        'foo': namedtuple('Foo', 'bar baz')(bar=42, baz=2),
        'bar': lambda a, b: a + b,
        'baz': lambda: 42,
    })
    assert type(actual) == type(expected), f'actual: {actual!r}'
    assert actual == expected, f'actual: {actual!r}'


@mark.parametrize('expression', [
    '2 +',
    'abs(',
    'abs((',
    'math..abs',
])
def test_parse_expression_syntax_error(expression: str):
    with raises(ASSyntaxError):
        Parser(scan(expression)).parse_expression()


@mark.parametrize('script, expected', scripts + bad_scripts)
def test_execute_script(script: str, expected: Dict[str, Any]):
    globals_ = execute_script(script, '<ast>', foo=lambda x: x, dict_={})
    for key, value in expected.items():
        assert globals_[key] == value, f'actual: {globals_[key]}'


@mark.parametrize('script', [
    param('a = 1'),
    param('{ var a = 42; } trace(a);', marks=mark.xfail),
    param('{ var a = 42; } a = 43;', marks=mark.xfail),
])
def test_execute_script_name_error(script: str):
    with raises(NameError):
        execute_script(script, '<ast>')
