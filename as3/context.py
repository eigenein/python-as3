from __future__ import annotations

import ast
from dataclasses import dataclass, field, replace
from typing import List, Optional


@dataclass
class Context:
    """
    Represents the current parser context.
    """
    package_name: Optional[str] = None
    class_name: Optional[str] = None
    constructor: Optional[ConstructorContext] = None

    def make_inner(self) -> Context:
        return replace(self)


@dataclass
class ConstructorContext:
    internal_body: List[ast.AST] = field(default_factory=list)
    node: Optional[ast.AST] = None
    is_super_called: bool = False
