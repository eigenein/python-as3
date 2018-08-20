from __future__ import annotations


class ASSyntaxError(Exception):
    def __init__(self, message: str):
        super().__init__(message)
