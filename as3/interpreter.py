from __future__ import annotations

import operator
import re
from dataclasses import dataclass, field
from typing import Any, Callable, Dict, List, NoReturn, Optional, Tuple, Type

from as3 import ast_, stdlib
from as3.ast_ import AST
from as3.enums import TokenType
from as3.exceptions import ASReturn, ASRuntimeError


def execute(node: AST, with_environment: Environment) -> Any:
    assert isinstance(node, AST)
    try:
        return ast_handlers[type(node)](node, with_environment)
    except KeyError:
        raise NotImplementedError(repr(node))


# AST handlers.
# ----------------------------------------------------------------------------------------------------------------------

def execute_block(node: ast_.Block, with_environment: Environment) -> Any:
    value = None
    for statement in node.body:
        value = execute(statement, with_environment)
    return value


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
    function_.__name__ = function_.__qualname__ = with_node.name
    function_.__proto__ = None
    function_.prototype = {}
    # TODO: `function_.constructor` constructs a function with a provided source.
    # TODO: `function_.__module__ = ...`
    in_environment.values[with_node.name] = function_
    return function_


def define_class(with_node: ast_.Class, with_environment: Environment) -> Callable:
    return define_function(with_node.constructor, with_environment)


# Property manipulation.
# ----------------------------------------------------------------------------------------------------------------------

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
    if isinstance(of_value, dict):
        return of_value[of_name]
    return getattr(of_value, of_name, undefined)


def set_property(of_value: Any, with_name: str, to_value: Any) -> Any:
    # FIXME: prototype chain.
    of_value[with_name] = to_value
    return of_value


# Operation wrappers.
# ----------------------------------------------------------------------------------------------------------------------

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


# Name resolution.
# ----------------------------------------------------------------------------------------------------------------------

def resolve_assignment_target(node: AST, with_environment: Environment) -> Tuple[Dict[str, Any], str]:
    if isinstance(node, ast_.Name):
        return with_environment.resolve(node.identifier).values, node.identifier
    if isinstance(node, ast_.Property):
        return execute(node.value, with_environment), execute(node.item, with_environment)
    raise ASRuntimeError(f'{node} cannot be assigned to')


@dataclass
class Environment:
    """http://dmitrysoshnikov.com/ecmascript/javascript-the-core-2nd-edition/#environment"""

    # TODO: possibly replace with a prototype chain. Looks similar-ish.
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


# Tables.
# ----------------------------------------------------------------------------------------------------------------------

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
    # FIXME: proper `isinstance` with prototype chain.
    TokenType.ASSIGN: binary_augmented_assignment(lambda _, right: right),
    TokenType.AS: binary_operation(lambda left, right: left if isinstance(left, right) else None),
    TokenType.ASSIGN_ADD: binary_augmented_assignment(operator.add),
    TokenType.BITWISE_XOR: binary_operation(operator.xor),
    TokenType.DIVIDE: binary_operation(operator.truediv),
    TokenType.EQUALS: binary_operation(lambda left, right: left == right and (not isinstance(left, dict) or left is right)),
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
    ast_.Block: execute_block,
    ast_.CompoundLiteral: lambda node, env: [execute(child, env) for child in node.value],
    ast_.Literal: lambda node, env: node.value,
    ast_.MapLiteral: lambda node, env: {
        execute(key, env): execute(value, env)
        for key, value in node.value
    },
    ast_.PostfixOperation: lambda node, env: postfix_operations[node.token.type_](node.value, env),
    ast_.UnaryOperation: lambda node, env: unary_operations[node.token.type_](node.value, env),
    ast_.BinaryOperation: lambda node, env: binary_operations[node.token.type_](node.left, execute(node.right, env), env),
    ast_.If: lambda node, env: execute(node.positive, env) if execute(node.test, env) else execute(node.negative, env),
    ast_.Property: lambda node, env: get_property(execute(node.value, env), execute(node.item, env)),
    ast_.Name: lambda node, env: get_own_property(env.resolve(node.identifier).values, node.identifier),
    ast_.Call: lambda node, env: call(execute(node.value, env), node.arguments, env),
    ast_.New: lambda node, env: new(execute(node.value, env), node.arguments, env),
    ast_.Variable: lambda node, env: define_variable(node, env),
    ast_.Function: lambda node, env: define_function(node, env),
    ast_.Return: lambda node, env: return_,
    ast_.Class: lambda node, env: define_class(node, env),
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


# Runtime.
# ----------------------------------------------------------------------------------------------------------------------

class ASUndefined:
    def __repr__(self) -> str:
        return 'undefined'


undefined = ASUndefined()

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
