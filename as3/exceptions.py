from __future__ import annotations

from typing import Any


class ASSyntaxError(Exception):
    def __init__(self, message: str) -> None:
        super().__init__(message)


class ASReturn(Exception):
    def __init__(self, value: Any) -> None:
        self.value = value


class ASReferenceError(Exception):
    def __init__(self, message: str) -> None:
        super().__init__(message)
