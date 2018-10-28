from __future__ import annotations

from pytest import mark, raises

from as3 import parse
from as3.exceptions import ASSyntaxError


@mark.parametrize('source', [
    '2 +',
    'abs(',
    'abs((',
    'math..abs',
])
def test_parse_syntax_error(source: str):
    with raises(ASSyntaxError):
        parse(source)
