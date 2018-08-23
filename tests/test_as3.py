from __future__ import annotations

import math
from ast import Expression
from collections import namedtuple
from io import StringIO
from pathlib import Path
from typing import Any

import pytest

from as3.parser import Parser
from as3.scanner import Scanner
from as3 import execute_script


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
])
def test_expression(expression: str, expected: Any):
    actual = eval(compile(Expression(Parser(Scanner(StringIO(expression))).parse_expression()), '<ast>', 'eval'), {
        'foo': namedtuple('Foo', 'bar baz')(bar=42, baz=2),
        'math': math,
        'bar': lambda a, b: a + b,
    })
    assert actual == expected, f'actual: {actual}'


def test_battle_core():
    execute_script((Path(__file__).parent / 'scripts' / 'battle' / 'BattleCore.as'), 'BattleCore.as')


def test_hero_collection():
    execute_script((Path(__file__).parent / 'scripts' / 'battle' / 'skills' / 'HeroCollection.as'), 'HeroCollection.as')


def test_ult_skill():
    execute_script((Path(__file__).parent / 'scripts' / 'battle' / 'skills' / 'UltSkill.as'), 'UltSkill.as')
