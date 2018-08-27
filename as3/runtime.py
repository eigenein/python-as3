from __future__ import annotations

import inspect


class ASGlobals:
    """
    Provides access to globals of the caller via attributes.
    Used as a fallback value for `__this__` to lookup names in a global scope when referenced outside of a method.
    """

    def __getattr__(self, item):
        return inspect.stack()[1].frame.f_globals[item]

    def __setattr__(self, item, value):
        globals_ = inspect.stack()[1].frame.f_globals
        if item not in globals_:
            raise NameError(f'undefined name "{item}"')
        globals_[item] = value


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
        constructor = getattr(instance, cls.__name__)
        if constructor is not None:
            constructor(*args, **kwargs)
        return instance


class ASObject(metaclass=ASObjectMetaclass):
    """
    Base class for all built ActionScript classes.
    """

    default = None

    def __setattr__(self, key, value):
        # We need first to check if it's a "static field". Otherwise, we'll just add an attribute on the instance.
        if hasattr(self.__class__, key):
            setattr(self.__class__, key, value)
        elif hasattr(self, key):
            self.__dict__[key] = value
        else:
            # Ensure, we're not assigning to a new attribute. Everything should've been assigned in constructor.
            raise AttributeError(f'undefined field "{key}" in instance {self} of type {self.__class__}')


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


default_globals = {
    '__dir__': dir,
    '__globals__': globals,
    '__this__': ASGlobals(),
    'int': ASInteger,
    'String': str,  # FIXME: `ASString`.
    'trace': print,
    'undefined': ASAny.default,
    ASAny.__name__: ASAny,
    ASObject.__name__: ASObject,
}
