from __future__ import annotations

import ast
from collections import deque
from contextlib import contextmanager
from typing import Callable, Deque, Dict, Iterable, Iterator, List, NoReturn, Optional, TypeVar

from as3.ast_ import AST, make_ast, make_function
from as3.constants import augmented_assign_operations, init_name, this_name, unary_operations
from as3.context import ConstructorContext, Context
from as3.enums import TokenType
from as3.exceptions import ASSyntaxError
from as3.runtime import ASAny
from as3.scanner import Token


class Parser:
    def __init__(self, tokens: Iterable[Token]) -> None:
        self.tokens = Peekable(filter_tokens(tokens))
        self.context_stack = [Context()]

    # Context helpers.
    # FIXME: I feel that the context was not a good idea, so it's better to implement the same in some other way.
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

    def parse_script(self) -> ast.AST:
        """
        Parse *.as script.
        """
        statements: List[ast.AST] = []
        while self.tokens:
            statements.extend(self.switch({
                TokenType.PACKAGE: self.parse_package,
            }, else_=self.parse_statement))
        return AST.script(statements).node

    def parse_package(self) -> Iterable[ast.AST]:
        self.expect(TokenType.PACKAGE)
        package_name = tuple(self.parse_qualified_name()) if self.tokens.is_type(TokenType.IDENTIFIER) else ()
        with self.push_context() as context:
            context.package_name = package_name  # type: ignore
            yield from self.parse_statement()
        # TODO: export public members.

    def parse_class(self) -> Iterable[ast.AST]:
        class_token = self.expect(TokenType.CLASS)
        name = self.expect(TokenType.IDENTIFIER).value

        base: Optional[ast.AST] = self.parse_primary_expression() if self.tokens.skip(TokenType.EXTENDS) else None

        with self.push_context() as context:
            context.class_name = name
            constructor = context.constructor = ConstructorContext()
            body = list(self.parse_statement())

        yield AST.class_(with_token=class_token, name=name, base=base, body=body, constructor=constructor).node

    def parse_statement(self) -> Iterable[ast.AST]:
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

    def parse_code_block(self) -> Iterable[ast.AST]:
        self.expect(TokenType.CURLY_BRACKET_OPEN)
        while not self.tokens.is_type(TokenType.CURLY_BRACKET_CLOSE):
            yield from self.parse_statement()
        self.expect(TokenType.CURLY_BRACKET_CLOSE)

    def parse_expression_statement(self) -> Iterable[ast.AST]:
        value = self.parse_expression()
        self.tokens.skip(TokenType.SEMICOLON)
        yield AST.expression_statement(value).node

    def parse_qualified_name(self) -> Iterable[str]:
        """
        Parse qualified name and return its parts.
        """
        yield self.expect(TokenType.IDENTIFIER).value
        while self.tokens.skip(TokenType.DOT):
            yield self.expect(TokenType.IDENTIFIER).value

    def parse_import(self) -> Iterable[ast.AST]:
        self.expect(TokenType.IMPORT)
        qualified_name = tuple(self.parse_qualified_name())  # FIXME: `parse_non_assignment_expression`
        self.expect(TokenType.SEMICOLON)
        return []  # FIXME: actually import name

    def parse_if(self) -> Iterable[ast.AST]:
        if_token = self.expect(TokenType.IF)
        self.expect(TokenType.PARENTHESIS_OPEN)
        test = self.parse_non_assignment_expression()
        self.expect(TokenType.PARENTHESIS_CLOSE)
        body = list(self.parse_statement())
        or_else = list(self.parse_statement()) if self.tokens.skip(TokenType.ELSE) else []
        yield make_ast(if_token, ast.If, test=test, body=body, orelse=or_else)

    # FIXME: move AST construction to the builder.
    def parse_variable_definition(self) -> Iterable[ast.AST]:
        # TODO: should accept modifiers.
        self.expect(TokenType.VAR)
        name_token = self.expect(TokenType.IDENTIFIER)
        if self.tokens.skip(TokenType.COLON):
            type_ = self.parse_type_annotation()
        else:
            type_ = AST.name(name_token, ASAny.__name__).node
        if self.tokens.skip(TokenType.ASSIGN):
            value = self.parse_non_assignment_expression()
        else:
            value = AST.type_default_value(name_token, type_).node
        if not self.context.class_name:
            # TODO: static fields, they now fall under `else`.
            # It's a normal variable or a static "field". So just assign the value and that's it.
            yield AST.identifier(name_token).assign(name_token, value).node
        else:
            # We'll initialize it later in `__init__`: `__this__.field = value`.
            node = AST \
                .name(name_token, this_name) \
                .attribute(name_token, name_token.value) \
                .assign(name_token, value) \
                .node
            self.context.constructor.internal_body.append(node)  # type: ignore

    def parse_type_annotation(self) -> ast.AST:
        if self.tokens.is_type(TokenType.MULTIPLY):
            return AST.name(next(self.tokens), ASAny.__name__).node
        return self.parse_primary_expression()

    def parse_semicolon(self) -> Iterable[ast.AST]:
        pass_token = self.expect(TokenType.SEMICOLON)
        yield make_ast(pass_token, ast.Pass)

    def parse_return(self) -> Iterable[ast.AST]:
        return_token = self.expect(TokenType.RETURN)
        if not self.tokens.skip(TokenType.SEMICOLON):
            builder = AST(self.parse_expression())
        else:
            builder = AST.name_constant(return_token, None)
        yield builder.return_it(return_token).node

    # FIXME: move AST construction to the builder.
    def parse_function_definition(self) -> Iterable[ast.AST]:
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
        while not self.tokens.skip(TokenType.PARENTHESIS_CLOSE):
            name_token = self.expect(TokenType.IDENTIFIER)
            node.args.args.append(AST.argument(name_token, name_token.value).node)  # type: ignore
            if self.tokens.skip(TokenType.COLON):
                type_ = self.parse_type_annotation()
            else:
                type_ = AST.name(name_token, ASAny.__name__).node
            if self.tokens.skip(TokenType.ASSIGN):
                node.args.defaults.append(self.parse_non_assignment_expression())  # type: ignore
            else:
                node.args.defaults.append(AST.type_default_value(name_token, type_).node)  # type: ignore
            self.tokens.skip(TokenType.COMMA)

        # Skip return type.
        if self.tokens.skip(TokenType.COLON):
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

    def parse_expression(self) -> ast.AST:
        return self.parse_assignment_expression()

    def parse_assignment_expression(self) -> ast.AST:
        left = self.parse_non_assignment_expression()
        return self.switch({
            TokenType.ASSIGN: self.parse_chained_assignment_expression,
            TokenType.ASSIGN_ADD: self.parse_augmented_assignment_expression,
        }, else_=lambda **_: left, left=left)

    def parse_chained_assignment_expression(self, left: ast.AST) -> ast.AST:
        assignment_token = self.expect(TokenType.ASSIGN)
        builder = AST(left).assign(assignment_token, self.parse_non_assignment_expression())
        while self.tokens.is_type(TokenType.ASSIGN):
            assignment_token = next(self.tokens)
            builder.assign(assignment_token, self.parse_non_assignment_expression())
        return builder.node

    def parse_augmented_assignment_expression(self, left: ast.AST) -> ast.AST:
        assignment_token = self.expect(*augmented_assign_operations)
        value = self.parse_non_assignment_expression()
        return AST(left).aug_assign(assignment_token, value).node

    def parse_non_assignment_expression(self) -> ast.AST:
        return self.parse_equality_expression()

    def parse_equality_expression(self) -> ast.AST:
        return self.parse_binary_operations(
            self.parse_additive_expression,
            TokenType.NOT_EQUALS,
        )

    def parse_additive_expression(self) -> ast.AST:
        """
        Used where comma operator and assignment are not allowed.
        """
        return self.parse_binary_operations(self.parse_multiplicative_expression, TokenType.PLUS, TokenType.MINUS)

    def parse_multiplicative_expression(self) -> ast.AST:
        return self.parse_binary_operations(self.parse_unary_expression, TokenType.MULTIPLY, TokenType.DIVIDE)

    def parse_unary_expression(self) -> ast.AST:
        if self.tokens.is_type(*unary_operations):
            token = next(self.tokens)
            return AST(self.parse_unary_expression()).unary_operation(token).node
        return self.parse_primary_expression()

    def parse_primary_expression(self) -> ast.AST:
        left = self.parse_terminal_or_parenthesized()
        cases = {
            TokenType.DOT: self.parse_attribute_expression,
            TokenType.PARENTHESIS_OPEN: self.parse_call_expression,
        }
        while self.tokens.is_type(*cases):
            left = self.switch(cases, left=left)
        return left

    def parse_attribute_expression(self, left: ast.AST) -> ast.AST:
        attribute_token = self.expect(TokenType.DOT)
        name: str = self.expect(TokenType.IDENTIFIER).value
        return AST(left).attribute(attribute_token, name).node

    def parse_call_expression(self, left: ast.AST) -> ast.AST:
        call_token = self.expect(TokenType.PARENTHESIS_OPEN)
        args: List[ast.AST] = []
        while not self.tokens.skip(TokenType.PARENTHESIS_CLOSE):
            args.append(self.parse_non_assignment_expression())
            self.tokens.skip(TokenType.COMMA)
        return AST(left).call(call_token, args).node

    def parse_terminal_or_parenthesized(self) -> ast.AST:
        return self.switch({
            TokenType.PARENTHESIS_OPEN: self.parse_parenthesized_expression,
            TokenType.INTEGER: self.parse_integer_expression,
            TokenType.IDENTIFIER: self.parse_name_expression,
            TokenType.TRUE: lambda: AST.name_constant(next(self.tokens), True).node,
            TokenType.FALSE: lambda: AST.name_constant(next(self.tokens), False).node,
            TokenType.THIS: lambda: make_ast(self.expect(TokenType.THIS), ast.Name, id=this_name, ctx=ast.Load()),
            TokenType.SUPER: self.parse_super_expression,
        })

    def parse_parenthesized_expression(self) -> ast.AST:
        self.expect(TokenType.PARENTHESIS_OPEN)
        inner = self.parse_expression()
        self.expect(TokenType.PARENTHESIS_CLOSE)
        return inner

    def parse_integer_expression(self) -> ast.AST:
        return AST.integer_expression(self.expect(TokenType.INTEGER)).node

    def parse_name_expression(self) -> ast.AST:
        return AST.name_expression(self.expect(TokenType.IDENTIFIER)).node

    def parse_super_expression(self) -> ast.AST:
        super_token = self.expect(TokenType.SUPER)
        builder = AST.identifier(super_token).call(super_token)
        if self.tokens.is_type(TokenType.PARENTHESIS_OPEN):
            # Call super constructor. Return `super().__init__` and let `parse_call_expression` do its job.
            self.context.constructor.is_super_called = True  # type: ignore
            return self.parse_call_expression(builder.attribute(super_token, init_name).node)
        if self.tokens.is_type(TokenType.DOT):
            # Call super method. Return `super()` and let `parse_attribute_expression` do its job.
            return self.parse_attribute_expression(builder.node)
        self.raise_syntax_error(TokenType.PARENTHESIS_OPEN, TokenType.DOT)

    # Expression rule helpers.
    # ------------------------------------------------------------------------------------------------------------------

    def parse_binary_operations(self, child_parser: Callable[[], ast.AST], *types: TokenType) -> ast.AST:
        builder = AST(child_parser())
        while self.tokens.is_type(*types):
            token = next(self.tokens)
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
            self.raise_syntax_error(*cases.keys())
        else:
            return parser(**kwargs)

    def expect(self, *types: TokenType) -> Token:
        """
        Check the current token type, return it and advance.
        Raise syntax error if the current token has an unexpected type.
        """
        if self.tokens.is_type(*types):
            return next(self.tokens)
        self.raise_syntax_error(*types)

    def raise_syntax_error(self, *expected_types: TokenType) -> NoReturn:
        """
        Raise syntax error with the list of expected types in the message.
        """
        types_string = ', '.join(type_.name for type_ in expected_types)
        try:
            token = self.tokens.peek()
        except StopIteration:
            raise_syntax_error(f'unexpected end of file, expected one of: {types_string}')
        else:
            raise_syntax_error(f'unexpected {token.type_.name} "{token.value}", expected one of: {types_string}', token)


class Peekable(Iterable[Token]):
    def __init__(self, iterable: Iterable[Token]) -> None:
        self.iterator = iter(iterable)
        self.cache: Deque[Token] = deque()

    def __iter__(self) -> Iterator[Token]:
        return self

    def __next__(self) -> Token:
        self.peek()
        return self.cache.popleft()

    def __bool__(self):
        try:
            self.peek()
        except StopIteration:
            return False
        else:
            return True

    def peek(self) -> Token:
        if not self.cache:
            self.cache.append(next(self.iterator))
        return self.cache[0]

    def is_type(self, *types: TokenType) -> bool:
        """
        Check the current token type.
        """
        try:
            return self.peek().type_ in types
        except StopIteration:
            return False

    def skip(self, *types: TokenType) -> bool:
        """
        Check the current token type and skip it if matches.
        """
        if self.is_type(*types):
            next(self)
            return True
        return False


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
