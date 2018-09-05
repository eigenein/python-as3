from __future__ import annotations


class ASSyntaxError(Exception):
    def __init__(self, *args):
        super().__init__(*args)
