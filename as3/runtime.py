from __future__ import annotations

from typing import Any, Tuple

from as3 import stdlib
from as3.exceptions import ASReferenceError


class ASUndefined:
    def __repr__(self) -> str:
        return 'undefined'


def resolve_property(where: Any, name: str) -> Tuple[dict, str]:
    where_, name_ = where, name
    while where is not None:
        try:
            # First try find it in own properties.
            return resolve_own_property(where, name_)
        except ASReferenceError:
            try:
                container, name = resolve_own_property(where, '__proto__')
            except ASReferenceError:
                break  # no prototype
            else:
                where = container[name]  # go to the prototype
    raise ASReferenceError(f'property `{name_!r}` is not found in the prototype chain of `{where_!r}`')


def resolve_own_property(where: Any, name: str) -> Tuple[dict, str]:
    try:
        where[name]
    except (TypeError, KeyError):
        pass
    else:
        return where, name
    try:
        getattr(where, name)
    except AttributeError:
        pass
    else:
        return where.__dict__, name
    raise ASReferenceError(f'property `{name!r}` is not found in `{where!r}`')


def push_environment(environment: dict) -> dict:
    return {'__proto__': environment}


undefined = ASUndefined()

global_environment = {
    'Array': list,
    'Boolean': bool,
    'Exception': Exception,
    'int': int,
    'Math': stdlib.Math,
    'Number': float,
    'Object': dict,
    'ReferenceError': ASReferenceError,
    'String': str,
    'trace': print,
    'uint': int,
    'Vector': list,
}
