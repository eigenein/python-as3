from __future__ import annotations

import math


class ASObject(dict):
    """
    Base class for ActionScript classes. Behaves like an object and a map.
    """

    __alias__ = 'Object'

    def __init__(self, *args, **kwargs) -> None:
        super().__init__(*args, **kwargs)
        self.update(self.__dict__)  # preserve old values if `super()` is called after initialization
        self.__dict__ = self

    def __repr__(self) -> str:
        return 'undefined' if self is undefined else super().__repr__()


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


class ASBoolean(int):
    # `bool` can't be inherited.
    __alias__ = 'Boolean'

    def __repr__(self) -> str:
        return repr(bool(self))


class ASArray(list):
    """https://www.adobe.com/devnet/actionscript/learning/as3-fundamentals/arrays.html"""
    __alias__ = 'Array'


class ASError(Exception):
    __alias__ = 'Error'


class ASMath:
    POSITIVE_INFINITY = ASNumber(math.inf)

    abs = math.fabs
    acos = math.acos


class ASDictionary(dict):
    pass
