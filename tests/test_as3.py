from __future__ import annotations

from pathlib import Path

from as3 import execute_script


def test_battle_core():
    execute_script((Path(__file__).parent / 'scripts' / 'battle' / 'BattleCore.as'), 'BattleCore.as')


def test_hero_collection():
    execute_script((Path(__file__).parent / 'scripts' / 'battle' / 'skills' / 'HeroCollection.as'), 'HeroCollection.as')


def test_ult_skill():
    execute_script((Path(__file__).parent / 'scripts' / 'battle' / 'skills' / 'UltSkill.as'), 'UltSkill.as')
