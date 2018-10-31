from __future__ import annotations

import gzip
import json
from pathlib import Path

import requests

packages_path = Path('tests/scripts')
import_cache = {}

TowerBattleThread = import_qualified_name('game.battle.controller.thread.TowerBattleThread', packages_path, import_cache)
GameContext = import_qualified_name('engine.context.GameContext', packages_path, import_cache)
GameContext.instance.libStaticData = ASObject.from_dict(json.loads(gzip.decompress(requests.get('https://heroes.cdnvideo.ru/vk/v0433/lib/lib.json.gz').content).decode()))
DataStorage = import_qualified_name('game.data.storage.DataStorage', packages_path, import_cache)
# DataStorage(GameContext.instance.libStaticData)
DataStorage.battleConfig.init(GameContext.instance.libStaticData['battleConfig'])
TowerBattleThread({})
