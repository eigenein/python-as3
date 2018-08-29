from __future__ import annotations

import inspect
import math

from as3.constants import this_name


# ActionScript primitive data types.
# https://www.adobe.com/devnet/actionscript/learning/as3-fundamentals/data-types.html
# ----------------------------------------------------------------------------------------------------------------------

class ASObject:
    """
    Base class for all built ActionScript classes. Also known as `Object`.
    """

    __default__ = None


class ASAny(ASObject):
    """
    Not declared (equivalent to type annotation `*`).
    """
    def __new__(cls):
        # `ASAny` produces singleton `undefined` value.
        if cls.default is None:
            cls.default = super().__new__()
        return cls.default


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

class MathMetaclass(type):
    def __getattr__(self, item):
        # Let's hope the name matches.
        return getattr(math, item)


class Math(metaclass=MathMetaclass):
    POSITIVE_INFINITY = ASNumber(math.inf)

    abs = math.fabs


# Runtime utilities.
# ----------------------------------------------------------------------------------------------------------------------

def resolve_name(name: str) -> dict:
    """
    Find a scope which contains the specified name.
    """
    frame = inspect.stack()[1].frame
    # First, looking at the local scope.
    if name in frame.f_locals:
        return frame.f_locals
    # Then, look into `this`.
    if this_name in frame.f_locals:
        this = frame.f_locals[this_name]
        class_ = type(this)
        if name in class_.__dict__:
            return class_.__dict__
        if name in this.__dict__:
            return this.__dict__
    # And the last attempt is globals.
    if name in frame.f_globals:
        return frame.f_globals
    raise NameError(f'unable to resolve name "{name}"')


default_globals = {
    # Internal interpreter names.
    '__dir__': dir,
    '__globals__': globals,
    '__resolve__': resolve_name,

    # Standard names.
    'int': ASInteger,
    'Math': Math,
    'String': str,  # FIXME: `ASString`.
    'trace': print,
    'undefined': ASAny.__default__,

    # Standard types.
    ASAny.__name__: ASAny,
    ASObject.__name__: ASObject,
}
