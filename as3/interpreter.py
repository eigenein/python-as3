from __future__ import annotations

import operator
import re
from dataclasses import dataclass, field
from types import FunctionType
from typing import Any, Callable, Dict, List, Optional, Tuple, Type

from as3 import ast_, stdlib
from as3.ast_ import AST
from as3.enums import TokenType
from as3.exceptions import ASRuntimeError, ASReturn


def execute(node: AST, with_environment: Environment) -> Any:
    assert isinstance(node, AST)
    if isinstance(node, ast_.Literal):
        return node.value
    if isinstance(node, ast_.Block):
        return execute_block(node, with_environment)
    if isinstance(node, ast_.CompoundLiteral):
        return [execute(child, with_environment) for child in node.value]
    if isinstance(node, ast_.MapLiteral):
        return {execute(key, with_environment): execute(value, with_environment) for key, value in node.value}
    if isinstance(node, ast_.PostfixOperation):
        return postfix_operations[node.token.type_](node.value, with_environment)
    if isinstance(node, ast_.UnaryOperation):
        return unary_operations[node.token.type_](node.value, with_environment)
    if isinstance(node, ast_.BinaryOperation):
        return binary_operations[node.token.type_](node.left, execute(node.right, with_environment), with_environment)
    if isinstance(node, ast_.If):
        if execute(node.test, with_environment):
            return execute(node.positive, with_environment)
        else:
            return execute(node.negative, with_environment)
    if isinstance(node, ast_.Property):
        return get_property(execute(node.value, with_environment), execute(node.item, with_environment))
    if isinstance(node, ast_.Name):
        return get_own_property(with_environment.resolve(node.identifier).values, node.identifier)
    if isinstance(node, ast_.Call):
        return call(execute(node.value, with_environment), node.arguments, with_environment)
    if isinstance(node, ast_.New):
        return new(execute(node.value, with_environment), node.arguments, with_environment)
    if isinstance(node, ast_.Variable):
        return define_variable(node, with_environment)
    if isinstance(node, ast_.Function):
        return define_function(node, with_environment)
    if isinstance(node, ast_.Return):
        raise ASReturn(execute(node.value, with_environment))
    raise NotImplementedError(repr(node))


def execute_block(node: ast_.Block, with_environment: Environment) -> Any:
    value = None
    for statement in node.body:
        value = execute(statement, with_environment)
    return value


def new(with_constructor: Any, with_arguments: List[Any], with_environment: Environment) -> Any:
    try:
        native_constructor: Callable = primitive_constructors[with_constructor]
    except KeyError:
        """https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/new#Description"""
        prototype = get_property(with_constructor, 'prototype')
        this = {'__proto__': prototype, 'constructor': with_constructor}
        return call(with_constructor, with_arguments, with_environment.push(this=this)) or this
    else:
        return call(native_constructor, with_arguments, with_environment)


def call(value: Any, with_arguments: List[AST], with_environment: Environment) -> Any:
    return value(*(execute(argument, with_environment) for argument in with_arguments))


def define_variable(with_node: ast_.Variable, in_environment: Environment) -> None:
    in_environment.values[with_node.name] = execute(with_node.value, in_environment)


def define_function(with_node: ast_.Function, in_environment: Environment) -> Callable:
    def function_(*args: Any, **kwargs: Any) -> Any:
        environment = in_environment.push()
        # Explicitly passed values.
        for argument, name in zip(args, with_node.parameter_names):
            environment.values[name] = argument
        environment.values.update(kwargs)
        # Defaults.
        for name, default_value in zip(with_node.parameter_names, with_node.defaults):
            if name not in environment.values:
                environment.values[name] = execute(default_value, in_environment)
        # Fill the rest with `undefined`.
        for name in with_node.parameter_names:
            if name not in environment.values:
                environment.values[name] = undefined
        try:
            execute(with_node.body, environment)
        except ASReturn as e:
            return e.value
        else:
            return with_node.default_return_value
    # Just for a nicer look.
    function_.__name__ = function_.__qualname__ = with_node.name
    # TODO: `new_function.__module__ = ...`
    in_environment.values[with_node.name] = function_
    return function_


def get_property(of_value: Any, of_name: str) -> Any:
    while of_value is not None:
        try:
            return get_own_property(of_value, of_name)
        except KeyError:
            try:
                of_value = get_own_property(of_value, '__proto__')
            except KeyError:
                of_value = None
    return undefined


def get_own_property(of_value: Any, of_name: str) -> Any:
    if isinstance(of_value, primitive_types):
        return primitive_properties[type(of_value), of_name]
    return of_value[of_name]


def set_property(of_value: Any, with_name: str, to_value: Any) -> Any:
    of_value[with_name] = to_value
    return of_value


def binary_operation(operation: Callable[[Any, Any], Any]) -> Callable[[AST, AST, Environment], Any]:
    def execute_(left: AST, right: Any, with_environment: Environment) -> Any:
        return operation(execute(left, with_environment), right)
    return execute_


