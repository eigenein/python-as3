"""
Classes and functions needed for transpiled code execution.
This includes internal constructs as well as parts of standard ActionScript library.
"""

from __future__ import annotations

import inspect
import math
from pathlib import Path
from typing import Any, Dict

from as3 import constants


class ASObject:
    """
    Base class for all built ActionScript classes. Also known as `Object`.
    """

    __alias__ = 'Object'
    __default__: Any = None


class ASAny(ASObject):
    """
    Not declared (equivalent to type annotation `*`).
    """

    __alias__ = 'Any'

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
    __alias__ = 'int'
    __default__ = 0


class ASString(str, ASObject):
    __alias__ = 'String'


class ASNumber(float, ASObject):
    __alias__ = 'Number'
    __default__ = math.nan


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
    if constants.this_name in frame.f_locals:
        this = frame.f_locals[constants.this_name]
        class_ = type(this)
        if hasattr(class_, name):
            return class_
        if hasattr(this, name):
            return this
    # And the last attempt is globals.
    if name in frame.f_globals:
        return AttributeDict(frame.f_globals)
    raise NameError(f'unable to resolve name "{name}"')


default_globals: Dict[str, Any] = {
    # Internal interpreter names.
    '__dir__': dir,
    '__globals__': globals,
    constants.import_name: ...,  # TODO
    constants.packages_path_name: Path.cwd(),
    constants.resolve_name: resolve_name,

    # Standard names.
    'Math': Math,
    'null': None,
    'trace': print,
    ASInteger.__alias__: ASInteger,
    ASNumber.__alias__: ASNumber,
    ASString.__alias__: ASString,
    str(ASAny()): ASAny(),

    # Standard types.
    ASAny.__name__: ASAny,
    ASObject.__name__: ASObject,
}
