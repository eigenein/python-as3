from __future__ import annotations

from ast import parse

from pytest import mark

from as3.ast_ import has_super_call


@mark.parametrize('source, expected', [
    ('super().__init__(42)', True),
    ('42', False),
    ('super().foo()', False),
    ('A.__init()', False),
    ('def f(): super().__init__()', True),
])
def test_has_super_call(source: str, expected: bool):
    assert has_super_call(parse(source)) == expected
