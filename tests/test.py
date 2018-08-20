from __future__ import annotations

import pytest

from as3 import import_script


@pytest.mark.parametrize('param_1, param_2, expected', [
    (42, 0, 42),
])
def test_get_elemental_penetration(param_1: int, param_2: int, expected: int):
    ...
