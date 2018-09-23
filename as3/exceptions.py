from __future__ import annotations

from typing import Any


class ASSyntaxError(Exception):
    def __init__(self, message: str) -> None:
        super().__init__(message)


class ASRuntimeError(Exception):
    def __init__(self, exception_object: Any) -> None:
        self.exception_object = exception_object


class ASReturn(Exception):
    def __init__(self, value: Any) -> None:
        self.value = value
