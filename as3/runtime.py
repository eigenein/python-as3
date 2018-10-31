from __future__ import annotations

from dataclasses import dataclass
from typing import Any

from as3 import stdlib
from as3.exceptions import ASReferenceError


@dataclass
class ResolvedTarget:
    where: dict
    name: str

    @property
    def value(self) -> Any:
        return self.where[self.name]

    @value.setter
    def value(self, value: Any):
        self.where[self.name] = value


class ASUndefined:
    def __repr__(self) -> str:
        return 'undefined'


def resolve_property(where: Any, name: str) -> ResolvedTarget:
    where_, name_ = where, name
    while where is not None:
        try:
            # First try find it in own properties.
            return resolve_own_property(where, name_)
        except ASReferenceError:
            try:
                resolved_proto = resolve_own_property(where, '__proto__')
            except ASReferenceError:
                break  # no prototype
            else:
                where = resolved_proto.value  # go to the prototype
    raise ASReferenceError(f'property `{name_!r}` is not found in the prototype chain of `{where_!r}`')


def resolve_own_property(where: Any, name: str) -> ResolvedTarget:
    try:
        where[name]
    except (TypeError, KeyError):
        pass
    else:
        return ResolvedTarget(where=where, name=name)
    try:
        getattr(where, name)
    except AttributeError:
        pass
    else:
        return ResolvedTarget(where=where.__dict__, name=name)
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
