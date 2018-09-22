from __future__ import annotations

import operator
import re
from typing import Any, Callable, Dict, Tuple, Type, List

from as3 import ast_
from as3.enums import TokenType


def evaluate(node: ast_.AST, globals_: Dict[str, Any]) -> Any:
    assert isinstance(node, ast_.AST)
    if isinstance(node, ast_.Literal):
        return node.value
    if isinstance(node, ast_.CompoundLiteral):
        return [evaluate(child, globals_) for child in node.value]
    if isinstance(node, ast_.MapLiteral):
        return {evaluate(key, globals_): evaluate(value, globals_) for key, value in node.value}
    if isinstance(node, ast_.UnaryOperation):
        return unary_operations[node.token.type_](evaluate(node.value, globals_))
    if isinstance(node, ast_.BinaryOperation):
        if node.token.type_ in binary_operations:
            return binary_operations[node.token.type_](evaluate(node.left, globals_), evaluate(node.right, globals_))
    if isinstance(node, ast_.Conditional):
        if evaluate(node.test, globals_):
            return evaluate(node.positive_value, globals_)
        else:
            return evaluate(node.negative_value, globals_)
    if isinstance(node, ast_.Property):
        return get_property(evaluate(node.value, globals_), evaluate(node.item, globals_))
    if isinstance(node, ast_.Name):
        return globals_[node.identifier]  # FIXME: proper name lookup.
    if isinstance(node, ast_.Call):
        return evaluate(node.value, globals_)(*evaluate_arguments(node.arguments, globals_))
    if isinstance(node, ast_.New):
        return new(evaluate(node.value, globals_), evaluate_arguments(node.arguments, globals_))
    raise NotImplementedError(repr(node))


def evaluate_arguments(arguments: List[ast_.AST], globals_: Dict[str, Any]) -> List[Any]:
    return [evaluate(argument, globals_) for argument in arguments]


def new(constructor: Callable, arguments: List[Any]) -> Any:
    try:
        constructor = standard_constructors[constructor]
    except KeyError:
        """https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/new#Description"""
        prototype = get_property(constructor, prototype_property)
        this = {proto_property: prototype}
        return constructor(this, *arguments) or this
    else:
        return constructor(*arguments)


def get_property(object_: Any, name: str) -> Any:
    source_object = object_
    while True:
        try:
            return get_own_property(object_, name)
        except AttributeError:
            pass
        try:
            object_ = get_own_property(object_, proto_property)
        except AttributeError:
            break
    raise AttributeError(f'object `{source_object!r}` has no property `{name}`')


def get_own_property(object_: Any, name: str) -> Any:
    if isinstance(object_, dict) and name in object_:
        return object_[name]
    try:
        return standard_properties[type(object_), name]
    except KeyError:
        pass
    raise AttributeError(f'object `{object_!r}` has no own property `{name}`')


def set_property(object_: ast_.AST, name: str, value: Any) -> Any:
    # TODO
    return object_


unary_operations: Dict[TokenType, Callable[[object], object]] = {
    TokenType.LOGICAL_NOT: operator.not_,
    TokenType.MINUS: operator.neg,
    TokenType.PLUS: operator.pos,
}

binary_operations: Dict[TokenType, Callable[[object, object], object]] = {
    TokenType.AS: lambda left, right: left if isinstance(left, right) else None,
    TokenType.BITWISE_XOR: operator.xor,
    TokenType.DIVIDE: operator.truediv,
    TokenType.EQUALS: operator.eq,
    TokenType.IS: lambda left, right: isinstance(left, right),
    TokenType.LOGICAL_AND: lambda left, right: left and right,
    TokenType.LOGICAL_OR: lambda left, right: left or right,
    TokenType.MINUS: operator.sub,
    TokenType.MULTIPLY: operator.mul,
    TokenType.NOT_EQUALS: operator.ne,
    TokenType.PERCENT: operator.mod,
    TokenType.PLUS: operator.add,
}

standard_constructors: Dict[Type, Callable] = {
    list: lambda *args: list(args),
    str: str,
}

standard_properties: Dict[Tuple[Type, str], Any] = {
}

mocked_imports = re.compile(r'''
    flash\.(
        display\. |
        events\. |
        filters\. |
        text\. |
        (utils\.(getTimer|setInterval|setTimeout))
    ).*
''', re.VERBOSE)

proto_property = '__proto__'
prototype_property = 'prototype'

undefined = object()
