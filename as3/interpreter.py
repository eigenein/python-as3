from __future__ import annotations

import operator
import re
from typing import Any, Callable, Dict, List, NoReturn, Tuple, Type

from as3 import ast_
from as3.ast_ import AST
from as3.enums import TokenType
from as3.exceptions import ASReferenceError, ASReturn
from as3.runtime import Environment, undefined

sentinel = object()


def execute(node: AST, with_environment: Environment) -> Any:
    assert isinstance(node, AST)
    try:
        return ast_handlers[type(node)](node, with_environment)
    except KeyError:
        raise NotImplementedError(repr(node))


# AST handlers.
# ----------------------------------------------------------------------------------------------------------------------

def execute_block(node: ast_.Block, with_environment: Environment) -> Any:
    return_value = undefined
    for statement in node.body:
        return_value = execute(statement, with_environment)
    return return_value


def execute_for(node: ast_.AbstractFor, with_environment: Environment) -> Any:
    environment = with_environment.push()
    return_value = undefined
    iterable = execute(node.value, with_environment)
    if isinstance(node, ast_.ForEach):
        iterable = iterable.values()
    for value in iterable:
        environment.values[node.variable_name] = value
        return_value = execute(node.body, environment)
    return return_value


def return_(node: ast_.Return, with_environment: Environment) -> NoReturn:
    raise ASReturn(execute(node.value, with_environment))


def new(with_constructor: Any, with_arguments: List[Any], with_environment: Environment) -> Any:
    try:
        native_constructor: Callable = native_constructors[with_constructor]
    except KeyError:
        """https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/new#Description"""
        prototype = get_property(with_constructor, 'prototype')
        this = {'__proto__': prototype, 'constructor': with_constructor}
        return call(with_constructor, with_arguments, with_environment) or this
    else:
        return call(native_constructor, with_arguments, with_environment)


def call(value: Any, with_arguments: List[AST], with_environment: Environment) -> Any:
    return value(*(execute(argument, with_environment) for argument in with_arguments))


def define_variable(with_node: ast_.Variable, in_environment: Environment) -> Any:
    value = execute(with_node.value, in_environment)
    in_environment.values[with_node.name] = value
    return value


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
    function_.__name__ = function_.__qualname__ = with_node.name
    function_.__proto__ = None  # type: ignore
    function_.prototype = {}  # type: ignore
    in_environment.values[with_node.name] = function_
    return function_


def define_class(with_node: ast_.Class, with_environment: Environment) -> Callable:
    return define_function(with_node.constructor, with_environment)


def execute_assignment(left: AST, right: Any, with_environment: Environment) -> Any:
    value, name = resolve_assignment_target(left, with_environment)
    value[name] = right
    return right


# Property manipulation.
# ----------------------------------------------------------------------------------------------------------------------

def get_property(of_value: Any, of_name: str, default: Any = undefined) -> Any:
    while of_value is not None:
        value = get_own_property(of_value, of_name, sentinel)
        if value is not sentinel:
            return value
        of_value = get_own_property(of_value, '__proto__', None)
    return default


def get_own_property(of_value: Any, of_name: str, default: Any = undefined) -> Any:
    try:
        return of_value[of_name]
    except (KeyError, TypeError):
        pass
    try:
        return getattr(of_value, of_name)
    except (AttributeError, TypeError):
        pass
    return default


# Operation wrappers.
# ----------------------------------------------------------------------------------------------------------------------

def binary_operation(operation: Callable[[Any, Any], Any]) -> Callable[[AST, AST, Environment], Any]:
    def execute_(left: AST, right: Any, with_environment: Environment) -> Any:
        return operation(execute(left, with_environment), right)
    return execute_


def binary_augmented_assignment(with_operation: Callable[[Any, Any], Any]) -> Callable[[AST, AST, Environment], Any]:
    def execute_(left: AST, right: Any, with_environment: Environment) -> Any:
        value, name = resolve_assignment_target(left, with_environment)
        value[name] = with_operation(value[name], right)
        return value[name]
    return execute_


def unary_operation(operation: Callable[[Any], Any]) -> Callable[[AST, Environment], Any]:
    def execute_(on_argument: AST, with_environment: Environment) -> Any:
        return operation(execute(on_argument, with_environment))
    return execute_


def unary_augmented_assignment(with_operation: Callable[[Any], Any]) -> Callable[[AST, Environment], Any]:
    def execute_(on_argument: AST, with_environment: Environment) -> Any:
        value, name = resolve_assignment_target(on_argument, with_environment)
        value[name] = with_operation(value[name])
        return value[name]
    return execute_


def postfix_augmented_assignment(with_operation: Callable[[Any], Any]) -> Callable[[AST, Environment], Any]:
    def execute_(on_argument: AST, with_environment: Environment) -> Any:
        value, name = resolve_assignment_target(on_argument, with_environment)
        old_value = value[name]
        value[name] = with_operation(value[name])
        return old_value
    return execute_


