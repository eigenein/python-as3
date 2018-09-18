"""
Classes and functions needed for transpiled code execution.
This includes internal constructs as well as parts of standard ActionScript library.
"""

from __future__ import annotations

import inspect
import math
from contextlib import suppress
from functools import partial
from pathlib import Path
from typing import Any, Callable, Dict, List, NoReturn, Type
from unittest.mock import Mock

import as3
from as3 import constants


class ASObject(dict):
    """
    Base class for ActionScript classes. Behaves like an object and a map.
    """

    __alias__ = 'Object'
    __default__: Any = None

    def __init__(self, *args, **kwargs) -> None:
        super().__init__(*args, **kwargs)
        self.__dict__ = self


class ASUndefined:
    __alias__ = 'Any'
    __default__ = None

    def __new__(cls):
        # `undefined` is a singleton.
        if cls.__default__ is None:
            cls.__default__ = super().__new__(cls)
        return cls.__default__

    def __eq__(self, other: Any) -> bool:
        return isinstance(other, ASUndefined)

    def __hash__(self) -> int:
        return 0

    def __repr__(self) -> str:
        return 'undefined'


class ASInteger(int):
    __alias__ = 'int'
    __default__ = 0


# FIXME: unsigned overflow.
class ASUnsignedInteger(int):
    __alias__ = 'uint'
    __default__ = 0


class ASString(str):
    __alias__ = 'String'
    __default__ = None


class ASNumber(float):
    __alias__ = 'Number'
    __default__ = math.nan


class ASArray(list):
    """https://www.adobe.com/devnet/actionscript/learning/as3-fundamentals/arrays.html"""
    __alias__ = 'Array'
    __default__ = None


class ASError(Exception):
    __alias__ = 'Error'
    __default__ = None


# ActionScript standard classes and methods.
# ----------------------------------------------------------------------------------------------------------------------


class Math:
    POSITIVE_INFINITY = ASNumber(math.inf)

    abs = math.fabs
    acos = math.acos


# Runtime functions.
# ----------------------------------------------------------------------------------------------------------------------

class NamespaceObject:
    """
    Same as `ASObject` but wraps an external dictionary.
    """

    def __init__(self, dict_: dict) -> None:
        self.__dict__ = dict_


class Field:
    """
    Object field descriptor.
    """

    def __init__(self, initializer: Callable[[Any], Any]) -> None:
        self.initializer = initializer

    def __set_name__(self, instance: Any, name: str) -> None:
        self.name = name

    def __get__(self, instance: Any, type_: Type) -> Any:
        if instance is None:
            raise AttributeError(f'{self.name} is not a static field')
        if self.name not in instance.__dict__:
            # First reference.
            instance.__dict__[self.name] = self.initializer(instance)
        return instance.__dict__[self.name]

    def __set__(self, instance: Any, value: Any) -> Any:
        instance.__dict__[self.name] = value


class StaticField:
    undefined = object()

    def __init__(self, initializer: Callable[[Any], Any]) -> None:
        self.initializer = initializer
        self.value: Any = self.undefined

    def __get__(self, instance: Any, type_: Type) -> Any:
        if self.value is self.undefined:
            self.value = self.initializer(type_)
        return self.value

    def __set__(self, instance: Any, value: Any) -> None:
        self.value = value


def resolve_name(name: str) -> Any:
    """
    Find a scope which contains the specified name.
    """
    frame = inspect.stack()[1].frame

    # First, looking at the local scope.
    if name in frame.f_locals:
        return NamespaceObject(frame.f_locals)

    # Then, look into `this`.
    if constants.this_name in frame.f_locals:
        this = frame.f_locals[constants.this_name]
        with suppress(AttributeError):
            getattr(this, name)
            return this

    # Maybe it's in globals.
    if name in frame.f_globals:
        return NamespaceObject(frame.f_globals)

    # Try to import it from the current package.
    frame_info = inspect.getframeinfo(frame)
    packages_path: Path = frame.f_globals[constants.packages_path_name]
    try:
        qualified_name = (*Path(frame_info.filename).relative_to(packages_path).parent.parts, name)
        import_name(*qualified_name, frame_index=2)  # one frame is occupied with `resolve_name`
    except (ValueError, ImportError):
        pass
    else:
        return NamespaceObject(frame.f_locals)  # `import_name` imported it into the locals

    # Give up.
    raise NameError(f'unable to resolve name "{name}"')


def import_name(*args: str, frame_index: int = 1) -> Any:
    """
    Implements the `import` statement.
    """
    # Inject names into the locals.
    frame = inspect.stack()[frame_index].frame
    import_cache = frame.f_globals[constants.import_cache_name]

    # First, look it up in the import cache.
    value = import_cache.get(args)

    # Mock UI classes.
    if value is None and constants.mocked_imports.match('.'.join(args)):
        value = Mock()
        value.__default__ = None  # type: ignore

    # Standard library.
    if value is None:
        value = frame.f_globals[constants.standard_imports_name].get(args)

    # Search the name in the packages path.
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
        assert script_path != Path(inspect.getframeinfo(frame).filename), f'{script_path} tries to import itself'
        try:
            source = script_path.read_text()
        except FileNotFoundError:
            raise ImportError
        globals_ = {
            # Import-related globals.
            constants.import_cache_name: import_cache,
            constants.packages_path_name: packages_path,
        }
        output_globals = as3.execute_script(source, filename=str(script_path), **globals_)
        value = import_cache[args] = output_globals[args[-1]]

    frame.f_locals[args[-1]] = value
    return value


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
    # Helper names.
    '__dir__': dir,
    '__globals__': globals,

    # Internal interpreter names.
    constants.field_name: Field,
    constants.import_name: import_name,
    constants.packages_path_name: Path.cwd(),
    constants.resolve_name: resolve_name,
    constants.static_field_name: StaticField,

    # Standard names.
    'Math': Math,
    'trace': print,
    ASArray.__alias__: ASArray,
    ASError.__alias__: ASError,
    ASInteger.__alias__: ASInteger,
    ASNumber.__alias__: ASNumber,
    ASObject.__alias__: ASObject,
    ASString.__alias__: ASString,
    ASUndefined.__alias__: ASUndefined,
    ASUnsignedInteger.__alias__: ASUnsignedInteger,
    str(ASUndefined()): ASUndefined(),

    # FFDec decompilation quirks.
    '§§dup': partial(raise_not_implemented_error, '§§dup'),
    '§§goto': partial(raise_not_implemented_error, '§§goto'),
    '§§nextname': partial(raise_not_implemented_error, '§§nextname'),
    '§§pop': pop,
    '§§push': push,

    # Abuse globals for imports. This allows to override them.
    constants.standard_imports_name: {
        ('flash', 'utils', 'getQualifiedClassName'): partial(raise_not_implemented_error, 'getQualifiedClassName'),
        ('flash', 'utils', 'setInterval'): partial(raise_not_implemented_error, 'setInterval'),
        ('flash', 'utils', 'setTimeout'): partial(raise_not_implemented_error, 'setTimeout'),
    },
}
