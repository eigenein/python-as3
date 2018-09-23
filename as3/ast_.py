from __future__ import annotations

from ast import literal_eval
from dataclasses import dataclass, field
from typing import List, Optional, Tuple, Any

from as3.scanner import Token

underscore = '_'


@dataclass
class AST:
    token: Optional[Token] = None


@dataclass
class Literal(AST):
    value: Any = None

    @staticmethod
    def from_(token: Token) -> Literal:
        # noinspection PyArgumentList
        return Literal(token=token, value=literal_eval(token.value))


null = Literal()


@dataclass
class Block(AST):
    body: List[AST] = field(default_factory=list)


@dataclass
class Pass(AST):
    pass


@dataclass
class If(AST):
    test: AST = null
    positive: AST = Pass()
    negative: AST = Pass()


@dataclass
class Return(AST):
    value: AST = null


@dataclass
class Break(AST):
    pass


@dataclass
class While(AST):
    test: AST = null
    body: AST = Pass()


@dataclass
class TryFinally(AST):
    body: AST = Pass()
    finally_: AST = Pass()
    excepts: List[AST] = field(default_factory=list)


@dataclass
class Name(AST):
    identifier: str = underscore

    @staticmethod
    def from_(token: Token) -> AST:
        # noinspection PyArgumentList
        return Name(token=token, identifier=token.value)


@dataclass
class Except(AST):
    variable_name: str = underscore
    exception_type: AST = Name(identifier='Exception')
    body: AST = Pass()


@dataclass
class Throw(AST):
    value: AST = null


@dataclass
class AbstractFor(AST):
    variable_name: str = underscore
    value: AST = null
    body: AST = Pass()


@dataclass
class For(AbstractFor):
    pass


@dataclass
class ForEach(AbstractFor):
    pass


@dataclass
class UnaryOperation(AST):
    value: AST = null


@dataclass
class PostfixOperation(AST):
    value: AST = null


@dataclass
class Property(AST):
    value: AST = null
    item: AST = null


@dataclass
class Call(AST):
    value: AST = null
    arguments: List[AST] = field(default_factory=list)


@dataclass
class BinaryOperation(AST):
    left: AST = null
    right: AST = null


@dataclass
class CompoundLiteral(AST):
    value: List[AST] = field(default_factory=list)


@dataclass
class MapLiteral(AST):
    value: List[Tuple[AST, AST]] = field(default_factory=list)


@dataclass
class New(AST):
    value: AST = null
    arguments: List[AST] = field(default_factory=list)


@dataclass
class Variable(AST):
    name: str = underscore
    value: AST = null


@dataclass
class Function(AST):
    name: str = underscore
    parameter_names: List[str] = field(default_factory=list)
    defaults: List[AST] = field(default_factory=list)
    default_return_value: Any = None
    body: AST = Pass()


@dataclass
class Class(AST):
    name: str = underscore
