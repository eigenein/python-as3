from __future__ import annotations

from dataclasses import dataclass, field
from typing import Dict, Any, Optional

from as3 import stdlib
from as3.exceptions import ASReferenceError


# TODO: still looks similar to a property resolution where parent is `__proto__`.
# TODO: perhaps make name resolution generic.
@dataclass
class Environment:
    """http://dmitrysoshnikov.com/ecmascript/javascript-the-core-2nd-edition/#environment"""

    values: Dict[str, Any] = field(default_factory=dict)
    parent: Optional[Environment] = None

    def __post_init__(self):
        self.values['__environment__'] = self

    def push(self, **values: Any) -> Environment:
        return Environment(parent=self, values=values)

    def resolve(self, name: str) -> Environment:
        environment: Optional[Environment] = self
        while environment is not None:
            if name in environment.values:
                return environment
            environment = environment.parent
        raise ASReferenceError(f'could not resolve `{name}`')


class ASUndefined:
    def __repr__(self) -> str:
        return 'undefined'


undefined = ASUndefined()

global_environment = Environment(values={
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
})
