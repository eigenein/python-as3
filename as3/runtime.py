"""
Classes and functions needed for transpiled code execution.
This includes internal constructs as well as parts of standard ActionScript library.
"""

from __future__ import annotations

import inspect
import traceback
from contextlib import suppress
from functools import partial
from pathlib import Path
from typing import Any, Callable, Dict, List, NoReturn, Tuple, Type
from unittest.mock import Mock

import as3
from as3 import constants, stdlib


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

    def __init__(self, initializer: Callable[[stdlib.ASObject], Any]) -> None:
        self.initializer = initializer

    def __set_name__(self, instance: stdlib.ASObject, name: str) -> None:
        self.name = stdlib.ASString(name)

    def __get__(self, instance: stdlib.ASObject, type_: Type[stdlib.ASObject]) -> Any:
        if instance is None:
            raise AttributeError(f'{self.name} is not a static field')
        if self.name not in instance.__dict__:
            # First reference.
            instance.__dict__[self.name] = self.initializer(instance)
        return instance.__dict__[self.name]

    def __set__(self, instance: Any, value: Any) -> Any:
        instance.__dict__[self.name] = value


class ClassProperty:
    def __init__(self, getter: Callable[[Type[stdlib.ASObject]], Any]) -> None:
        self.getter = getter

    def __get__(self, instance: stdlib.ASObject, type_: Type[stdlib.ASObject]) -> Any:
        return self.getter(type_)


class StaticField:
    uninitialized = object()

    def __init__(self, initializer: Callable[[Any], Any]) -> None:
        self.initializer = initializer
        self.value: Any = self.uninitialized

    def __get__(self, instance: stdlib.ASObject, type_: Type[stdlib.ASObject]) -> Any:
        if self.value is self.uninitialized:
            self.value = self.initializer(type_)
        return self.value

    def __set__(self, instance: stdlib.ASObject, value: Any) -> None:
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

    # Try to import the name.
    with suppress(ImportError):
        import_name((name,), frame)
        return NamespaceObject(frame.f_locals)  # `import_name` imported it into the locals

    # noinspection PyUnreachableCode, PyUnresolvedReferences
    raise NameError(f'unable to resolve name "{name}"')


TParts = Tuple[str, ...]


def import_(*parts: str) -> None:
    """Implements `import` statement."""
    frame = inspect.stack()[1].frame
    frame.f_globals.setdefault(constants.imports_key, {})
    frame.f_globals[constants.imports_key][parts[-1]] = parts


def import_name(parts: TParts, frame: Any) -> None:
    """Actually imports the name."""
    import_cache: Dict[TParts, Any] = frame.f_globals[constants.import_cache_key]
    packages_path: Path = frame.f_globals[constants.packages_path_key]
    frame.f_globals.setdefault(constants.imports_key, {})
    imports: Dict[str, TParts] = frame.f_globals[constants.imports_key]

    if len(parts) == 1:
        # It's imported with `import` statement.
        parts = imports.get(parts[0], parts)

    value = import_cache.get(parts)
    if value is None:
        value = standard_imports.get(parts)
    if value is None and constants.mocked_imports.match('.'.join(parts)):
        value = Mock()
    if value is None and len(parts) == 1:
        # Imports from the same package are implicit.
        value = import_from_same_package(parts[0], packages_path, Path(inspect.getframeinfo(frame).filename), import_cache)
    if value is None:
        # Qualified name.
        value = import_from_file(parts, packages_path, import_cache)

    if value is None:
        raise ImportError(f'could not find {".".join(parts)}')
    frame.f_locals[parts[-1]] = value


def import_from_same_package(name: str, packages_path: Path, caller_path: Path, import_cache: Dict[TParts, Any]) -> Any:
    if not (caller_path.parent / name).with_suffix(constants.actionscript_suffix).exists():
        return None
    with suppress(ValueError):
        parts = (*caller_path.relative_to(packages_path).parent.parts, name)
        return import_from_file(parts, packages_path, import_cache)


def import_from_file(parts: TParts, packages_path: Path, import_cache: Dict[TParts, Any]) -> Any:
    assert parts not in import_cache, f'`{".".join(parts)}` is being imported but already cached'

    # Locate the file.
    path = packages_path
    for arg in parts:
        if arg != '*':
            path = path / arg
        else:
            raise NotImplementedError('star import is not implemented')  # TODO

    # We need a script with the same name.
    path = path.with_suffix(constants.actionscript_suffix)
    if not path.exists():
        return None

    # Import-related globals.
    globals_ = {constants.import_cache_key: import_cache, constants.packages_path_key: packages_path}

    output_globals = as3.execute_script(path.read_text(), filename=str(path), **globals_)
    value = import_cache[parts] = output_globals[parts[-1]]
    return value


def push(value: Any):
    locals_ = inspect.stack()[1].frame.f_locals
    if constants.operand_stack_key not in locals_:
        locals_[constants.operand_stack_key] = []
    stack: List[Any] = locals_[constants.operand_stack_key]
    stack.append(value)


def pop() -> Any:
    return inspect.stack()[1].frame.f_locals[constants.operand_stack_key].pop()


def raise_not_implemented_error(name: str, *args: Any) -> NoReturn:
    raise NotImplementedError(f'not implemented: {name}{args}')


default_globals: Dict[str, Any] = {
    # Helper names.
    '__dir__': dir,
    '__globals__': globals,
    '__hasattr__': hasattr,
    '__print_stack__': traceback.print_stack,

    # Internal interpreter names.
    constants.class_property_key: ClassProperty,
    constants.field_key: Field,
    constants.import_key: import_,
    constants.packages_path_key: Path.cwd(),
    constants.resolve_key: resolve_name,
    constants.static_field_key: StaticField,

    # Standard names.
    'Math': stdlib.ASMath,
    'trace': print,
    'undefined': stdlib.undefined,
    'Vector': stdlib.ASArray,  # for our needs let's use the same implementation
    stdlib.ASArray.__alias__: stdlib.ASArray,
    stdlib.ASBoolean.__alias__: stdlib.ASBoolean,
    stdlib.ASError.__alias__: stdlib.ASError,
    stdlib.ASNumber.__alias__: stdlib.ASNumber,
    stdlib.ASString.__alias__: stdlib.ASString,
    stdlib.ASInteger.__alias__: stdlib.ASInteger,
    stdlib.ASObject.__alias__: stdlib.ASObject,
    stdlib.ASUnsignedInteger.__alias__: stdlib.ASUnsignedInteger,

    # FFDec decompilation quirks.
    '§§dup': partial(raise_not_implemented_error, '§§dup'),
    '§§goto': partial(raise_not_implemented_error, '§§goto'),
    '§§nextname': partial(raise_not_implemented_error, '§§nextname'),
    '§§pop': pop,
    '§§push': push,
}

standard_imports: Dict[TParts, Any] = {
    ('flash', 'display', 'MovieClip'): stdlib.ASObject,  # let's hope its implementation is not needed
    ('flash', 'utils', 'Dictionary'): stdlib.ASDictionary,
    ('flash', 'utils', 'getQualifiedClassName'): partial(raise_not_implemented_error, 'getQualifiedClassName'),
}
