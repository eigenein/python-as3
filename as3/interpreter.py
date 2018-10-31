from __future__ import annotations

import math
import operator
import re
from dataclasses import dataclass
from typing import Any, Callable, Dict, List, NoReturn, Type

from as3 import ast_
from as3.ast_ import AST
from as3.enums import TokenType
from as3.exceptions import ASReferenceError, ASReturn


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
        native_constructor: dict = native_constructors[with_constructor]
    except KeyError:
        """https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/new#Description"""
        where, name = resolve_property(with_constructor, 'prototype')
        this = {'__proto__': where[name], 'constructor': with_constructor}
        return call(with_constructor, with_arguments, with_environment) or this
    else:
        return call(native_constructor, with_arguments, with_environment)


def call(value: dict, with_arguments: List[AST], with_environment: dict) -> Any:
    return resolve_property(value, '__call__').value(
        *(execute(argument, with_environment) for argument in with_arguments))


def define_variable(with_node: ast_.Variable, in_environment: dict) -> Any:
    value = execute(with_node.value, in_environment)
    in_environment[with_node.name] = value
    return value


def define_function(with_node: ast_.Function, in_environment: dict) -> dict:
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
    function_object = make_function_object(function_)
    in_environment[with_node.name] = function_object
    return function_object


def make_function_object(callable_: Callable) -> dict:
    return {'__call__': callable_, '__proto__': None, 'prototype': {}}


def define_class(with_node: ast_.Class, with_environment: dict) -> dict:
    return define_function(with_node.constructor, with_environment)


def execute_assignment(left: AST, right: Any, with_environment: dict) -> Any:
    resolve_assignment_target(left, with_environment).value = right
    return right


# Names.
# ----------------------------------------------------------------------------------------------------------------------

@dataclass
class ResolvedTarget:
    where: dict
    name: str

    @property
    def value(self) -> Any:
        try:
            return self.where[self.name]
        except KeyError:
            raise RuntimeError(f'attempted to get property `{self.name}` of `{self.where}`')

    @value.setter
    def value(self, value: Any):
        self.where[self.name] = value


def get_name(with_node: ast_.Name, with_environment: dict) -> Any:
    return resolve_property(with_environment, with_node.identifier).value


def get_property(of_value: Any, of_name: str) -> Any:
    try:
        resolved_target = resolve_property(of_value, of_name)
    except ASReferenceError:
        return undefined
    else:
        return resolved_target.value


def has_property(value: Any, of_name: str) -> bool:
    try:
        resolve_property(value, of_name)
    except ASReferenceError:
        return False
    else:
        return True


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
        where.__dict__[name]  # TODO: handle native types
    except (AttributeError, KeyError):
        pass
    else:
        return ResolvedTarget(where=where.__dict__, name=name)
    raise ASReferenceError(f'property `{name!r}` is not found in `{where!r}`')


def push_environment(environment: dict) -> dict:
    return {'__proto__': environment}


# Operation wrappers.
# ----------------------------------------------------------------------------------------------------------------------

def binary_operation(operation: Callable[[Any, Any], Any]) -> Callable[[AST, AST, dict], Any]:
    def execute_(left: AST, right: Any, with_environment: dict) -> Any:
        return operation(execute(left, with_environment), right)
    return execute_


def binary_augmented_assignment(with_operation: Callable[[Any, Any], Any]) -> Callable[[AST, AST, dict], Any]:
    def execute_(left: AST, right: Any, with_environment: dict) -> Any:
        resolved_target = resolve_assignment_target(left, with_environment)
        resolved_target.value = with_operation(resolved_target.value, right)
        return resolved_target.value
    return execute_


def unary_operation(operation: Callable[[Any], Any]) -> Callable[[AST, dict], Any]:
    def execute_(on_argument: AST, with_environment: dict) -> Any:
        return operation(execute(on_argument, with_environment))
    return execute_


def unary_augmented_assignment(with_operation: Callable[[Any], Any]) -> Callable[[AST, dict], Any]:
    def execute_(on_argument: AST, with_environment: dict) -> Any:
        resolved_target = resolve_assignment_target(on_argument, with_environment)
        resolved_target.value = with_operation(resolved_target.value)
        return resolved_target.value
    return execute_


def postfix_augmented_assignment(with_operation: Callable[[Any], Any]) -> Callable[[AST, dict], Any]:
    def execute_(on_argument: AST, with_environment: dict) -> Any:
        resolved_target = resolve_assignment_target(on_argument, with_environment)
        old_value = resolved_target.value
        resolved_target.value = with_operation(old_value)
        return old_value
    return execute_


# Assignment.
# ----------------------------------------------------------------------------------------------------------------------

def resolve_assignment_target(node: AST, with_environment: dict) -> ResolvedTarget:
    if isinstance(node, ast_.Name):
        return resolve_property(with_environment, node.identifier)
    if isinstance(node, ast_.Property):
        return ResolvedTarget(
            where=execute(node.value, with_environment),
            name=execute(node.item, with_environment),
        )
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

# TODO: should be generalized to native properties.
native_constructors: Dict[Type, Callable] = {
    dict: {'__call__': dict},
    float: {'__call__': float},
    int: {'__call__': int},
    list: {'__call__': lambda *args: list(args)},
    str: {'__call__': str},
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

class ASUndefined:
    def __repr__(self) -> str:
        return 'undefined'


sentinel = object()

undefined = ASUndefined()

mocked_imports = re.compile(r'''
    flash\.(
        display\. |
        events\. |
        filters\. |
        text\. |
        (utils\.(getTimer|setInterval|setTimeout))
    ).*
''', re.VERBOSE)

global_environment = {
    'Array': list,
    'Boolean': bool,
    'Exception': Exception,
    'int': int,
    'Math': {
        'abs': make_function_object(abs),
        'acos': make_function_object(math.acos),
    },
    'Number': float,
    'Object': dict,
    'ReferenceError': ASReferenceError,
    'String': str,
    'trace': print,
    'uint': int,
    'Vector': list,
}
