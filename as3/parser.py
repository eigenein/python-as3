from __future__ import annotations

import ast
from ast import AST
from contextlib import contextmanager
from dataclasses import dataclass, replace
from typing import Callable, ContextManager, Dict, Iterable, List, NoReturn, Optional, TypeVar

from more_itertools import consume, peekable

from as3.ast_ import (
    make_ast,
    make_call,
    make_field_initializer,
    make_function,
    make_name,
    make_type_default_value,
    set_store_context,
)
from as3.constants import augmented_assign_operations, binary_operations, init_name, this_name, unary_operations
from as3.enums import TokenType
from as3.exceptions import ASSyntaxError
from as3.runtime import ASAny, ASObject
from as3.scanner import Token


@dataclass
class Context:
    """
    Represents the current parser context.
    """
    package_name: Optional[str] = None
    class_name: Optional[str] = None
    # FIXME: wrap the following two attributes into an object maybe?
    internal_init_body: Optional[List[AST]] = None  # fields initialization
    constructor_init_body: Optional[List[AST]] = None  # transpiled ActionScript constructor

    def make_inner(self) -> Context:
        # Inner context should not have access to `__init__`.
        return replace(self, internal_init_body=None, constructor_init_body=None)


class Parser:
    def __init__(self, tokens: Iterable[Token]):
        self.tokens = peekable(filter_tokens(tokens))
        self.context_stack = [Context()]

    # Context helpers.
    # ------------------------------------------------------------------------------------------------------------------

    @property
    def context(self) -> Context:
        return self.context_stack[-1]

    @contextmanager
    def push_context(self) -> ContextManager[Context]:
        context = self.context.make_inner()
        self.context_stack.append(context)
        try:
            yield context
        finally:
            self.context_stack.pop()

    # Rules.
    # ------------------------------------------------------------------------------------------------------------------

    def parse_script(self) -> AST:
        """
        Parse *.as script.
        """
        statements: List[AST] = []
        while self.tokens:
            if self.is_type(TokenType.PACKAGE):
                statements.extend(self.parse_package())
            else:
                statements.extend(self.parse_statement())
        return ast.Module(body=statements)

    def parse_package(self) -> Iterable[AST]:
        self.expect(TokenType.PACKAGE)
        package_name = tuple(self.parse_qualified_name()) if self.is_type(TokenType.IDENTIFIER) else ()
        with self.push_context() as context:
            context.package_name = package_name  # FIXME: `package_name`.
            yield from self.parse_statement()

    def parse_class(self) -> Iterable[AST]:
        class_token = self.expect(TokenType.CLASS)
        name = self.expect(TokenType.IDENTIFIER).value

        # Inheritance: `extends`.
        if self.skip(TokenType.EXTENDS):
            bases = [self.parse_primary_expression()]
        else:
            # Inherit from `ASObject` if no explicit bases.
            bases = [make_ast(class_token, ast.Name, id=ASObject.__name__, ctx=ast.Load())]

        # Parse body.
        with self.push_context() as context:
            context.class_name = name
            internal_init_body = context.internal_init_body = []
            constructor_init_body = context.constructor_init_body = []
            body = list(self.parse_statement())

        # Add `__init__`.
        body.append(make_function(
            class_token,
            name=init_name,
            args=[ast.arg(arg=this_name, annotation=None, lineno=class_token.line_number, col_offset=0)],
            body=[*internal_init_body, *constructor_init_body],
        ))

        yield make_ast(class_token, ast.ClassDef, name=name, bases=bases, keywords=[], body=body, decorator_list=[])

    def parse_statement(self) -> Iterable[AST]:
        consume(self.parse_modifiers())  # FIXME: should only be allowed in some contexts
        yield from self.switch({
            TokenType.CURLY_BRACKET_OPEN: self.parse_code_block,
            TokenType.IMPORT: self.parse_import,
            TokenType.CLASS: self.parse_class,
            TokenType.VAR: self.parse_variable_definition,
            TokenType.IF: self.parse_if,
            TokenType.SEMICOLON: self.parse_semicolon,
            TokenType.RETURN: self.parse_return,
            TokenType.FUNCTION: self.parse_function_definition,
        }, else_=self.parse_expression_statement)

    def parse_code_block(self) -> Iterable[AST]:
        self.expect(TokenType.CURLY_BRACKET_OPEN)
        while not self.is_type(TokenType.CURLY_BRACKET_CLOSE):
            yield from self.parse_statement()
        self.expect(TokenType.CURLY_BRACKET_CLOSE)

    def parse_expression_statement(self) -> Iterable[AST]:
        value = self.parse_expression()
        self.skip(TokenType.SEMICOLON)
        if isinstance(value, ast.stmt):
            # Already a statement.
            yield value
        else:
            # Others should be wrapped into `Expr` statement.
            yield ast.Expr(value=value, lineno=value.lineno, col_offset=0)

    def parse_qualified_name(self) -> Iterable[str]:
        """
        Parse qualified name and return its parts.
        """
        yield self.expect(TokenType.IDENTIFIER).value
        while self.skip(TokenType.DOT):
            yield self.expect(TokenType.IDENTIFIER).value

    def parse_modifiers(self) -> Iterable[TokenType]:
        """
        Parse modifiers like `public` and `static`.
        """
        while self.is_type(TokenType.STATIC, TokenType.PUBLIC, TokenType.OVERRIDE):
            yield self.tokens.next().type_

    def parse_import(self) -> Iterable[AST]:
        self.expect(TokenType.IMPORT)
        qualified_name = tuple(self.parse_qualified_name())  # FIXME: `parse_additive_expression`?
        self.expect(TokenType.SEMICOLON)
        return []  # FIXME

    def parse_if(self) -> Iterable[AST]:
        if_token = self.expect(TokenType.IF)
        self.expect(TokenType.PARENTHESIS_OPEN)
        test = self.parse_additive_expression()
        self.expect(TokenType.PARENTHESIS_CLOSE)
        body = list(self.parse_statement())
        or_else = list(self.parse_statement()) if self.skip(TokenType.ELSE) else []
        yield make_ast(if_token, ast.If, test=test, body=body, orelse=or_else)

    def parse_variable_definition(self) -> Iterable[AST]:
        # TODO: should accept modifiers.
        self.expect(TokenType.VAR)
        name_token = self.expect(TokenType.IDENTIFIER)
        if self.skip(TokenType.COLON):
            type_ = self.parse_type_annotation()
        else:
            type_ = make_name(name_token, ASAny.__name__)
        if self.skip(TokenType.ASSIGN):
            value = self.parse_additive_expression()
        else:
            value = make_type_default_value(name_token, type_)
        if not self.context.class_name:
            # TODO: static fields.
            # It's a normal variable or a static "field". So just assign the value and that's it.
            yield make_ast(name_token, ast.Assign, targets=[make_name(name_token, ctx=ast.Store())], value=value)
        else:
            # We have to initialize the attribute on an instance.
            # Remember the variable for now and return. We'll initialize it later in `__init__`.
            assert self.context.internal_init_body is not None
            self.context.internal_init_body.append(make_field_initializer(name_token, value))

    def parse_type_annotation(self) -> AST:
        if self.is_type(TokenType.MULTIPLY):
            star_token = self.tokens.next()
            return make_name(star_token, ASAny.__name__)
        return self.parse_primary_expression()

    def parse_semicolon(self) -> Iterable[AST]:
        pass_token = self.expect(TokenType.SEMICOLON)
        yield make_ast(pass_token, ast.Pass)

    def parse_return(self) -> Iterable[AST]:
        return_token = self.expect(TokenType.RETURN)
        if not self.skip(TokenType.SEMICOLON):
            value = self.parse_expression()
        else:
            value = None
        yield make_ast(return_token, ast.Return, value=value)

    def parse_function_definition(self) -> Iterable[AST]:
        function_token = self.expect(TokenType.FUNCTION)
        name = self.expect(TokenType.IDENTIFIER).value

        # Parse arguments.
        self.expect(TokenType.PARENTHESIS_OPEN)
        args: List[AST] = []
        defaults: List[AST] = []
        while not self.skip(TokenType.PARENTHESIS_CLOSE):
            name_token = self.expect(TokenType.IDENTIFIER)
            args.append(make_ast(name_token, ast.arg, arg=name_token.value, annotation=None))
            if self.skip(TokenType.COLON):
                type_ = self.parse_type_annotation()
            else:
                type_ = make_name(name_token, ASAny.__name__)
            if self.skip(TokenType.ASSIGN):
                defaults.append(self.parse_additive_expression())
            else:
                defaults.append(make_type_default_value(name_token, type_))
            self.skip(TokenType.COMMA)
        returns = self.parse_additive_expression() if self.skip(TokenType.COLON) else None

        # Is it a method?
        if self.context.class_name:
            # Then, `__this__` is available in the function.
            # TODO: wrap with `@classmethod` if `static`.
            args.append(ast.arg(arg=this_name, annotation=None, lineno=function_token.line_number, col_offset=0))

        # Parse body.
        with self.push_context() as context:
            context.class_name = None  # prevent inner functions from being methods
            body = list(self.parse_statement())

        if name == self.context.class_name:
            # Constructor.
            assert self.context.constructor_init_body is not None
            self.context.constructor_init_body.extend(body)
        else:
            yield make_function(function_token, name=name, body=body, args=args, defaults=defaults, returns=returns)

    # Expression rules.
    # Methods are ordered according to reversed precedence.
    # https://www.adobe.com/devnet/actionscript/learning/as3-fundamentals/operators.html#articlecontentAdobe_numberedheader_1
    # ------------------------------------------------------------------------------------------------------------------

    def parse_expression(self) -> AST:
        return self.parse_assignment_expression()

    def parse_assignment_expression(self) -> AST:
        left = self.parse_additive_expression()
        return self.switch({
            TokenType.ASSIGN: self.parse_chained_assignment_expression,
            TokenType.ASSIGN_ADD: self.parse_augmented_assignment_expression,
        }, default=left, left=left)

    def parse_chained_assignment_expression(self, left: AST) -> AST:
        # First, assume it's not a chained assignment.
        assignment_token = self.expect(TokenType.ASSIGN)
        set_store_context(left, assignment_token)
        value = self.parse_additive_expression()
        left = make_ast(assignment_token, ast.Assign, targets=[left], value=value)
        # Then, check if it's chained.
        while self.skip(TokenType.ASSIGN):
            # Yes, it is. Read a value at the right.
            value = self.parse_additive_expression()
            # Former value becomes a target.
            left.targets.append(set_store_context(left.value, assignment_token))
            # Value at the right becomes the assigned value.
            left.value = value
        return left

    def parse_augmented_assignment_expression(self, left: AST) -> AST:
        assignment_token = self.expect(*augmented_assign_operations)
        set_store_context(left, assignment_token)
        value = self.parse_additive_expression()
        op = augmented_assign_operations[assignment_token.type_]
        return make_ast(assignment_token, ast.AugAssign, target=left, op=op, value=value)

    def parse_additive_expression(self) -> AST:
        """
        Used where comma operator and assignment are not allowed.
        """
        return self.parse_binary_operations(
            self.parse_multiplicative_expression,
            TokenType.PLUS,
            TokenType.MINUS,
        )

    def parse_multiplicative_expression(self) -> AST:
        return self.parse_binary_operations(
            self.parse_unary_expression,
            TokenType.MULTIPLY,
            TokenType.DIVIDE,
        )

    def parse_unary_expression(self) -> AST:
        if self.is_type(*unary_operations):
            operation_token: Token = self.tokens.next()
            return make_ast(
                operation_token,
                ast.UnaryOp,
                op=unary_operations[operation_token.type_],
                operand=self.parse_unary_expression(),
            )
        return self.parse_primary_expression()

    def parse_primary_expression(self) -> AST:
        left = self.parse_terminal_or_parenthesized()
        cases = {
            TokenType.DOT: self.parse_attribute_expression,
            TokenType.PARENTHESIS_OPEN: self.parse_call_expression,
        }
        while self.is_type(*cases):
            left = self.switch(cases, left=left)
        return left

    def parse_attribute_expression(self, left: AST) -> AST:
        attribute_token = self.expect(TokenType.DOT)
        attr: str = self.expect(TokenType.IDENTIFIER).value
        return make_ast(attribute_token, ast.Attribute, value=left, attr=attr, ctx=ast.Load())

    def parse_call_expression(self, left: AST) -> AST:
        call_token = self.expect(TokenType.PARENTHESIS_OPEN)
        args: List[AST] = []
        while not self.skip(TokenType.PARENTHESIS_CLOSE):
            args.append(self.parse_assignment_expression())
            self.skip(TokenType.COMMA)
        return make_call(call_token, func=left, args=args)

    def parse_terminal_or_parenthesized(self) -> AST:
        return self.switch({
            TokenType.PARENTHESIS_OPEN: self.parse_parenthesized_expression,
            TokenType.INTEGER: self.parse_integer_expression,
            TokenType.IDENTIFIER: self.parse_name_expression,
            TokenType.TRUE: lambda **_: make_ast(self.expect(TokenType.TRUE), ast.NameConstant, value=True),
            TokenType.FALSE: lambda **_: make_ast(self.expect(TokenType.FALSE), ast.NameConstant, value=False),
            TokenType.THIS: lambda **_: make_ast(self.expect(TokenType.THIS), ast.Name, id=this_name, ctx=ast.Load()),
            TokenType.SUPER: self.parse_super_expression,
        })

    def parse_parenthesized_expression(self) -> AST:
        self.expect(TokenType.PARENTHESIS_OPEN)
        inner = self.parse_expression()
        self.expect(TokenType.PARENTHESIS_CLOSE)
        return inner

    def parse_integer_expression(self) -> AST:
        value_token = self.expect(TokenType.INTEGER)
        # TODO: cast to `ASInteger`.
        return make_ast(value_token, ast.Num, n=value_token.value)

    def parse_name_expression(self) -> AST:
        name_token = self.expect(TokenType.IDENTIFIER)

        # Build `__resolve__(name)[name]`. See also `as3.runtime.__resolve__`.
        name_node = make_ast(name_token, ast.Str, s=name_token.value)
        return make_ast(
            name_token,
            ast.Subscript,
            value=make_call(name_token, func=make_name(name_token, '__resolve__'), args=[name_node]),
            slice=make_ast(name_token, ast.Index, value=name_node),
            ctx=ast.Load(),
        )

    def parse_super_expression(self) -> AST:
        super_token = self.expect(TokenType.SUPER)
        left = make_call(super_token, make_name(super_token))
        if self.is_type(TokenType.PARENTHESIS_OPEN):
            # Call super constructor. Return `super().__init__` and let `parse_call_expression` do its job.
            return self.parse_call_expression(make_ast(super_token, ast.Attribute, value=left, attr=init_name, ctx=ast.Load()))
        if self.is_type(TokenType.DOT):
            # Call super method. Return `super()` and let `parse_attribute_expression` do its job.
            return self.parse_attribute_expression(left)
        self.raise_expected_error(TokenType.PARENTHESIS_OPEN, TokenType.DOT)

    # Expression rule helpers.
    # ------------------------------------------------------------------------------------------------------------------

    def parse_binary_operations(self, child_parser: Callable[[], AST], *types: TokenType) -> AST:
        left = child_parser()
        while self.is_type(*types):
            operation_token: Token = self.tokens.next()
            op = binary_operations[operation_token.type_]
            left = make_ast(operation_token, ast.BinOp, left=left, op=op, right=child_parser())
        return left

    # Parser helpers.
    # ------------------------------------------------------------------------------------------------------------------

    TParserReturn = TypeVar('TParserReturn')
    TParser = Callable[..., TParserReturn]

    def switch(self, cases: Dict[TokenType, TParser], else_: TParser = None, default: TParserReturn = None, **kwargs) -> TParserReturn:
        """
        Behaves like a `switch` (`case`) operator and tries to match the current token against specified token types.
        If match is found, then the corresponding parser is called.
        Otherwise, `else_` is called if defined.
        Otherwise, `default` is returned if defined.
        Otherwise, syntax error is raised.
        """
        assert not else_ or not default, "`else_` and `default` can't be used together"
        try:
            parser = cases[self.tokens.peek().type_]
        except (StopIteration, KeyError):
            if else_:
                return else_(**kwargs)
            if default:
                return default
            self.raise_expected_error(*cases.keys())
        else:
            return parser(**kwargs)

    def expect(self, *types: TokenType) -> Token:
        """
        Check the current token type, return it and advance.
        Raise syntax error if the current token has an unexpected type.
        """
        if self.is_type(*types):
            return self.tokens.next()
        self.raise_expected_error(*types)

    def is_type(self, *types: TokenType) -> bool:
        """
        Check the current token type.
        """
        return self.tokens and self.tokens.peek().type_ in types

    def skip(self, *types: TokenType) -> bool:
        """
        Check the current token type and skip it if matches.
        """
        if self.is_type(*types):
            self.tokens.next()
            return True
        return False

    def raise_expected_error(self, *types: TokenType) -> NoReturn:
        """
        Raise syntax error with the list of expected types in the message.
        """
        types_string = ', '.join(type_.name for type_ in types)
        if not self.tokens:
            raise_syntax_error(f'unexpected end of file, expected one of: {types_string}')
        token: Token = self.tokens.peek()
        raise_syntax_error(f'unexpected {token.type_.name} "{token.value}", expected one of: {types_string}', token)


def filter_tokens(tokens: Iterable[Token]) -> Iterable[Token]:
    return (token for token in tokens if token.type_ != TokenType.COMMENT)


def raise_syntax_error(message: str, token: Optional[Token] = None) -> NoReturn:
    """
    Raise syntax error and provide some help message.
    """
    if token:
        raise ASSyntaxError(f'syntax error: {message} at line {token.line_number} position {token.position}')
    else:
        raise ASSyntaxError(f'syntax error: {message}')
