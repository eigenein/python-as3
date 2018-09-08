from __future__ import annotations

import ast
from ast import AST
from contextlib import contextmanager
from dataclasses import dataclass, field, replace
from typing import Callable, Dict, Iterable, Iterator, List, NoReturn, Optional, TypeVar

from as3.ast_ import (
    ASTBuilder,
    make_argument,
    make_ast,
    make_function,
    make_super_constructor_call,
    make_type_default_value,
)
from as3.constants import augmented_assign_operations, init_name, this_name, unary_operations
from as3.enums import TokenType
from as3.exceptions import ASSyntaxError
from as3.itertools_ import Peekable
from as3.runtime import ASAny, ASObject
from as3.scanner import Token


# FIXME: I feel that the context was not a good idea, so it's better to implement the same in some other way.
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
    internal_body: List[AST] = field(default_factory=list)
    node: Optional[AST] = None
    is_super_called: bool = False


class Parser:
    def __init__(self, tokens: Iterable[Token]) -> None:
        self.tokens = Peekable(filter_tokens(tokens))
        self.context_stack = [Context()]

    # Context helpers.
    # ------------------------------------------------------------------------------------------------------------------

    @property
    def context(self) -> Context:
        return self.context_stack[-1]

    @contextmanager
    def push_context(self) -> Iterator[Context]:
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
            statements.extend(self.switch({
                TokenType.PACKAGE: self.parse_package,
            }, else_=self.parse_statement))
        return ast.Module(body=statements)

    def parse_package(self) -> Iterable[AST]:
        self.expect(TokenType.PACKAGE)
        package_name = tuple(self.parse_qualified_name()) if self.is_type(TokenType.IDENTIFIER) else ()
        with self.push_context() as context:
            context.package_name = package_name  # type: ignore
            yield from self.parse_statement()
        # TODO: export public members.

    def parse_class(self) -> Iterable[AST]:
        class_token = self.expect(TokenType.CLASS)
        name = self.expect(TokenType.IDENTIFIER).value

        # Inheritance: `extends`.
        if self.skip(TokenType.EXTENDS):
            bases = [self.parse_primary_expression()]
        else:
            # Inherit from `ASObject` if no explicit bases.
            bases = [ASTBuilder.name(class_token, ASObject.__name__).node]

        # Parse body.
        with self.push_context() as context:
            context.class_name = name
            constructor = context.constructor = ConstructorContext()
            body = list(self.parse_statement())
            if not constructor.is_super_called:
                constructor.internal_body.insert(0, make_super_constructor_call(class_token))

        # Add `__init__`.
        init_node = make_function(
            class_token,
            name=init_name,
            args=[make_argument(class_token, this_name)],
            body=constructor.internal_body,
        )
        if constructor.node is not None:
            assert constructor.node.args.args[0].arg == this_name  # type: ignore
            # Avoid adding `__this__` twice.
            init_node.args.args.extend(constructor.node.args.args[1:])  # type: ignore
            init_node.body.extend(constructor.node.body)  # type: ignore
        body.append(init_node)

        yield make_ast(class_token, ast.ClassDef, name=name, bases=bases, keywords=[], body=body, decorator_list=[])

    def parse_statement(self) -> Iterable[AST]:
        yield from self.switch({  # type: ignore
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

    def parse_import(self) -> Iterable[AST]:
        self.expect(TokenType.IMPORT)
        qualified_name = tuple(self.parse_qualified_name())  # FIXME: `parse_non_assignment_expression`
        self.expect(TokenType.SEMICOLON)
        return []  # FIXME: actually import name

    def parse_if(self) -> Iterable[AST]:
        if_token = self.expect(TokenType.IF)
        self.expect(TokenType.PARENTHESIS_OPEN)
        test = self.parse_non_assignment_expression()
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
            type_ = ASTBuilder.name(name_token, ASAny.__name__).node
        if self.skip(TokenType.ASSIGN):
            value = self.parse_non_assignment_expression()
        else:
            value = make_type_default_value(name_token, type_)
        if not self.context.class_name:
            # TODO: static fields, they now fall under `else`.
            # It's a normal variable or a static "field". So just assign the value and that's it.
            yield ASTBuilder.identifier(name_token).assign(name_token, value).node
        else:
            # We'll initialize it later in `__init__`: `__this__.field = value`.
            node = ASTBuilder \
                .name(name_token, this_name) \
                .attribute(name_token, name_token.value) \
                .assign(name_token, value) \
                .node
            self.context.constructor.internal_body.append(node)  # type: ignore

    def parse_type_annotation(self) -> AST:
        if self.is_type(TokenType.MULTIPLY):
            return ASTBuilder.name(next(self.tokens), ASAny.__name__).node
        return self.parse_primary_expression()

    def parse_semicolon(self) -> Iterable[AST]:
        pass_token = self.expect(TokenType.SEMICOLON)
        yield make_ast(pass_token, ast.Pass)

    def parse_return(self) -> Iterable[AST]:
        return_token = self.expect(TokenType.RETURN)
        if not self.skip(TokenType.SEMICOLON):
            value = self.parse_expression()
        else:
            value = ASTBuilder.name_constant(return_token, None).node
        yield ASTBuilder(value).return_(return_token).node

    def parse_function_definition(self) -> Iterable[AST]:
        function_token = self.expect(TokenType.FUNCTION)
        name = self.expect(TokenType.IDENTIFIER).value
        node = make_function(function_token, name=name)

        # Is it a method?
        if self.context.class_name:
            # Then, `__this__` is available in the function.
            # TODO: wrap with `@classmethod` if `static`.
            node.args.args.append(ast.arg(arg=this_name, annotation=None, lineno=function_token.line_number, col_offset=0))  # type: ignore

        # Parse arguments.
        self.expect(TokenType.PARENTHESIS_OPEN)
        while not self.skip(TokenType.PARENTHESIS_CLOSE):
            name_token = self.expect(TokenType.IDENTIFIER)
            node.args.args.append(make_argument(name_token, name_token.value))  # type: ignore
            if self.skip(TokenType.COLON):
                type_ = self.parse_type_annotation()
            else:
                type_ = ASTBuilder.name(name_token, ASAny.__name__).node
            if self.skip(TokenType.ASSIGN):
                node.args.defaults.append(self.parse_non_assignment_expression())  # type: ignore
            else:
                node.args.defaults.append(make_type_default_value(name_token, type_))  # type: ignore
            self.skip(TokenType.COMMA)

        # Skip return type.
        if self.skip(TokenType.COLON):
            self.parse_non_assignment_expression()

        # Parse body.
        with self.push_context() as context:
            context.class_name = None  # prevent inner functions from being methods
            node.body.extend(self.parse_statement())  # type: ignore

        if name == self.context.class_name:
            self.context.constructor.node = node  # type: ignore
        else:
            yield node

    # Expression rules.
    # Methods are ordered according to reversed precedence.
    # https://www.adobe.com/devnet/actionscript/learning/as3-fundamentals/operators.html#articlecontentAdobe_numberedheader_1
    # ------------------------------------------------------------------------------------------------------------------

    def parse_expression(self) -> AST:
        return self.parse_assignment_expression()

    def parse_assignment_expression(self) -> AST:
        left = self.parse_non_assignment_expression()
        return self.switch({
            TokenType.ASSIGN: self.parse_chained_assignment_expression,
            TokenType.ASSIGN_ADD: self.parse_augmented_assignment_expression,
        }, else_=lambda **_: left, left=left)

    def parse_chained_assignment_expression(self, left: AST) -> AST:
        assignment_token = self.expect(TokenType.ASSIGN)
        builder = ASTBuilder(left).assign(assignment_token, self.parse_non_assignment_expression())
        while self.is_type(TokenType.ASSIGN):
            assignment_token = next(self.tokens)
            builder.assign(assignment_token, self.parse_non_assignment_expression())
        return builder.node

    def parse_augmented_assignment_expression(self, left: AST) -> AST:
        assignment_token = self.expect(*augmented_assign_operations)
        value = self.parse_non_assignment_expression()
        return ASTBuilder(left).aug_assign(assignment_token, value).node

    def parse_non_assignment_expression(self) -> AST:
        return self.parse_equality_expression()

    def parse_equality_expression(self) -> AST:
        return self.parse_binary_operations(
            self.parse_additive_expression,
            TokenType.NOT_EQUALS,
        )

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
            token: Token = next(self.tokens)
            return ASTBuilder(self.parse_unary_expression()).unary_operation(token).node
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
        name: str = self.expect(TokenType.IDENTIFIER).value
        return ASTBuilder(left).attribute(attribute_token, name).node

    def parse_call_expression(self, left: AST) -> AST:
        call_token = self.expect(TokenType.PARENTHESIS_OPEN)
        args: List[AST] = []
        while not self.skip(TokenType.PARENTHESIS_CLOSE):
            args.append(self.parse_non_assignment_expression())
            self.skip(TokenType.COMMA)
        return ASTBuilder(left).call(call_token, args).node

    def parse_terminal_or_parenthesized(self) -> AST:
        return self.switch({
            TokenType.PARENTHESIS_OPEN: self.parse_parenthesized_expression,
            TokenType.INTEGER: self.parse_integer_expression,
            TokenType.IDENTIFIER: self.parse_name_expression,
            TokenType.TRUE: lambda: ASTBuilder.name_constant(next(self.tokens), True).node,
            TokenType.FALSE: lambda: ASTBuilder.name_constant(next(self.tokens), False).node,
            TokenType.THIS: lambda: make_ast(self.expect(TokenType.THIS), ast.Name, id=this_name, ctx=ast.Load()),
            TokenType.SUPER: self.parse_super_expression,
        })

    def parse_parenthesized_expression(self) -> AST:
        self.expect(TokenType.PARENTHESIS_OPEN)
        inner = self.parse_expression()
        self.expect(TokenType.PARENTHESIS_CLOSE)
        return inner

    def parse_integer_expression(self) -> AST:
        value_token = self.expect(TokenType.INTEGER)
        # `int(42)`
        return ASTBuilder.name(value_token, 'int') \
            .call(value_token, args=[ASTBuilder.number(value_token).node]) \
            .node

    def parse_name_expression(self) -> AST:
        name_token = self.expect(TokenType.IDENTIFIER)

        # Build `__resolve__(name)[name]`. See also `as3.runtime.__resolve__`.
        name_node = ASTBuilder.string(name_token).node
        return ASTBuilder \
            .name(name_token, '__resolve__') \
            .call(name_token, [name_node]) \
            .subscript(name_token, name_node) \
            .node

    def parse_super_expression(self) -> AST:
        super_token = self.expect(TokenType.SUPER)
        builder = ASTBuilder.identifier(super_token).call(super_token)
        if self.is_type(TokenType.PARENTHESIS_OPEN):
            # Call super constructor. Return `super().__init__` and let `parse_call_expression` do its job.
            self.context.constructor.is_super_called = True  # type: ignore
            return self.parse_call_expression(builder.attribute(super_token, init_name).node)
        if self.is_type(TokenType.DOT):
            # Call super method. Return `super()` and let `parse_attribute_expression` do its job.
            return self.parse_attribute_expression(builder.node)
        self.raise_expected_error(TokenType.PARENTHESIS_OPEN, TokenType.DOT)

    # Expression rule helpers.
    # ------------------------------------------------------------------------------------------------------------------

    def parse_binary_operations(self, child_parser: Callable[[], AST], *types: TokenType) -> AST:
        builder = ASTBuilder(child_parser())
        while self.is_type(*types):
            token: Token = next(self.tokens)
            builder.binary_operation(token, child_parser())
        return builder.node

    # Parser helpers.
    # ------------------------------------------------------------------------------------------------------------------

    TParserReturn = TypeVar('TParserReturn')
    TParser = Callable[..., TParserReturn]

    def switch(self, cases: Dict[TokenType, TParser], else_: TParser = None, **kwargs) -> TParserReturn:
        """
        Behaves like a `switch` (`case`) operator and tries to match the current token against specified token types.
        If match is found, then the corresponding parser is called.
        Otherwise, `else_` is called if defined.
        Otherwise, `default` is returned if defined.
        Otherwise, syntax error is raised.
        """
        try:
            parser = cases[self.tokens.peek().type_]
        except (StopIteration, KeyError):
            if else_:
                return else_(**kwargs)
            self.raise_expected_error(*cases.keys())
        else:
            return parser(**kwargs)

    def expect(self, *types: TokenType) -> Token:
        """
        Check the current token type, return it and advance.
        Raise syntax error if the current token has an unexpected type.
        """
        if self.is_type(*types):
            return next(self.tokens)
        self.raise_expected_error(*types)

    def is_type(self, *types: TokenType) -> bool:
        """
        Check the current token type.
        """
        try:
            return self.tokens.peek().type_ in types
        except StopIteration:
            return False

    def skip(self, *types: TokenType) -> bool:
        """
        Check the current token type and skip it if matches.
        """
        if self.is_type(*types):
            next(self.tokens)
            return True
        return False

    def raise_expected_error(self, *types: TokenType) -> NoReturn:
        """
        Raise syntax error with the list of expected types in the message.
        """
        types_string = ', '.join(type_.name for type_ in types)
        try:
            token = self.tokens.peek()
        except StopIteration:
            raise_syntax_error(f'unexpected end of file, expected one of: {types_string}')
        else:
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
