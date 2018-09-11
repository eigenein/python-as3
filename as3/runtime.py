"""
Classes and functions needed for transpiled code execution.
This includes internal constructs as well as parts of standard ActionScript library.
"""

from __future__ import annotations

import inspect
import math
from typing import Any, Dict

from as3.constants import this_name


class ASObject:
    """
    Base class for all built ActionScript classes. Also known as `Object`.
    """

    __default__: Any = None


class ASAny(ASObject):
    """
    Not declared (equivalent to type annotation `*`).
    """
    def __new__(cls):
        # `ASAny` produces singleton `undefined` value.
        if cls.__default__ is None:
            cls.__default__ = super().__new__(cls)
        return cls.__default__

    def __eq__(self, other: Any) -> bool:
        return isinstance(other, ASAny)

    def __hash__(self) -> int:
        return 0

    def __repr__(self) -> str:
        return 'undefined'


class ASInteger(int, ASObject):
    """
    `int`.
    """

    __default__ = 0


class ASString(str, ASObject):
    pass  # TODO


class ASNumber(float, ASObject):
    """
    `Number`.
    """

    __default__ = math.nan

    pass  # TODO


# ActionScript standard library.
# ----------------------------------------------------------------------------------------------------------------------


class Math:
    POSITIVE_INFINITY = ASNumber(math.inf)

    abs = math.fabs
    acos = math.acos


# Runtime utilities.
# ----------------------------------------------------------------------------------------------------------------------

class AttributeDict:
    """
    Allows access to a dictionary via attributes.
    """

    def __init__(self, dict_: dict) -> None:
        self.__dict__['__wrapped_dict__'] = dict_

    def __getattr__(self, item) -> Any:
        return self.__wrapped_dict__[item]

    def __setattr__(self, key, value):
        self.__wrapped_dict__[key] = value


def resolve_name(name: str) -> Any:
    """
    Find a scope which contains the specified name.
    """
    frame = inspect.stack()[1].frame
    # First, looking at the local scope.
    if name in frame.f_locals:
        return AttributeDict(frame.f_locals)
    # Then, look into `this`.
    if this_name in frame.f_locals:
        this = frame.f_locals[this_name]
        class_ = type(this)
        if name in class_.__dict__:
            return class_
        if name in this.__dict__:
            return this
    # And the last attempt is globals.
    if name in frame.f_globals:
        return AttributeDict(frame.f_globals)
    raise NameError(f'unable to resolve name "{name}"')


default_globals: Dict[str, Any] = {
    # Internal interpreter names.
    '__dir__': dir,
    '__globals__': globals,
    '__resolve__': resolve_name,

    # Standard names.
    'int': ASInteger,
    'Math': Math,
    'String': str,  # FIXME: `ASString`.
    'null': None,
    'trace': print,
    'undefined': ASAny(),

    # Standard types.
    ASAny.__name__: ASAny,
    ASObject.__name__: ASObject,
}
