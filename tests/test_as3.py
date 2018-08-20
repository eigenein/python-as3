from __future__ import annotations

from pathlib import Path

import pytest

from as3 import import_script


@pytest.mark.parametrize('param_1, param_2, expected', [
    (42, 0, 42),
])
def test_get_elemental_penetration(param_1: int, param_2: int, expected: int):
    # TODO: call the function.
    ast_ = import_script((Path(__file__).parent / 'scripts' / 'battle' / 'BattleCore.as').read_text(encoding='utf-8'))
    exec(compile(ast_, 'test', 'exec'))
