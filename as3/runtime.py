"""
Classes and functions needed for transpiled code execution.
This includes internal constructs as well as parts of standard ActionScript library.
"""

from __future__ import annotations

import inspect
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

    def __init__(self, initializer: Callable[[Any], Any]) -> None:
        self.initializer = initializer

    def __set_name__(self, instance: stdlib.ASObject, name: str) -> None:
        self.name = stdlib.ASString(name)

    def __get__(self, instance: Any, type_: Type[stdlib.ASObject]) -> Any:
        if instance is None:
            raise AttributeError(f'{self.name} is not a static field')
        if self.name not in instance.__dict__:
            # First reference.
            instance.__dict__[self.name] = self.initializer(instance)
        return instance.__dict__[self.name]

    def __set__(self, instance: Any, value: Any) -> Any:
        instance.__dict__[self.name] = value


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

    # Try to import it from the current package.
    with suppress(ImportError):
        import_name(name, frame_index=2, lazy=False)  # one frame is occupied with `resolve_name`
        return NamespaceObject(frame.f_locals)  # `import_name` imported it into the locals

    # noinspection PyUnreachableCode, PyUnresolvedReferences
    raise NameError(f'unable to resolve name "{name}"')


def import_name(*parts: str, frame_index: int = 1, lazy: bool = True) -> Any:
    """
    Implements the `import` statement.
    """
    print(parts)

    # Inject names into the locals.
    frame = inspect.stack()[frame_index].frame
    import_cache: Dict[Tuple[str, ...], Any] = frame.f_globals[constants.import_cache_name]
    packages_path: Path = frame.f_globals[constants.packages_path_name]
    frame.f_globals.setdefault(constants.lazy_imports_name, {})
    lazy_imports: Dict[str, Tuple[str, ...]] = frame.f_globals[constants.lazy_imports_name]

    # First, look it up in the import cache.
    value = import_cache.get(parts)

    # Standard library.
    if value is None:
        value = frame.f_globals[constants.standard_imports_name].get(parts)

    # Mock UI classes.
    if value is None and constants.mocked_imports.match('.'.join(parts)):
        value = Mock()
        value.__default__ = None  # type: ignore

    # Search the name in the packages path.
    if value is None:
        if lazy:
            # Deal with circular imports: remember the location of the name and do actual import at the first reference.
            lazy_imports[parts[-1]] = parts
            return
        if len(parts) == 1:
            name, = parts
            if name in lazy_imports:
                # We remembered the full path earlier.
                parts = lazy_imports[name]
            else:
                # Look up in the same directory.
                frame_info = inspect.getframeinfo(frame)
                caller_path = Path(frame_info.filename)
                if (caller_path.parent / name).with_suffix(constants.actionscript_suffix).exists():
                    with suppress(ValueError):
                        parts = (*caller_path.relative_to(packages_path).parent.parts, name)
        value = import_name_from_file(*parts, packages_path=packages_path, import_cache=import_cache)

    frame.f_locals[parts[-1]] = value
    return value


def import_name_from_file(*parts: str, packages_path: Path, import_cache: Dict[Tuple[str, ...], Any]) -> Any:
    path = packages_path

    # Locate the file.
    for arg in parts:
        if arg != '*':
            path = path / arg
        else:
            raise NotImplementedError('star import is not implemented')  # TODO

    # We need a script with the same name.
    path = path.with_suffix(constants.actionscript_suffix)
    try:
        source = path.read_text()
    except FileNotFoundError:
        raise ImportError(f'could not find {".".join(parts)}')

    # Import-related globals.
    globals_ = {constants.import_cache_name: import_cache, constants.packages_path_name: packages_path}

    output_globals = as3.execute_script(source, filename=str(path), **globals_)
    value = import_cache[parts] = output_globals[parts[-1]]
    return value


def push(value: Any):
    locals_ = inspect.stack()[1].frame.f_locals
    if constants.operand_stack_name not in locals_:
        locals_[constants.operand_stack_name] = []
    stack: List[Any] = locals_[constants.operand_stack_name]
    stack.append(value)


def pop() -> Any:
    return inspect.stack()[1].frame.f_locals[constants.operand_stack_name].pop()


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

    # Abuse globals for imports. This allows to override them.
    constants.standard_imports_name: {
        ('flash', 'display', 'MovieClip'): stdlib.ASObject,  # let's hope its implementation is not needed
        ('flash', 'utils', 'Dictionary'): stdlib.ASDictionary,
        ('flash', 'utils', 'getQualifiedClassName'): partial(raise_not_implemented_error, 'getQualifiedClassName'),
    },
}