# Name resolution.
# ----------------------------------------------------------------------------------------------------------------------

def resolve_assignment_target(node: AST, with_environment: Environment) -> Tuple[Dict[str, Any], str]:
    if isinstance(node, ast_.Name):
        return with_environment.resolve(node.identifier).values, node.identifier
    if isinstance(node, ast_.Property):
        # FIXME: what if it's not a `dict`? E.g. a function object. Perhaps return it's `__dict__`.
        # FIXME: what if it's in a prototype? Then, we need to resolve the property like in `get_property`.
        # FIXME: seems like I need a generic name resolver which is able to work on both objects and environments.
        return execute(node.value, with_environment), execute(node.item, with_environment)
    raise ASReferenceError(f'{node} cannot be assigned to')


# Tables.
# ----------------------------------------------------------------------------------------------------------------------

unary_operations: Dict[TokenType, Callable[[AST, Environment], Any]] = {
    TokenType.DECREMENT: unary_augmented_assignment(lambda value: value - 1),
    TokenType.INCREMENT: unary_augmented_assignment(lambda value: value + 1),
    TokenType.LOGICAL_NOT: unary_operation(operator.not_),
    TokenType.MINUS: unary_operation(operator.neg),
    TokenType.PLUS: unary_operation(operator.pos),
}

postfix_operations: Dict[TokenType, Callable[[AST, Environment], Any]] = {
    TokenType.DECREMENT: postfix_augmented_assignment(lambda value: value - 1),
    TokenType.INCREMENT: postfix_augmented_assignment(lambda value: value + 1),
}

binary_operations: Dict[TokenType, Callable[[AST, AST, Environment], Any]] = {
    TokenType.ASSIGN: execute_assignment,
    TokenType.AS: binary_operation(lambda left, right: left if isinstance(left, right) else None),
    TokenType.ASSIGN_ADD: binary_augmented_assignment(operator.add),
    TokenType.BITWISE_XOR: binary_operation(operator.xor),
    TokenType.DIVIDE: binary_operation(operator.truediv),
    TokenType.EQUALS: binary_operation(lambda left, right: left == right and (not isinstance(left, dict) or left is right)),
    TokenType.IN: binary_operation(lambda left, right: get_property(right, left, sentinel) is not sentinel),
    TokenType.IS: binary_operation(lambda left, right: isinstance(left, right)),  # FIXME: proper `isinstance`.
    TokenType.LOGICAL_AND: binary_operation(lambda left, right: bool(left and right)),
    TokenType.LOGICAL_OR: binary_operation(lambda left, right: bool(left or right)),
    TokenType.MINUS: binary_operation(operator.sub),
    TokenType.MULTIPLY: binary_operation(operator.mul),
    TokenType.NOT_EQUALS: binary_operation(lambda left, right: left != right or (isinstance(left, dict) and left is not right)),
    TokenType.PERCENT: binary_operation(operator.mod),
    TokenType.PLUS: binary_operation(operator.add),
}

native_constructors: Dict[Type, Callable] = {
    dict: dict,
    float: float,
    int: int,
    list: lambda *args: list(args),
    str: str,
}

ast_handlers: Dict[Type[AST], Callable[[AST, Environment], Any]] = {
    ast_.BinaryOperation: lambda node, env: binary_operations[node.token.type_](node.left, execute(node.right, env), env),
    ast_.Block: execute_block,
    ast_.Call: lambda node, env: call(execute(node.value, env), node.arguments, env),
    ast_.Class: define_class,
    ast_.CompoundLiteral: lambda node, env: [execute(child, env) for child in node.value],
    ast_.For: execute_for,
    ast_.ForEach: execute_for,
    ast_.Function: define_function,
    ast_.If: lambda node, env: execute(node.positive, env) if execute(node.test, env) else execute(node.negative, env),
    ast_.Literal: lambda node, env: node.value,
    ast_.MapLiteral: lambda node, env: {execute(key, env): execute(value, env) for key, value in node.value},
    ast_.Name: lambda node, env: get_own_property(env.resolve(node.identifier).values, node.identifier),
    ast_.New: lambda node, env: new(execute(node.value, env), node.arguments, env),
    ast_.PostfixOperation: lambda node, env: postfix_operations[node.token.type_](node.value, env),
    ast_.Property: lambda node, env: get_property(execute(node.value, env), execute(node.item, env)),
    ast_.Return: return_,
    ast_.UnaryOperation: lambda node, env: unary_operations[node.token.type_](node.value, env),
    ast_.Variable: define_variable,
}


# Constants.
# ----------------------------------------------------------------------------------------------------------------------

mocked_imports = re.compile(r'''
    flash\.(
        display\. |
        events\. |
        filters\. |
        text\. |
        (utils\.(getTimer|setInterval|setTimeout))
    ).*
''', re.VERBOSE)
