from __future__ import annotations

import math
from ast import Expression
from collections import namedtuple
from io import StringIO
from typing import Any, Dict

import pytest

from as3 import execute_script
from as3.enums import ContextType
from as3.exceptions import ASSyntaxError
from as3.parser import Context, Parser
from as3.scanner import Scanner

context = Context(ContextType.CODE_BLOCK)


@pytest.mark.parametrize('expression, expected', [
    ('42', 42),
    ('2 + 2', 4),
    ('2 + 2 * 2', 6),
    ('(2 + 2) * 2', 8),
    ('str(2)', '2'),
    ('math.fabs(-2)', 2),
    ('math.acos.__name__', 'acos'),
    ('foo.baz + foo.baz * foo.baz', 6),
    ('(foo.baz + foo.baz) * foo.baz', 8),
    ('bar(2, 42)', 44),
    ('baz()', 42),
    ('false', False),
    ('true', True),
])
def test_expression(expression: str, expected: Any):
    actual = eval(compile(Expression(Parser(Scanner(StringIO(expression))).parse_expression(context)), '<ast>', 'eval'), {
        'foo': namedtuple('Foo', 'bar baz')(bar=42, baz=2),
        'math': math,
        'bar': lambda a, b: a + b,
        'baz': lambda: 42,
    })
    assert actual == expected, f'actual: {actual}'


@pytest.mark.parametrize('script, expected', [
    ('a = 1 + 1;', {}),
    ('a = 42;', {'a': 42}),
    ('a = 42; b = 3', {'a': 42, 'b': 3}),
    ('a = b = 42;', {'a': 42, 'b': 42}),
    ('a = 42; a += 1;', {'a': 43}),
    ('foo(42);', {}),
    ('function bar() { return 42 }; a = bar()', {'a': 42}),
    ('function bar() { function baz() { return 42 }; return baz; }; a = bar()()', {'a': 42}),
    ('class X { function X() { this.a = 42 } function baz() { return this.a; } }; a = X().baz()', {'a': 42}),
])
def test_execute_script(script: str, expected: Dict[str, Any]):
    globals_ = {
        'foo': lambda x: x,
    }
    execute_script(script, '<ast>', globals_)
    for key, value in expected.items():
        assert globals_[key] == value, f'actual: {globals_[key]}'


@pytest.mark.parametrize('script', [
    'a = 1 = b;',
    'a += b += a;',
])
def test_execute_script_syntax_error(script: str):
    with pytest.raises(ASSyntaxError):
        execute_script(script, '<ast>')


@pytest.mark.parametrize('expression', [
    '2 +',
    'abs(',
    'abs((',
    'math..abs',
])
def test_expression_syntax_error(expression: str):
    with pytest.raises(ASSyntaxError):
        Parser(Scanner(StringIO(expression))).parse_expression(context)
