from __future__ import annotations

import operator
import re
from typing import Any, Callable, Dict, List, NoReturn, Tuple, Type

from as3 import ast_
from as3.ast_ import AST
from as3.enums import TokenType
from as3.exceptions import ASReferenceError, ASReturn
from as3.runtime import push_environment, resolve_property, undefined

sentinel = object()


def execute(node: AST, with_environment: dict) -> Any:
    assert isinstance(node, AST)
    try:
        return ast_handlers[type(node)](node, with_environment)
    except KeyError:
        raise NotImplementedError(repr(node))


# AST handlers.
# ----------------------------------------------------------------------------------------------------------------------

def execute_block(node: ast_.Block, with_environment: dict) -> Any:
    return_value = undefined
    for statement in node.body:
        return_value = execute(statement, with_environment)
    return return_value


def execute_for(node: ast_.AbstractFor, with_environment: dict) -> Any:
    environment = push_environment(with_environment)
    return_value = undefined
    iterable = execute(node.value, with_environment)
    if isinstance(node, ast_.ForEach):
        iterable = iterable.values()
    for value in iterable:
        environment[node.variable_name] = value
        return_value = execute(node.body, environment)
    return return_value


def return_(node: ast_.Return, with_environment: dict) -> NoReturn:
    raise ASReturn(execute(node.value, with_environment))


def new(with_constructor: Any, with_arguments: List[Any], with_environment: dict) -> Any:
    try:
        native_constructor: Callable = native_constructors[with_constructor]
    except KeyError:
        """https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/new#Description"""
        where, name = resolve_property(with_constructor, 'prototype')
        this = {'__proto__': where[name], 'constructor': with_constructor}
        return call(with_constructor, with_arguments, with_environment) or this
    else:
        return call(native_constructor, with_arguments, with_environment)


def call(value: Any, with_arguments: List[AST], with_environment: dict) -> Any:
    return value(*(execute(argument, with_environment) for argument in with_arguments))


def define_variable(with_node: ast_.Variable, in_environment: dict) -> Any:
    value = execute(with_node.value, in_environment)
    in_environment[with_node.name] = value
    return value


def define_function(with_node: ast_.Function, in_environment: dict) -> Callable:
    def function_(*args: Any, **kwargs: Any) -> Any:
        environment = push_environment(in_environment)
        # Explicitly passed values.
        for argument, name in zip(args, with_node.parameter_names):
            environment[name] = argument
        environment.update(kwargs)
        # Defaults.
        for name, default_value in zip(with_node.parameter_names, with_node.defaults):
            if name not in environment:
                environment[name] = execute(default_value, in_environment)
        # Fill the rest with `undefined`.
        for name in with_node.parameter_names:
            if name not in environment:
                environment[name] = undefined
        try:
            execute(with_node.body, environment)
        except ASReturn as e:
            return e.value
        else:
            return with_node.default_return_value
    function_.__name__ = function_.__qualname__ = with_node.name
    function_.__proto__ = None  # type: ignore
    function_.prototype = {}  # type: ignore
    in_environment[with_node.name] = function_
    return function_


def define_class(with_node: ast_.Class, with_environment: dict) -> Callable:
    return define_function(with_node.constructor, with_environment)


def execute_assignment(left: AST, right: Any, with_environment: dict) -> Any:
    value, name = resolve_assignment_target(left, with_environment)
    value[name] = right
    return right


# Names.
# ----------------------------------------------------------------------------------------------------------------------

def get_name(with_node: ast_.Name, with_environment: dict) -> Any:
    where, name = resolve_property(with_environment, with_node.identifier)
    return where[name]


def get_property(of_value: Any, of_name: str) -> Any:
    try:
        where, name = resolve_property(of_value, of_name)
    except ASReferenceError:
        return undefined
    else:
        return where[name]


def has_property(value: Any, of_name: str) -> bool:
    try:
        resolve_property(value, of_name)
    except ASReferenceError:
        return False
    else:
        return True


