from __future__ import annotations

import math
from contextlib import suppress
from typing import Any


class ASObject(dict):
    """
    Base class for ActionScript classes. Behaves like an object and a map.
    """

    __alias__ = 'Object'

    @staticmethod
    def from_dict(dict_: dict) -> ASObject:
        return ASObject({
            key: (
                ASObject.from_dict(value) if isinstance(value, dict) else
                ASBoolean(value) if isinstance(value, bool) else
                ASInteger(value) if isinstance(value, int) else
                ASNumber(value) if isinstance(value, float) else
                ASString(value) if isinstance(value, str) else
                ASArray(*value) if isinstance(value, list) else
                value
            ) for key, value in dict_.items()}
        )

    def __init__(self, *args, **kwargs) -> None:
        super().__init__(*args, **kwargs)
        self.update(self.__dict__)  # preserve old values if `super()` is called after initialization
        self.__dict__ = self

    def __repr__(self) -> str:
        return 'undefined' if self is undefined else super().__repr__()

    # noinspection PyPep8Naming
    def hasOwnProperty(self, name: str) -> ASBoolean:
        # FIXME: should not take parent classes into account.
        with suppress(AttributeError):
            getattr(self, name)
        return ASBoolean(name in self)


undefined = ASObject()


class ASInteger(int):
    __alias__ = 'int'


class ASUnsignedInteger(int):
    # FIXME: unsigned overflow.
    __alias__ = 'uint'


class ASString(str):
    __alias__ = 'String'


class ASNumber(float):
    __alias__ = 'Number'

    def __new__(cls, *args) -> Any:
        if not args:
            return super().__new__(cls)
        value, = args
        try:
            return super().__new__(cls, float(value))
        except TypeError:
            return undefined


class ASBoolean(int):
    # `bool` can't be inherited.
    __alias__ = 'Boolean'

    def __repr__(self) -> str:
        return repr(bool(self))


class ASArray(list):
    """https://www.adobe.com/devnet/actionscript/learning/as3-fundamentals/arrays.html"""
    __alias__ = 'Array'

    def __init__(self, *args):
        super().__init__(args)


class ASError(Exception):
    __alias__ = 'Error'


class ASMath:
    POSITIVE_INFINITY = ASNumber(math.inf)

    abs = math.fabs
    acos = math.acos


class ASDictionary(dict):
    pass
