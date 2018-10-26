from __future__ import annotations

from collections import deque
from typing import Any, Callable, Deque, Dict, Iterable, Iterator, List, NoReturn, Optional, Set, Tuple

from as3 import ast_, interpreter
from as3.enums import TokenType
from as3.exceptions import ASSyntaxError
from as3.runtime import undefined
from as3.scanner import Token


class Parser:
    def __init__(self, tokens: Iterable[Token], filename: str) -> None:
        self.tokens = Peekable(filter_tokens(tokens))
        self.filename = filename

    # Rules.
    # ------------------------------------------------------------------------------------------------------------------

    def parse_script(self) -> ast_.Block:
        """
        Parse *.as script.
        """
        body: List[ast_.AST] = []
        while self.tokens:
            # FIXME: allow package at any level.
            body.append(self.switch({TokenType.PACKAGE: self.parse_package}, else_=self.parse_statement))
        return ast_.Block(body=body)

    def parse_package(self) -> ast_.AST:
        self.expect(TokenType.PACKAGE)
        if self.tokens.is_type(TokenType.IDENTIFIER):
            # TODO: for now just consume the name because we'll use the directory structure instead.
            for _ in self.parse_qualified_name():
                pass
        return self.parse_statement_or_code_block()

    def parse_class(self) -> ast_.Class:
        # Definition.
        self.parse_modifiers()
        # noinspection PyArgumentList
        node = ast_.Class(token=self.expect(TokenType.CLASS, TokenType.INTERFACE))  # treat interface as a class with empty methods
        node.name = self.expect(TokenType.IDENTIFIER).value
        if self.tokens.skip(TokenType.EXTENDS):
            node.base = self.parse_primary_expression()
        if self.tokens.skip(TokenType.IMPLEMENTS):
            # Skip interfaces.
            self.parse_primary_expression()

        # Body.
        self.expect(TokenType.CURLY_BRACKET_OPEN)
        while not self.tokens.skip(TokenType.CURLY_BRACKET_CLOSE):
            # Parse definition.
            modifiers = self.parse_modifiers()
            statement: ast_.AST = self.switch({
                TokenType.CONST: self.parse_variable_definition,
                TokenType.FUNCTION: self.parse_function_definition,
                TokenType.VAR: self.parse_variable_definition,
            })
            if isinstance(statement, ast_.Function) and statement.name == node.name:
                node.constructor = statement

            # Skip all semicolons.
            while self.tokens.skip(TokenType.SEMICOLON):
                pass

        return node

    def parse_modifiers(self) -> Set[TokenType]:
        modifiers: Set[TokenType] = set()
        if self.tokens.skip(TokenType.OVERRIDE):
            modifiers.add(TokenType.OVERRIDE)
        visibility_token = self.tokens.skip(
            TokenType.PUBLIC, TokenType.PRIVATE, TokenType.PROTECTED, TokenType.INTERNAL)
        if visibility_token:
            modifiers.add(visibility_token.type_)
        if self.tokens.skip(TokenType.STATIC):
            modifiers.add(TokenType.STATIC)
        return modifiers

    def parse_statement_or_code_block(self) -> ast_.AST:
        return self.switch({TokenType.CURLY_BRACKET_OPEN: self.parse_code_block}, else_=self.parse_statement)

    def parse_statement(self) -> ast_.AST:
        node = self.switch({
            TokenType.BREAK: self.parse_break,
            TokenType.CLASS: self.parse_class,
            TokenType.FOR: self.parse_for,
            TokenType.FUNCTION: self.parse_function_definition,
            TokenType.IF: self.parse_if,
            TokenType.IMPORT: self.parse_import,
            TokenType.PRIVATE: self.parse_class,
            TokenType.PROTECTED: self.parse_class,
            TokenType.PUBLIC: self.parse_class,
            TokenType.RETURN: self.parse_return,
            TokenType.SEMICOLON: self.parse_semicolon,
            TokenType.STATIC: self.parse_class,
            TokenType.THROW: self.parse_throw,
            TokenType.TRY: self.parse_try,
            TokenType.VAR: self.parse_variable_definition,
            TokenType.WHILE: self.parse_while,
        }, else_=self.parse_expression_statement)

        # Skip all semicolons.
        while self.tokens.skip(TokenType.SEMICOLON):
            pass

        return node

    def parse_code_block(self) -> ast_.Block:
        # noinspection PyArgumentList
        node = ast_.Block(token=self.expect(TokenType.CURLY_BRACKET_OPEN))
        while not self.tokens.skip(TokenType.CURLY_BRACKET_CLOSE):
            node.body.append(self.parse_statement_or_code_block())
        return node

    def parse_expression_statement(self) -> ast_.AST:
        node = self.parse_expression()
        self.tokens.skip(TokenType.SEMICOLON)
        return node

    def parse_qualified_name(self) -> Iterable[str]:
        """
        Parse qualified name and return its parts.
        """
        yield self.expect(TokenType.IDENTIFIER).value
        while self.tokens.skip(TokenType.DOT):
            yield self.expect(TokenType.IDENTIFIER).value

    def parse_import(self) -> Iterable[ast_.AST]:
        import_token = self.expect(TokenType.IMPORT)
        args = []
        while True:
            token = self.expect(TokenType.IDENTIFIER, TokenType.MULTIPLY)
            args.append(AST.string(token, token.value).node)
            if not self.tokens.skip(TokenType.DOT):
                break
        self.tokens.skip(TokenType.SEMICOLON)
        return AST \
            .name(import_token, constants.import_key) \
            .call(import_token, args) \
            .expr() \
            .node

    def parse_if(self) -> ast_.If:
        # noinspection PyArgumentList
        node = ast_.If(token=self.expect(TokenType.IF))
        self.expect(TokenType.PARENTHESIS_OPEN)
        node.test = self.parse_assignment_expression()
        self.expect(TokenType.PARENTHESIS_CLOSE)
        node.positive = self.parse_statement_or_code_block()
        node.negative = self.parse_statement_or_code_block() if self.tokens.skip(TokenType.ELSE) else None
        return node

    def parse_variable_definition(self) -> ast_.Variable:
        token = self.expect(TokenType.VAR, TokenType.CONST)
        name_token = self.expect(TokenType.IDENTIFIER)
        value = ast_.Literal(value=self.parse_type_annotation())
        if self.tokens.skip(TokenType.ASSIGN):
            value = self.parse_assignment_expression()
        # noinspection PyArgumentList
        return ast_.Variable(token=token, name=name_token.value, value=value)

    def parse_type_annotation(self) -> Any:
        """
        Parse type annotation and return its _default value_.
        https://www.adobe.com/devnet/actionscript/learning/as3-fundamentals/data-types.html
        """
        if self.tokens.skip(TokenType.COLON):
            return self.parse_type()
        return undefined

    def parse_type(self) -> Any:
        if self.tokens.skip(TokenType.MULTIPLY):
            return undefined
        if self.tokens.skip(TokenType.VOID):
            return None

        # Standard types.
        identifier_token = self.expect(TokenType.IDENTIFIER)
        if identifier_token.value == 'Boolean':
            return False
        if identifier_token.value in ('int', 'uint', 'Number'):
            return 0

        # `None` for other standard types and all user classes. Skip the rest of the annotation.
        while True:
            if not self.tokens.skip(TokenType.DOT):
                break
            if not self.tokens.skip(TokenType.IDENTIFIER):
                self.expect(TokenType.LESS)
                self.parse_type()
                self.expect(TokenType.GREATER)
        return ast_.Literal(value=None)

    def parse_semicolon(self) -> ast_.Pass:
        # noinspection PyArgumentList
        return ast_.Pass(token=self.expect(TokenType.SEMICOLON))

    def parse_return(self) -> ast_.Return:
        # noinspection PyArgumentList
        node = ast_.Return(token=self.expect(TokenType.RETURN))
        if not self.tokens.skip(TokenType.SEMICOLON):
            node.value = self.parse_assignment_expression()
        return node

    def parse_function_definition(self) -> ast_.Function:
        # noinspection PyArgumentList
        node = ast_.Function(token=self.expect(TokenType.FUNCTION))
        is_property = self.tokens.skip(TokenType.GET) is not None  # TODO
        node.name = self.expect(TokenType.IDENTIFIER).value

        self.expect(TokenType.PARENTHESIS_OPEN)
        while not self.tokens.skip(TokenType.PARENTHESIS_CLOSE):
            node.parameter_names.append(self.expect(TokenType.IDENTIFIER).value)
            default_value = ast_.Literal(value=self.parse_type_annotation())
            if self.tokens.skip(TokenType.ASSIGN):
                default_value = self.parse_assignment_expression()
            node.defaults.append(default_value)
            self.tokens.skip(TokenType.COMMA)

        node.default_return_value = self.parse_type_annotation()
        node.body = self.parse_statement_or_code_block()
        return node

    def parse_break(self) -> ast_.Break:
        # noinspection PyArgumentList
        return ast_.Break(token=self.expect(TokenType.BREAK))

    def parse_while(self) -> ast_.While:
        token = self.expect(TokenType.WHILE)
        self.expect(TokenType.PARENTHESIS_OPEN)
        test = self.parse_assignment_expression()
        self.expect(TokenType.PARENTHESIS_CLOSE)
        body = self.parse_statement_or_code_block()
        # noinspection PyArgumentList
        return ast_.While(token=token, test=test, body=body)

    def parse_try(self) -> ast_.TryFinally:
        # noinspection PyArgumentList
        node = ast_.TryFinally(token=self.expect(TokenType.TRY))
        node.body = self.parse_statement_or_code_block()
        while self.tokens.is_type(TokenType.CATCH):
            # noinspection PyArgumentList
            except_node = ast_.Except(token=next(self.tokens))
            self.expect(TokenType.PARENTHESIS_OPEN)
            except_node.variable_name = self.expect(TokenType.IDENTIFIER).value
            self.expect(TokenType.COLON)
            if not self.tokens.is_type(TokenType.MULTIPLY):
                except_node.exception_type = self.parse_assignment_expression()
            self.expect(TokenType.PARENTHESIS_CLOSE)
            except_node.body = self.parse_statement_or_code_block()
            node.excepts.append(except_node)
        if self.tokens.skip(TokenType.FINALLY):
            node.finally_ = self.parse_statement_or_code_block()
        return node

    def parse_throw(self) -> ast_.Throw:
        token = self.expect(TokenType.THROW)
        value = self.parse_assignment_expression()
        # noinspection PyArgumentList
        return ast_.Throw(token=token, value=value)

    def parse_for(self) -> ast_.AbstractFor:
        token = self.expect(TokenType.FOR)
        ast_class = ast_.ForEach if self.tokens.skip(TokenType.EACH) else ast_.For
        self.expect(TokenType.PARENTHESIS_OPEN)
        self.expect(TokenType.VAR)
        variable_name = self.expect(TokenType.IDENTIFIER).value
        self.expect(TokenType.IN)
        value = self.parse_assignment_expression()
        self.expect(TokenType.PARENTHESIS_CLOSE)
        body = self.parse_statement_or_code_block()
        return ast_class(token=token, variable_name=variable_name, value=value, body=body)

    # Expression rules.
    # Methods are ordered according to reversed precedence.
    # https://www.adobe.com/devnet/actionscript/learning/as3-fundamentals/operators.html#articlecontentAdobe_numberedheader_1
    # ------------------------------------------------------------------------------------------------------------------

    def parse_expression(self) -> ast_.AST:
        return self.parse_label()

    def parse_label(self) -> ast_.AST:
        # For the sake of simplicity any expression is allowed as a label.
        # Again, for the sake of simplicity any label is translated to `null`.
        left = self.parse_assignment_expression()
        if self.tokens.is_type(TokenType.COLON):
            # noinspection PyArgumentList
            return ast_.Literal(token=next(self.tokens), value=None)
        return left

    def parse_assignment_expression(self) -> ast_.AST:
        return self.parse_binary_operations(
            self.parse_conditional_expression,
            TokenType.ASSIGN,
            TokenType.ASSIGN_ADD,
        )

    # def parse_non_assignment_expression(self) -> ast.AST:
    #     return self.parse_conditional_expression()

    def parse_conditional_expression(self) -> ast_.AST:
        node = self.parse_logical_or_expression()
        if self.tokens.is_type(TokenType.QUESTION_MARK):
            token = next(self.tokens)
            positive = self.parse_conditional_expression()
            self.expect(TokenType.COLON)
            negative = self.parse_conditional_expression()
            # noinspection PyArgumentList
            node = ast_.If(token=token, test=node, positive=positive, negative=negative)
        return node

    def parse_logical_or_expression(self) -> ast_.AST:
        return self.parse_binary_operations(self.parse_logical_and_expression, TokenType.LOGICAL_OR)

    def parse_logical_and_expression(self) -> ast_.AST:
        return self.parse_binary_operations(self.parse_bitwise_xor, TokenType.LOGICAL_AND)

    def parse_bitwise_xor(self) -> ast_.AST:
        return self.parse_binary_operations(self.parse_equality_expression, TokenType.BITWISE_XOR)

    def parse_equality_expression(self) -> ast_.AST:
        return self.parse_binary_operations(
            self.parse_relational_expression,
            TokenType.EQUALS,
            TokenType.NOT_EQUALS,
        )

    def parse_relational_expression(self) -> ast_.AST:
        return self.parse_binary_operations(
            self.parse_additive_expression,
            TokenType.AS,
            TokenType.GREATER,
            TokenType.GREATER_OR_EQUAL,
            TokenType.IN,
            TokenType.IS,
            TokenType.LESS,
            TokenType.LESS_OR_EQUAL,
        )

    def parse_additive_expression(self) -> ast_.AST:
        return self.parse_binary_operations(self.parse_multiplicative_expression, TokenType.PLUS, TokenType.MINUS)

    def parse_multiplicative_expression(self) -> ast_.AST:
        return self.parse_binary_operations(
            self.parse_unary_expression,
            TokenType.MULTIPLY, TokenType.DIVIDE, TokenType.PERCENT,
        )

    def parse_unary_expression(self) -> ast_.AST:
        if self.tokens.is_type(*interpreter.unary_operations):
            token = next(self.tokens)
            # noinspection PyArgumentList
            return ast_.UnaryOperation(token=token, value=self.parse_unary_expression())
        return self.parse_postfix()

    def parse_postfix(self) -> ast_.AST:
        left = self.parse_primary_expression()
        while self.tokens.is_type(*interpreter.postfix_operations):
            # noinspection PyArgumentList
            left = ast_.PostfixOperation(token=next(self.tokens), value=left)
        return left

    def parse_primary_expression(self) -> ast_.AST:
        if self.tokens.is_type(TokenType.NEW):
            return self.parse_new()
        left = self.parse_terminal_or_parenthesized()
        cases = {
            TokenType.BRACKET_OPEN: self.parse_subscript,
            TokenType.DOT: self.parse_attribute_expression,
            TokenType.PARENTHESIS_OPEN: self.parse_call_expression,
        }
        while self.tokens.is_type(*cases):
            left = self.switch(cases, left=left)
        return left

    def parse_attribute_expression(self, left: ast_.AST) -> ast_.AST:
        token = self.expect(TokenType.DOT)
        name: str = self.expect(TokenType.IDENTIFIER).value
        # noinspection PyArgumentList
        return ast_.Property(token=token, value=left, item=ast_.Literal(value=name))

    def parse_call_expression(self, left: ast_.AST) -> ast_.AST:
        # noinspection PyArgumentList
        node = ast_.Call(token=self.expect(TokenType.PARENTHESIS_OPEN), value=left)
        while not self.tokens.skip(TokenType.PARENTHESIS_CLOSE):
            node.arguments.append(self.parse_assignment_expression())
            self.tokens.skip(TokenType.COMMA)
        return node

    def parse_subscript(self, left: ast_.AST) -> ast_.AST:
        token = self.expect(TokenType.BRACKET_OPEN)
        item = self.parse_assignment_expression()
        self.expect(TokenType.BRACKET_CLOSE)
        # noinspection PyArgumentList
        return ast_.Property(token=token, value=left, item=item)

    def parse_terminal_or_parenthesized(self) -> ast_.AST:
        # noinspection PyArgumentList
        return self.switch({
            TokenType.BRACKET_OPEN: self.parse_compound_literal,
            TokenType.CURLY_BRACKET_OPEN: self.parse_map_literal,
            TokenType.FALSE: lambda: ast_.Literal(token=next(self.tokens), value=False),
            TokenType.IDENTIFIER: lambda: ast_.Name.from_(next(self.tokens)),
            TokenType.NULL: lambda: ast_.Literal(token=next(self.tokens), value=None),
            TokenType.NUMBER: lambda: ast_.Literal.from_(next(self.tokens)),
            TokenType.PARENTHESIS_OPEN: self.parse_parenthesized_expression,
            TokenType.STRING: lambda: ast_.Literal.from_(next(self.tokens)),
            TokenType.SUPER: self.parse_super_expression,
            TokenType.THIS: lambda: ast_.Name.from_(next(self.tokens)),
            TokenType.TRUE: lambda: ast_.Literal(token=next(self.tokens), value=True),
            TokenType.UNDEFINED: lambda: ast_.Literal(token=next(self.tokens), value=undefined),
        })

    def parse_parenthesized_expression(self) -> ast_.AST:
        self.expect(TokenType.PARENTHESIS_OPEN)
        inner = self.parse_assignment_expression()
        self.expect(TokenType.PARENTHESIS_CLOSE)
        return inner

    def parse_super_expression(self) -> ast_.AST:
        super_token = self.expect(TokenType.SUPER)
        builder = AST.identifier(super_token).call(super_token)
        if self.tokens.is_type(TokenType.PARENTHESIS_OPEN):
            # Call super constructor. Return `super().__init__` and let `parse_call_expression` do its job.
            return self.parse_call_expression(builder.attribute(super_token, constants.init_name).node)
        if self.tokens.is_type(TokenType.DOT):
            # Call super method. Return `super()` and let `parse_attribute_expression` do its job.
            return self.parse_attribute_expression(builder.node)
        self.raise_syntax_error(TokenType.PARENTHESIS_OPEN, TokenType.DOT)

    def parse_new(self) -> ast_.AST:
        # noinspection PyArgumentList
        node = ast_.New(token=self.expect(TokenType.NEW))

        # Skip generic parameter before literal.
        if self.tokens.skip(TokenType.LESS):
            self.parse_type()
            self.expect(TokenType.GREATER)
            return self.parse_terminal_or_parenthesized()

        # Actual constructor.
        node.value = self.parse_terminal_or_parenthesized()

        # Skip yet another generic parameter.
        if self.tokens.skip(TokenType.DOT):
            self.expect(TokenType.LESS)
            self.parse_type()
            self.expect(TokenType.GREATER)

        # Parse the call.
        self.expect(TokenType.PARENTHESIS_OPEN)
        while not self.tokens.skip(TokenType.PARENTHESIS_CLOSE):
            node.arguments.append(self.parse_assignment_expression())
            self.tokens.skip(TokenType.COMMA)

        return node

    def parse_compound_literal(self) -> ast_.AST:
        token = self.expect(TokenType.BRACKET_OPEN)
        value: List[ast_.AST] = []
        while not self.tokens.skip(TokenType.BRACKET_CLOSE):
            value.append(self.parse_assignment_expression())
            self.tokens.skip(TokenType.COMMA)
        # noinspection PyArgumentList
        return ast_.CompoundLiteral(token=token, value=value)

    def parse_map_literal(self) -> ast_.AST:
        token = self.expect(TokenType.CURLY_BRACKET_OPEN)
        map_value: List[Tuple[ast_.AST, ast_.AST]] = []
        while not self.tokens.skip(TokenType.CURLY_BRACKET_CLOSE):
            key = self.parse_assignment_expression()
            self.expect(TokenType.COLON)
            value = self.parse_assignment_expression()
            map_value.append((key, value))
            self.tokens.skip(TokenType.COMMA)
        # noinspection PyArgumentList
        return ast_.MapLiteral(token=token, value=map_value)

    # Expression rule helpers.
    # ------------------------------------------------------------------------------------------------------------------

    def parse_binary_operations(self, child_parser: Callable[[], ast_.AST], *types: TokenType) -> ast_.AST:
        node = child_parser()
        while self.tokens.is_type(*types):
            token = next(self.tokens)
            # noinspection PyArgumentList
            node = ast_.BinaryOperation(token=token, left=node, right=child_parser())
        return node

    # Parser helpers.
    # ------------------------------------------------------------------------------------------------------------------

    TParser = Callable[..., ast_.AST]

    def switch(self, cases: Dict[TokenType, TParser], else_: Optional[TParser] = None, **kwargs) -> ast_.AST:
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


def raise_syntax_error(message: str, location: Optional[Token] = None, filename: str = None) -> NoReturn:
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
