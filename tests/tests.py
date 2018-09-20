from __future__ import annotations

from collections import namedtuple
from typing import Any, Dict

from pytest import mark, param, raises

from as3 import evaluate_expression, execute_script, parse_expression
from as3.examples import bad_scripts, expressions, scripts
from as3.exceptions import ASSyntaxError


@mark.parametrize('expression, expected', expressions)
def test_evaluate_expression(expression: str, expected: Any):
    actual = evaluate_expression(
        expression,
        foo=namedtuple('Foo', 'bar baz')(bar=42, baz=2),
        bar=lambda a, b: a + b,
        baz=lambda: 42,
    )
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
        parse_expression(expression, '<ast>')


@mark.parametrize('script, expected', scripts + bad_scripts)
def test_execute_script(script: str, expected: Dict[str, Any]):
    class FakeException(Exception):
        pass
    globals_ = execute_script(script, foo=lambda x: x, dict_={}, FakeException=FakeException)
    for key, value in expected.items():
        assert globals_[key] == value, f'{key}: actual: {globals_[key]}'


@mark.parametrize('script', [
    param('a = 1'),
    param('{ var a = 42; } trace(a);', marks=mark.xfail),
    param('{ var a = 42; } a = 43;', marks=mark.xfail),
])
def test_execute_script_name_error(script: str):
    with raises(NameError):
        execute_script(script)
