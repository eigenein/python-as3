from __future__ import annotations

import ast
from collections import deque
from typing import Callable, Container, Deque, Dict, Iterable, Iterator, List, NoReturn, Optional, TypeVar, cast

from as3 import constants
from as3.ast_ import AST, make_ast, make_function
from as3.enums import TokenType
from as3.exceptions import ASSyntaxError
from as3.runtime import ASAny
from as3.scanner import Location, Token


class Parser:
    def __init__(self, tokens: Iterable[Token], filename: str) -> None:
        self.tokens = Peekable(filter_tokens(tokens))
        self.filename = filename

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
        if self.tokens.is_type(TokenType.IDENTIFIER):
            # TODO: for now just consume the name because we'll use the directory structure instead.
            for _ in self.parse_qualified_name():
                pass
        yield from self.parse_statement()

    def parse_class(self, modifiers: Container[TokenType] = frozenset()) -> Iterable[ast.AST]:
        class_token = self.expect(TokenType.CLASS)
        name = self.expect(TokenType.IDENTIFIER).value
        base: Optional[ast.AST] = self.parse_primary_expression() if self.tokens.skip(TokenType.EXTENDS) else None
        body = list(self.parse_statement())
        yield AST.class_(location=class_token, name=name, base=base, body=body).node

    def parse_statement(self) -> Iterable[ast.AST]:
        yield from self.switch({  # type: ignore
            TokenType.BREAK: self.parse_break,
            TokenType.CLASS: self.parse_class,
            TokenType.CURLY_BRACKET_OPEN: self.parse_code_block,
            TokenType.FUNCTION: self.parse_function_definition,
            TokenType.IF: self.parse_if,
            TokenType.IMPORT: self.parse_import,
            TokenType.OVERRIDE: self.parse_modifiers,
            TokenType.PRIVATE: self.parse_modifiers,
            TokenType.PROTECTED: self.parse_modifiers,
            TokenType.PUBLIC: self.parse_modifiers,
            TokenType.RETURN: self.parse_return,
            TokenType.SEMICOLON: self.parse_semicolon,
            TokenType.STATIC: self.parse_modifiers,
            TokenType.VAR: self.parse_variable_definition,
            TokenType.WHILE: self.parse_while,
        }, else_=self.parse_expression_statement)

        # Skip all semicolons.
        while self.tokens.skip(TokenType.SEMICOLON):
            pass

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
        import_token = self.expect(TokenType.IMPORT)
        args = []
        while True:
            token = self.expect(TokenType.IDENTIFIER, TokenType.MULTIPLY)
            args.append(AST.string(token, token.value).node)
            if not self.tokens.skip(TokenType.DOT):
                break
        self.tokens.skip(TokenType.SEMICOLON)
        yield AST \
            .name(import_token, constants.import_name) \
            .call(import_token, args) \
            .expr() \
            .node

    def parse_if(self) -> Iterable[ast.AST]:
        if_token = self.expect(TokenType.IF)
        self.expect(TokenType.PARENTHESIS_OPEN)
        test = self.parse_non_assignment_expression()
        self.expect(TokenType.PARENTHESIS_CLOSE)
        body = list(self.parse_statement())
        or_else = list(self.parse_statement()) if self.tokens.skip(TokenType.ELSE) else []
        yield make_ast(if_token, ast.If, test=test, body=body, orelse=or_else)

    def parse_variable_definition(self, modifiers: Container[TokenType] = frozenset()) -> Iterable[ast.AST]:
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
        name = name_token.value
        if TokenType.STATIC in modifiers:
            name = f'{constants.static_prefix}{name}'
        yield AST.name(name_token, name).assign(name_token, value).node

    def parse_type_annotation(self) -> ast.AST:
        if self.tokens.is_type(TokenType.MULTIPLY):
            return AST.name(next(self.tokens), ASAny.__name__).node
        if self.tokens.is_type(TokenType.VOID):
            return AST.name_constant(next(self.tokens), None).node
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

    def parse_function_definition(self, modifiers: Container[TokenType] = frozenset()) -> Iterable[ast.FunctionDef]:
        function_token = self.expect(TokenType.FUNCTION)
        name = self.expect(TokenType.IDENTIFIER).value
        node = make_function(function_token, name=name, is_class_method=(TokenType.STATIC in modifiers))

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
            self.parse_type_annotation()

        # Parse body.
        node.body.extend(cast(List[ast.stmt], self.parse_statement()))

        yield node

    def parse_modifiers(self) -> Iterable[AST]:
        modifiers: List[TokenType] = []
        if self.tokens.skip(TokenType.OVERRIDE):
            modifiers.append(TokenType.OVERRIDE)
        visibility_token = self.tokens.skip(
            TokenType.PUBLIC, TokenType.PRIVATE, TokenType.PROTECTED, TokenType.INTERNAL)
        if visibility_token:
            modifiers.append(visibility_token.type_)
        if self.tokens.skip(TokenType.STATIC):
            modifiers.append(TokenType.STATIC)
        yield from self.switch({  # type: ignore
            TokenType.CLASS: self.parse_class,
            TokenType.VAR: self.parse_variable_definition,
            TokenType.FUNCTION: self.parse_function_definition,
        }, modifiers=set(modifiers))

    def parse_break(self) -> Iterable[ast.AST]:
        token = self.expect(TokenType.BREAK)
        yield AST.break_(token).node

    def parse_while(self) -> Iterable[ast.AST]:
        token = self.expect(TokenType.WHILE)
        self.expect(TokenType.PARENTHESIS_OPEN)
        test = self.parse_non_assignment_expression()
        self.expect(TokenType.PARENTHESIS_CLOSE)
        body = list(self.parse_statement())
        yield AST.while_(token, test, body).node

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
            TokenType.DECREMENT: self.parse_decrement,  # FIXME: unfortunately, decrement doesn't return a value.
            TokenType.INCREMENT: self.parse_increment,  # FIXME: unfortunately, increment doesn't return a value.
        }, else_=lambda **_: left, left=left)

    def parse_chained_assignment_expression(self, left: ast.AST) -> ast.AST:
        assignment_token = self.expect(TokenType.ASSIGN)
        builder = AST(left).assign(assignment_token, self.parse_non_assignment_expression())
        while self.tokens.is_type(TokenType.ASSIGN):
            assignment_token = next(self.tokens)
            builder.assign(assignment_token, self.parse_non_assignment_expression())
        return builder.node

    def parse_augmented_assignment_expression(self, left: ast.AST) -> ast.AST:
        assignment_token = self.expect(*constants.augmented_assign_operations)
        value = self.parse_non_assignment_expression()
        return AST(left).aug_assign(assignment_token, value).node

    def parse_increment(self, left: ast.AST) -> ast.AST:
        token = self.expect(TokenType.INCREMENT)
        return AST(left).increment(token).node

    def parse_decrement(self, left: ast.AST) -> ast.AST:
        token = self.expect(TokenType.DECREMENT)
        return AST(left).decrement(token).node

    def parse_non_assignment_expression(self) -> ast.AST:
        return self.parse_conditional_expression()

    def parse_conditional_expression(self) -> ast.AST:
        builder = AST(self.parse_logical_or_expression())
        if self.tokens.is_type(TokenType.QUESTION_MARK):
            token = next(self.tokens)
            body = self.parse_logical_or_expression()
            self.expect(TokenType.COLON)
            or_else = self.parse_logical_or_expression()
            builder.if_expression(token, body, or_else)
        return builder.node

    def parse_logical_or_expression(self) -> ast.AST:
        builder = AST(self.parse_logical_and_expression())
        while self.tokens.is_type(TokenType.LOGICAL_OR):
            token = next(self.tokens)
            builder.binary_operation(token, self.parse_logical_and_expression())
        return builder.node

    def parse_logical_and_expression(self) -> ast.AST:
        builder = AST(self.parse_equality_expression())
        while self.tokens.is_type(TokenType.LOGICAL_AND):
            token = next(self.tokens)
            builder.binary_operation(token, self.parse_equality_expression())
        return builder.node

    def parse_equality_expression(self) -> ast.AST:
        return self.parse_binary_operations(
            self.parse_relational_expression,
            TokenType.EQUALS,
            TokenType.NOT_EQUALS,
        )

    def parse_relational_expression(self) -> ast.AST:
        return self.parse_binary_operations(
            self.parse_additive_expression,
            TokenType.AS,
            TokenType.GREATER,
            TokenType.GREATER_OR_EQUAL,
            TokenType.IS,
            TokenType.LESS,
            TokenType.LESS_OR_EQUAL,
        )

    def parse_additive_expression(self) -> ast.AST:
        return self.parse_binary_operations(self.parse_multiplicative_expression, TokenType.PLUS, TokenType.MINUS)

    def parse_multiplicative_expression(self) -> ast.AST:
        return self.parse_binary_operations(self.parse_unary_expression, TokenType.MULTIPLY, TokenType.DIVIDE)

    def parse_unary_expression(self) -> ast.AST:
        if self.tokens.is_type(*constants.unary_operations):
            token = next(self.tokens)
            return AST(self.parse_unary_expression()).unary_operation(token).node
        return self.parse_primary_expression()

    def parse_primary_expression(self) -> ast.AST:
        left = self.parse_terminal_or_parenthesized()
        cases = {
            TokenType.BRACKET_OPEN: self.parse_subscript,
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

    def parse_subscript(self, left: ast.AST) -> ast.AST:
        token = self.expect(TokenType.BRACKET_OPEN)
        index = self.parse_non_assignment_expression()
        self.expect(TokenType.BRACKET_CLOSE)
        return AST(left).subscript(token, index).node

    def parse_terminal_or_parenthesized(self) -> ast.AST:
        return self.switch({
            TokenType.BRACKET_OPEN: self.parse_compound_literal,
            TokenType.FALSE: lambda: AST.name_constant(next(self.tokens), False).node,
            TokenType.IDENTIFIER: self.parse_name_expression,
            TokenType.NEW: self.parse_new,
            TokenType.NUMBER: self.parse_number_expression,
            TokenType.PARENTHESIS_OPEN: self.parse_parenthesized_expression,
            TokenType.STRING: self.parse_string_expression,
            TokenType.SUPER: self.parse_super_expression,
            TokenType.THIS: lambda: make_ast(self.expect(TokenType.THIS), ast.Name, id=constants.this_name, ctx=ast.Load()),
            TokenType.TRUE: lambda: AST.name_constant(next(self.tokens), True).node,
        })

    def parse_parenthesized_expression(self) -> ast.AST:
        self.expect(TokenType.PARENTHESIS_OPEN)
        inner = self.parse_expression()
        self.expect(TokenType.PARENTHESIS_CLOSE)
        return inner

    def parse_number_expression(self) -> ast.AST:
        return AST.number_expression(self.expect(TokenType.NUMBER)).node

    def parse_name_expression(self) -> ast.AST:
        name_token = self.expect(TokenType.IDENTIFIER)
        if self.tokens.skip(TokenType.GENERIC_OPEN):
            # Skip `.<Whatever>`.
            self.parse_additive_expression()
            self.expect(TokenType.GREATER)
        return AST.name_expression(name_token).node

    def parse_super_expression(self) -> ast.AST:
        super_token = self.expect(TokenType.SUPER)
        builder = AST.identifier(super_token).call(super_token)
        if self.tokens.is_type(TokenType.PARENTHESIS_OPEN):
            # Call super constructor. Return `super().__init__` and let `parse_call_expression` do its job.
            return self.parse_call_expression(builder.attribute(super_token, constants.init_name).node)
        if self.tokens.is_type(TokenType.DOT):
            # Call super method. Return `super()` and let `parse_attribute_expression` do its job.
            return self.parse_attribute_expression(builder.node)
        self.raise_syntax_error(TokenType.PARENTHESIS_OPEN, TokenType.DOT)

    def parse_string_expression(self) -> ast.AST:
        return AST.string_expression(self.expect(TokenType.STRING)).node

    def parse_new(self) -> ast.AST:
        self.expect(TokenType.NEW)  # ignored
        return self.parse_name_expression()

    def parse_compound_literal(self) -> ast.AST:
        token = self.expect(TokenType.BRACKET_OPEN)
        elements: List[ast.AST] = []
        while not self.tokens.skip(TokenType.BRACKET_CLOSE):
            elements.append(self.parse_non_assignment_expression())
            self.tokens.skip(TokenType.COMMA)
        return AST.list_(token, elements).node

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
            raise_syntax_error(f'unexpected end of file, expected one of: {types_string}', filename=self.filename)
        else:
            raise_syntax_error(
                f'unexpected {token.type_.name} "{token.value}", expected one of: {types_string}',
                location=token,
                filename=self.filename,
            )


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

    def skip(self, *types: TokenType) -> Optional[Token]:
        """
        Check the current token type and skip it if matches.
        """
        if self.is_type(*types):
            return next(self)
        return None


def filter_tokens(tokens: Iterable[Token]) -> Iterable[Token]:
    return (token for token in tokens if token.type_ != TokenType.COMMENT)


def raise_syntax_error(message: str, location: Optional[Location] = None, filename: str = None) -> NoReturn:
    """
    Raise syntax error and provide some help message.
    """
    if filename:
        message = f'{filename}: {message}'
    message = f'syntax error: {message}'
    if location:
        raise ASSyntaxError(f'{message} at line {location.line_number} position {location.position}')
    else:
        raise ASSyntaxError(f'{message}')