# Operation wrappers.
# ----------------------------------------------------------------------------------------------------------------------

def binary_operation(operation: Callable[[Any, Any], Any]) -> Callable[[AST, AST, dict], Any]:
    def execute_(left: AST, right: Any, with_environment: dict) -> Any:
        return operation(execute(left, with_environment), right)
    return execute_


def binary_augmented_assignment(with_operation: Callable[[Any, Any], Any]) -> Callable[[AST, AST, dict], Any]:
    def execute_(left: AST, right: Any, with_environment: dict) -> Any:
        value, name = resolve_assignment_target(left, with_environment)
        value[name] = with_operation(value[name], right)
        return value[name]
    return execute_


def unary_operation(operation: Callable[[Any], Any]) -> Callable[[AST, dict], Any]:
    def execute_(on_argument: AST, with_environment: dict) -> Any:
        return operation(execute(on_argument, with_environment))
    return execute_


def unary_augmented_assignment(with_operation: Callable[[Any], Any]) -> Callable[[AST, dict], Any]:
    def execute_(on_argument: AST, with_environment: dict) -> Any:
        value, name = resolve_assignment_target(on_argument, with_environment)
        value[name] = with_operation(value[name])
        return value[name]
    return execute_


def postfix_augmented_assignment(with_operation: Callable[[Any], Any]) -> Callable[[AST, dict], Any]:
    def execute_(on_argument: AST, with_environment: dict) -> Any:
        value, name = resolve_assignment_target(on_argument, with_environment)
        old_value = value[name]
        value[name] = with_operation(value[name])
        return old_value
    return execute_


# Name resolution.
# ----------------------------------------------------------------------------------------------------------------------

def resolve_assignment_target(node: AST, with_environment: dict) -> Tuple[dict, str]:
    if isinstance(node, ast_.Name):
        return resolve_property(with_environment, node.identifier)
    if isinstance(node, ast_.Property):
        # FIXME: what if it's not a `dict`? E.g. a function object. Perhaps return it's `__dict__`.
        # FIXME: what if it's in a prototype? Then, we need to resolve the property like in `get_property`.
        # FIXME: seems like I need a generic name resolver which is able to work on both objects and environments.
        return execute(node.value, with_environment), execute(node.item, with_environment)
    raise ASReferenceError(f'{node} cannot be assigned to')


# Tables.
# ----------------------------------------------------------------------------------------------------------------------

unary_operations: Dict[TokenType, Callable[[AST, dict], Any]] = {
    TokenType.DECREMENT: unary_augmented_assignment(lambda value: value - 1),
    TokenType.INCREMENT: unary_augmented_assignment(lambda value: value + 1),
    TokenType.LOGICAL_NOT: unary_operation(operator.not_),
    TokenType.MINUS: unary_operation(operator.neg),
    TokenType.PLUS: unary_operation(operator.pos),
}

postfix_operations: Dict[TokenType, Callable[[AST, dict], Any]] = {
    TokenType.DECREMENT: postfix_augmented_assignment(lambda value: value - 1),
    TokenType.INCREMENT: postfix_augmented_assignment(lambda value: value + 1),
}

binary_operations: Dict[TokenType, Callable[[AST, AST, dict], Any]] = {
    TokenType.ASSIGN: execute_assignment,
    TokenType.AS: binary_operation(lambda left, right: left if isinstance(left, right) else None),
    TokenType.ASSIGN_ADD: binary_augmented_assignment(operator.add),
    TokenType.BITWISE_XOR: binary_operation(operator.xor),
    TokenType.DIVIDE: binary_operation(operator.truediv),
    TokenType.EQUALS: binary_operation(lambda left, right: left == right and (not isinstance(left, dict) or left is right)),
    TokenType.IN: binary_operation(lambda left, right: has_property(right, left)),
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

ast_handlers: Dict[Type[AST], Callable[[AST, dict], Any]] = {
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
    ast_.Name: get_name,
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
