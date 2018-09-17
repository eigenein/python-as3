"""
Classes and functions needed for transpiled code execution.
This includes internal constructs as well as parts of standard ActionScript library.
"""

from __future__ import annotations

import inspect
import math
from functools import partial
from pathlib import Path
from typing import Any, Dict, List, NoReturn, Tuple
from unittest.mock import Mock

import as3
from as3 import constants


# FIXME: https://www.adobe.com/devnet/actionscript/learning/as3-fundamentals/associative-arrays.html
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


# FIXME: unsigned overflow.
class ASUnsignedInteger(int, ASObject):
    __alias__ = 'uint'
    __default__ = 0


class ASString(str, ASObject):
    __alias__ = 'String'


class ASNumber(float, ASObject):
    __alias__ = 'Number'
    __default__ = math.nan


class ASArray(list, ASObject):
    __alias__ = 'Array'


class ASError(Exception, ASObject):
    __alias__ = 'Error'


# ActionScript standard classes and methods.
# ----------------------------------------------------------------------------------------------------------------------


class Math:
    POSITIVE_INFINITY = ASNumber(math.inf)

    abs = math.fabs
    acos = math.acos


# Runtime functions.
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


def import_name(*args: str) -> None:
    """
    Implements the `import` statement.
    """
    # Inject names into the locals.
    frame = inspect.stack()[1].frame
    import_cache = frame.f_globals[constants.import_cache_name]
    value = import_cache.get(args)

    # Mock UI classes.
    if value is None and constants.mocked_imports.match('.'.join(args)):
        value = Mock()
        value.__default__ = None  # type: ignore

    # Standard library.
    # FIXME: look up `'.'.join(args)` in globals instead.
    if value is None:
        value = standard_imports.get(args)

    # Search the name in the global cache.
    if value is None:
        packages_path: Path = frame.f_globals[constants.packages_path_name]
        script_path = packages_path

        # Locate the file.
        for arg in args:
            if arg != '*':
                script_path = script_path / arg
            else:
                raise NotImplementedError('star import is not implemented')  # TODO

        # We need a script with the same name.
        script_path = script_path.with_suffix(constants.actionscript_suffix)
        script_globals = as3.execute_script(
            script_path.read_text(),
            filename=str(script_path),
            **{constants.packages_path_name: packages_path},
        )
        value = import_cache[args] = script_globals[args[-1]]

    frame.f_locals[args[-1]] = value


def push(value: Any):
    locals_ = inspect.stack()[1].frame.f_locals
    if constants.operand_stack_name not in locals_:
        locals_[constants.operand_stack_name] = []
    stack: List[Any] = locals_[constants.operand_stack_name]
    stack.append(value)


def pop() -> Any:
    return inspect.stack()[1].frame.f_locals[constants.operand_stack_name].pop()


# Interpreter globals.
# ----------------------------------------------------------------------------------------------------------------------

def raise_not_implemented_error(name: str, *args: Any) -> NoReturn:
    raise NotImplementedError(f'not implemented: {name}{args}')


default_globals: Dict[str, Any] = {
    # Internal interpreter names.
    '__dir__': dir,
    '__globals__': globals,
    constants.import_name: import_name,
    constants.packages_path_name: Path.cwd(),
    constants.resolve_name: resolve_name,

    # Standard names.
    'Math': Math,
    'trace': print,
    ASAny.__alias__: ASAny,
    ASArray.__alias__: ASArray,  # FIXME: https://www.adobe.com/devnet/actionscript/learning/as3-fundamentals/associative-arrays.html
    ASError.__alias__: ASError,
    ASInteger.__alias__: ASInteger,
    ASNumber.__alias__: ASNumber,
    ASObject.__alias__: ASObject,
    ASString.__alias__: ASString,
    ASUnsignedInteger.__alias__: ASUnsignedInteger,
    str(ASAny()): ASAny(),

    # FFDec decompilation quirks.
    '§§dup': partial(raise_not_implemented_error, '§§dup'),
    '§§goto': partial(raise_not_implemented_error, '§§goto'),
    '§§nextname': partial(raise_not_implemented_error, '§§nextname'),
    '§§pop': pop,
    '§§push': push,
}

# FIXME: move to globals.
standard_imports: Dict[Tuple[str, ...], Any] = {
    ('flash', 'utils', 'getQualifiedClassName'): partial(raise_not_implemented_error, 'getQualifiedClassName'),
    ('flash', 'utils', 'setInterval'): partial(raise_not_implemented_error, 'setInterval'),
    ('flash', 'utils', 'setTimeout'): partial(raise_not_implemented_error, 'setTimeout'),
}
