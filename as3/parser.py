from __future__ import annotations

import ast
from typing import Iterable, NoReturn, Optional

from more_itertools import peekable

from as3.exceptions import ASSyntaxError
from as3.scanner import Token, TokenType


class Parser:
    def __init__(self, tokens: Iterable[Token]):
        self.tokens = peekable(tokens)

    def parse_script(self) -> ast.AST:
        """
        Parse *.as script.
        """
        # TODO: multiple classes: https://stackoverflow.com/a/15389018/359730
        self.expect_and_skip(TokenType.PACKAGE)
        self.parse_package_name()
        self.expect_and_skip(TokenType.CURLY_BRACKET_OPEN)
        ...
        return ast.Module(body=[])

    def parse_package_name(self):
        self.expect_and_skip(TokenType.IDENTIFIER)
        while self.is_peeked_type_in(TokenType.DOT):
            self.tokens.next()
            self.expect_and_skip(TokenType.IDENTIFIER)

    def parse_expression(self) -> ast.AST:
        node = self.parse_term()
        while self.is_peeked_type_in(TokenType.PLUS, TokenType.MINUS):
            token: Token = self.tokens.next()
            node = ast.BinOp(left=node, op=token_type_to_operation[token.type_], right=self.parse_term())
        return node

    def parse_term(self) -> ast.AST:
        node = self.parse_factor()
        while self.is_peeked_type_in(TokenType.STAR, TokenType.DIVIDE):
            token: Token = self.tokens.next()
            node = ast.BinOp(left=node, op=token_type_to_operation[token.type_], right=self.parse_term())
        return node

    def parse_factor(self) -> ast.AST:
        self.raise_if_not_types(
            TokenType.PARENTHESIS_OPEN,
            TokenType.PARENTHESIS_CLOSE,
            TokenType.INTEGER,
        )
        if self.is_peeked_type_in(TokenType.PARENTHESIS_OPEN, TokenType.PARENTHESIS_CLOSE):
            return self.parse_expression()
        if self.is_peeked_type_in(TokenType.INTEGER):
            token: Token = self.tokens.next()
            return ast.Num(token.value)

    def expect_and_skip(self, *types: TokenType):
        """
        Check current token type and skip it.
        """
        self.raise_if_not_types(*types)
        self.tokens.next()

    def is_peeked_type_in(self, *types: TokenType) -> bool:
        """
        Check current token type.
        """
        return self.tokens and self.tokens.peek().type_ in types

    def raise_if_not_types(self, *types: TokenType):
        """
        Check current token type and raise if unexpected.
        """
        if not self.tokens:
            self.raise_syntax_error(f'unexpected end of file, expected one of: {self.types_string(*types)}')
        if not self.is_peeked_type_in(*types):
            token: Token = self.tokens.peek()
            self.raise_syntax_error(f'unexpected {token.type_}, expected one of: {self.types_string(*types)}', token)

    @staticmethod
    def raise_syntax_error(message: str, token: Optional[Token] = None) -> NoReturn:
        """
        Raise syntax error with some helper message.
        """
        if token:
            raise ASSyntaxError(f'syntax error: {message} at line {token.line_number} position {token.position}')
        else:
            raise ASSyntaxError(f'syntax error: {message}')

    @staticmethod
    def types_string(*types: TokenType) -> str:
        return ', '.join(_.name for _ in types)


token_type_to_operation = {
    TokenType.PLUS: ast.Add(),
    TokenType.MINUS: ast.Sub(),
    TokenType.DIVIDE: ast.Div(),
    TokenType.STAR: ast.Mult(),
}
