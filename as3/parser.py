from __future__ import annotations

import ast
from ast import AST
from typing import Callable, Dict, Iterable, NoReturn, Optional

from more_itertools import consume, peekable

from as3.exceptions import ASSyntaxError
from as3.scanner import Token, TokenType


class Parser:
    def __init__(self, tokens: Iterable[Token]):
        self.tokens = peekable(tokens)

    # Rules.
    # ------------------------------------------------------------------------------------------------------------------

    def parse_script(self) -> AST:
        """
        Parse *.as script.
        """
        while self.tokens.peek():
            self.parse_statement()

    def parse_package(self) -> AST:
        self.expect(TokenType.PACKAGE)
        package_name = tuple(self.parse_qualified_name())
        self.parse_code_block()

    def parse_class(self) -> AST:
        self.expect(TokenType.CLASS)
        class_name = self.expect(TokenType.IDENTIFIER).value
        if self.skip(TokenType.EXTENDS):
            extends_name = tuple(self.parse_qualified_name())
        self.parse_code_block()

    def parse_function(self) -> AST:
        self.expect(TokenType.FUNCTION)
        name = self.expect(TokenType.IDENTIFIER).value
        self.expect(TokenType.PARENTHESIS_OPEN)
        while not self.skip(TokenType.PARENTHESIS_CLOSE):
            self.parse_parameter_definition()
            self.skip(TokenType.COMMA)
        self.parse_code_block()

    def parse_parameter_definition(self) -> AST:
        parameter_name = self.expect(TokenType.IDENTIFIER).value
        self.expect(TokenType.COLON)
        type_name = tuple(self.parse_qualified_name())
        if self.skip(TokenType.ASSIGN):
            default_value = self.parse_expression()

    def parse_code_block(self) -> AST:
        self.expect(TokenType.CURLY_BRACKET_OPEN)
        while not self.skip(TokenType.CURLY_BRACKET_CLOSE):
            self.parse_statement()

    def parse_statement(self) -> AST:
        consume(self.parse_modifiers())  # FIXME
        return self.case({
            TokenType.PACKAGE: self.parse_package,
            TokenType.IMPORT: self.parse_import,
            TokenType.CLASS: self.parse_class,
            TokenType.FUNCTION: self.parse_function,
            TokenType.VAR: self.parse_variable,
            TokenType.IF: self.parse_if,
            TokenType.SEMICOLON: self.parse_semicolon,
            TokenType.RETURN: self.parse_return,
        }, else_=self.parse_expression_statement)

    def parse_expression_statement(self) -> AST:
        self.parse_expression()
        self.expect(TokenType.SEMICOLON)

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
        while self.is_type(TokenType.STATIC, TokenType.PUBLIC):
            yield self.tokens.next().type_

    def parse_import(self) -> AST:
        self.expect(TokenType.IMPORT)
        qualified_name = tuple(self.parse_qualified_name())
        self.expect(TokenType.SEMICOLON)

    def parse_if(self) -> AST:
        self.expect(TokenType.IF)
        self.expect(TokenType.PARENTHESIS_OPEN)
        self.parse_expression()
        self.expect(TokenType.PARENTHESIS_CLOSE)
        if self.is_type(TokenType.CURLY_BRACKET_OPEN):
            self.parse_code_block()
        else:
            self.parse_statement()

    def parse_variable(self) -> AST:
        raise NotImplementedError(TokenType.VAR)

    def parse_semicolon(self) -> AST:
        token = self.expect(TokenType.SEMICOLON)
        return ast.Pass(**token.ast_args)

    def parse_return(self) -> AST:
        token = self.expect(TokenType.RETURN)
        if not self.skip(TokenType.SEMICOLON):
            value = self.parse_expression()
        else:
            value = None
        return ast.Return(value=value, **token.ast_args)

    # Expression rules.
    # Methods are ordered according to reversed precedence.
    # https://www.adobe.com/devnet/actionscript/learning/as3-fundamentals/operators.html#articlecontentAdobe_numberedheader_1
    # ------------------------------------------------------------------------------------------------------------------

    def parse_expression(self) -> AST:
        return self.parse_additive()

    def parse_additive(self) -> AST:
        return self.parse_binary_operation(self.parse_multiplicative, TokenType.PLUS, TokenType.MINUS)

    def parse_multiplicative(self) -> AST:
        return self.parse_binary_operation(self.parse_unary, TokenType.STAR, TokenType.SLASH)

    def parse_unary(self) -> AST:
        if self.is_type(*unary_operations):
            token: Token = self.tokens.next()
            return ast.UnaryOp(op=unary_operations[token.type_], operand=self.parse_unary(), **token.ast_args)
        return self.parse_primary()

    def parse_primary(self) -> AST:
        left = self.parse_terminal_or_parenthesized()
        return self.case({
            TokenType.DOT: self.parse_attribute,
            TokenType.PARENTHESIS_OPEN: self.parse_call,
        }, left=left, default=left)

    def parse_attribute(self, left: AST) -> AST:
        token = self.expect(TokenType.DOT)
        return ast.Attribute(value=left, attr=self.expect(TokenType.IDENTIFIER).value, ctx=ast.Load(), **token.ast_args)

    def parse_call(self, left: AST) -> AST:
        token = self.expect(TokenType.PARENTHESIS_OPEN)
        args = []
        while not self.skip(TokenType.PARENTHESIS_CLOSE):
            args.append(self.parse_expression())  # FIXME: expression may capture all comma's
            self.skip(TokenType.COMMA)
        self.expect(TokenType.SEMICOLON)
        return ast.Call(func=left, args=args, keywords=[], **token.ast_args)

    def parse_terminal_or_parenthesized(self) -> AST:
        return self.case({
            TokenType.PARENTHESIS_OPEN: self.parse_parenthesized,
            TokenType.INTEGER: self.parse_integer,
            TokenType.IDENTIFIER: self.parse_name,
        })

    def parse_parenthesized(self) -> AST:
        self.expect(TokenType.PARENTHESIS_OPEN)
        node = self.parse_expression()
        self.expect(TokenType.PARENTHESIS_CLOSE)
        return node

    def parse_integer(self) -> AST:
        token = self.expect(TokenType.INTEGER)
        return ast.Num(n=token.value, **token.ast_args)

    def parse_name(self) -> AST:
        token = self.expect(TokenType.IDENTIFIER)
        return ast.Name(id=token.value, ctx=ast.Load(), **token.ast_args)

    # Expression rule helpers.
    # ------------------------------------------------------------------------------------------------------------------

    def parse_binary_operation(self, child_parser: Callable[[], AST], *types: TokenType) -> AST:
        left = child_parser()
        while self.is_type(*types):
            token: Token = self.tokens.next()
            left = ast.BinOp(left=left, op=binary_operations[token.type_], right=child_parser(), **token.ast_args)
        return left

    # Parser helpers.
    # ------------------------------------------------------------------------------------------------------------------

    TParser = Callable[..., AST]

    def case(self, parsers: Dict[TokenType, TParser], else_: TParser = None, default: AST = None, **kwargs) -> AST:
        """
        Behaves like a `switch` (`case`) operator and tries to match against different token types.
        If match is found, then the corresponding parser is called.
        Otherwise, `else_` is called or `default` value is returned.
        Otherwise, syntax error is raised.
        """
        assert else_ is None or default is None, 'else_ cannot be used together with default'
        try:
            parser = parsers[self.tokens.peek().type_]
        except (StopIteration, KeyError):
            if default:
                return default
            if else_:
                return else_(**kwargs)
            self.raise_expected_error(*parsers.keys())
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
            self.raise_syntax_error(f'unexpected end of file, expected one of: {types_string}')
        token: Token = self.tokens.peek()
        self.raise_syntax_error(f'unexpected {token.type_.name} "{token.value}", expected one of: {types_string}', token)

    @staticmethod
    def raise_syntax_error(message: str, token: Optional[Token] = None) -> NoReturn:
        """
        Raise syntax error and provide some help message.
        """
        if token:
            raise ASSyntaxError(f'syntax error: {message} at line {token.line_number} position {token.position}')
        else:
            raise ASSyntaxError(f'syntax error: {message}')


unary_operations: Dict[TokenType, AST] = {
    TokenType.PLUS: ast.UAdd(),
    TokenType.MINUS: ast.USub(),
}

binary_operations: Dict[TokenType, AST] = {
    TokenType.MINUS: ast.Sub(),
    TokenType.PLUS: ast.Add(),
    TokenType.SLASH: ast.Div(),
    TokenType.STAR: ast.Mult(),
}
