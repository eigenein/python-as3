from __future__ import annotations

from collections import deque
from typing import Deque, Iterable, Iterator, TypeVar

T = TypeVar('T')


class Peekable(Iterable[T]):
    def __init__(self, iterable: Iterable[T]) -> None:
        self.iterator = iter(iterable)
        self.cache: Deque[T] = deque()

    def __iter__(self) -> Iterator[T]:
        return self

    def __next__(self) -> T:
        self.peek()
        return self.cache.popleft()

    def __bool__(self):
        try:
            self.peek()
        except StopIteration:
            return False
        else:
            return True

    def peek(self) -> T:
        if not self.cache:
            self.cache.append(next(self.iterator))
        return self.cache[0]
