from __future__ import annotations

from ast import literal_eval
from dataclasses import dataclass, field
from typing import List, Optional, Tuple

from as3 import interpreter
from as3.scanner import Token

underscore = '_'


@dataclass
class AST:
    token: Optional[Token] = None


@dataclass
class Literal(AST):
    value: object = interpreter.undefined

    @staticmethod
    def from_(token: Token) -> Literal:
        # noinspection PyArgumentList
        return Literal(token=token, value=literal_eval(token.value))


undefined = Literal(value=interpreter.undefined)


@dataclass
class Block(AST):
    body: List[AST] = field(default_factory=list)


@dataclass
class Pass(AST):
    pass


@dataclass
class If(AST):
    test: AST = undefined
    positive: AST = Pass()
    negative: AST = Pass()


@dataclass
class Return(AST):
    value: AST = undefined


@dataclass
class Break(AST):
    pass


@dataclass
class While(AST):
    test: AST = undefined
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
    value: AST = undefined


@dataclass
class AbstractFor(AST):
    variable_name: str = underscore
    value: AST = undefined
    body: AST = Pass()


@dataclass
class For(AbstractFor):
    pass


@dataclass
class ForEach(AbstractFor):
    pass


@dataclass
class Conditional(AST):
    test: AST = undefined
    positive_value: AST = undefined
    negative_value: AST = undefined


@dataclass
class UnaryOperation(AST):
    value: AST = undefined


@dataclass
class Property(AST):
    value: AST = undefined
    item: AST = undefined


@dataclass
class Call(AST):
    value: AST = undefined
    arguments: List[AST] = field(default_factory=list)


@dataclass
class BinaryOperation(AST):
    left: AST = undefined
    right: AST = undefined


@dataclass
class CompoundLiteral(AST):
    value: List[AST] = field(default_factory=list)


@dataclass
class MapLiteral(AST):
    value: List[Tuple[AST, AST]] = field(default_factory=list)


@dataclass
class New(AST):
    value: AST = undefined
    arguments: List[AST] = field(default_factory=list)