def binary_augmented_assignment(with_operation: Callable[[Any, Any], Any]) -> Callable[[AST, AST, Environment], Any]:
    def execute_(left: AST, right: Any, with_environment: Environment) -> Any:
        value, key = resolve_assignment_target(left, with_environment)
        value[key] = with_operation(value[key], right)
        return value[key]
    return execute_


def unary_operation(operation: Callable[[Any], Any]) -> Callable[[AST, Environment], Any]:
    def execute_(on_argument: AST, with_environment: Environment) -> Any:
        return operation(execute(on_argument, with_environment))
    return execute_


def unary_augmented_assignment(with_operation: Callable[[Any], Any]) -> Callable[[AST, Environment], Any]:
    def execute_(on_argument: AST, with_environment: Environment) -> Any:
        value, key = resolve_assignment_target(on_argument, with_environment)
        value[key] = with_operation(value[key])
        return value[key]
    return execute_


def postfix_augmented_assignment(with_operation: Callable[[Any], Any]) -> Callable[[AST, Environment], Any]:
    def execute_(on_argument: AST, with_environment: Environment) -> Any:
        value, key = resolve_assignment_target(on_argument, with_environment)
        old_value = value[key]
        value[key] = with_operation(value[key])
        return old_value
    return execute_


def resolve_assignment_target(node: AST, with_environment: Environment) -> Tuple[Dict[str, Any], str]:
    if isinstance(node, ast_.Name):
        return with_environment.resolve(node.identifier).values, node.identifier
    if isinstance(node, ast_.Property):
        return execute(node.value, with_environment), execute(node.item, with_environment)
    raise ASRuntimeError(f'{node} cannot be assigned to')


@dataclass
class Environment:
    """http://dmitrysoshnikov.com/ecmascript/javascript-the-core-2nd-edition/#environment"""
    values: Dict[str, Any] = field(default_factory=dict)
    parent: Optional[Environment] = None

    def push(self, **values: Any) -> Environment:
        return Environment(parent=self, values=values)

    def resolve(self, name: str) -> Environment:
        environment = self
        while environment is not None:
            if name in environment.values:
                return environment
            environment = environment.parent
        raise ASRuntimeError(f'could not resolve `{name}`')  # FIXME: ReferenceError


unary_operations: Dict[TokenType, Callable[[Any], Any]] = {
    TokenType.DECREMENT: unary_augmented_assignment(lambda value: value - 1),
    TokenType.INCREMENT: unary_augmented_assignment(lambda value: value + 1),
    TokenType.LOGICAL_NOT: unary_operation(operator.not_),
    TokenType.MINUS: unary_operation(operator.neg),
    TokenType.PLUS: unary_operation(operator.pos),
}

postfix_operations: Dict[TokenType, Callable[[Any], Any]] = {
    TokenType.DECREMENT: postfix_augmented_assignment(lambda value: value - 1),
    TokenType.INCREMENT: postfix_augmented_assignment(lambda value: value + 1),
}

binary_operations: Dict[TokenType, Callable[[AST, AST], Any]] = {
    # FIXME: proper `isinstance`.
    TokenType.ASSIGN: binary_augmented_assignment(lambda _, right: right),
    TokenType.AS: binary_operation(lambda left, right: left if isinstance(left, right) else None),
    TokenType.ASSIGN_ADD: binary_augmented_assignment(operator.add),
    TokenType.BITWISE_XOR: binary_operation(operator.xor),
    TokenType.DIVIDE: binary_operation(operator.truediv),
    TokenType.EQUALS: binary_operation(operator.eq),
    TokenType.IS: binary_operation(lambda left, right: isinstance(left, right)),  # FIXME: proper `isinstance`.
    TokenType.LOGICAL_AND: binary_operation(lambda left, right: bool(left and right)),
    TokenType.LOGICAL_OR: binary_operation(lambda left, right: bool(left or right)),
    TokenType.MINUS: binary_operation(operator.sub),
    TokenType.MULTIPLY: binary_operation(operator.mul),
    TokenType.NOT_EQUALS: binary_operation(operator.ne),
    TokenType.PERCENT: binary_operation(operator.mod),
    TokenType.PLUS: binary_operation(operator.add),
}

primitive_types: Tuple[Type, ...] = (list, str, float, set, int, FunctionType)

primitive_constructors: Dict[Type, Callable] = {
    list: lambda *args: list(args),
    str: str,
}

primitive_properties: Dict[Tuple[Type, str], Any] = {
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

undefined = object()  # FIXME: it should also be a proper object.

global_environment = Environment(values={
    'Array': list,
    'Boolean': bool,
    'int': int,
    'Math': stdlib.Math,
    'Number': float,
    'Object': dict,
    'String': str,
    'trace': print,
    'uint': int,
    'Vector': list,
})
