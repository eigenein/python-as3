from __future__ import annotations

import inspect

from as3.constants import this_name


class ASObjectMetaclass(type):
    """
    Handles proper initialisation of ActionScript objects.
    """

    # noinspection PyArgumentList
    def __call__(cls, *args, **kwargs):
        instance = cls.__new__(cls, *args, **kwargs)
        # Call the internal initializer.
        instance.__init__()
        # Call ActionScript constructor.
        constructor = getattr(instance, cls.__name__, None)
        if constructor is not None:
            constructor(*args, **kwargs)
        return instance


class ASObject(metaclass=ASObjectMetaclass):
    """
    Base class for all built ActionScript classes.
    """

    default = None


class ASAny(ASObject):
    def __new__(cls):
        # `ASAny` produces singleton `undefined` value.
        if cls.default is None:
            cls.default = super().__new__()
        return cls.default


class ASInteger(int, ASObject):
    default = 0


class ASString(str, ASObject):
    pass


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
    'String': str,  # FIXME: `ASString`.
    'trace': print,
    'undefined': ASAny.default,

    # Standard types.
    ASAny.__name__: ASAny,
    ASObject.__name__: ASObject,
}
