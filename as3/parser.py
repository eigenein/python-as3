from __future__ import annotations

import ast
from typing import Iterable, NoReturn, Optional, Dict

from more_itertools import peekable

from as3.exceptions import ASSyntaxError
from as3.scanner import Token, TokenType


# See also: https://www.adobe.com/devnet/actionscript/learning/as3-fundamentals/operators.html#articlecontentAdobe_numberedheader_1

class Parser:
    def __init__(self, tokens: Iterable[Token]):
        self.tokens = peekable(tokens)

    # Rules.
    # ------------------------------------------------------------------------------------------------------------------

    def parse_script(self) -> ast.AST:
        """
        Parse *.as script.
        """
        if self.is_type_in(TokenType.PACKAGE):
            self.parse_package()
            return ast.Module(body=[])
        self.raise_expected_error(TokenType.PACKAGE)  # may also be a variable, a function or a namespace

    def parse_package(self):
        self.skip(TokenType.PACKAGE)
        package_name = tuple(self.parse_package_name())
        self.skip(TokenType.CURLY_BRACKET_OPEN)
        self.parse_package_body()
        # TODO: self.skip(TokenType.CURLY_BRACKET_CLOSE)

    def parse_package_name(self) -> Iterable[str]:
        """
        Parse package name and return its parts.
        """
        self.skip(TokenType.IDENTIFIER)
        while self.skip_if_type_in(TokenType.DOT):
            yield self.skip(TokenType.IDENTIFIER).value

    def parse_package_body(self):
        if self.is_type_in(TokenType.STATIC, TokenType.PUBLIC):
            modifiers = tuple(self.parse_modifiers())
        elif self.is_type_in(TokenType.IMPORT):
            ...
        else:
            self.raise_expected_error(TokenType.STATIC, TokenType.PUBLIC, TokenType.IMPORT)

    def parse_modifiers(self) -> Iterable[TokenType]:
        """
        Parse modifiers like `public` and `static`.
        """
        while self.is_type_in(TokenType.STATIC, TokenType.PUBLIC):
            yield self.tokens.next().type_

    def parse_expression(self) -> ast.AST:
        return self.parse_additive()

    def parse_additive(self) -> ast.AST:
        node = self.parse_multiplicative()
        while self.is_type_in(TokenType.PLUS, TokenType.MINUS):
            token: Token = self.tokens.next()
            node = ast.BinOp(
                left=node,
                op=token_type_to_ast[token.type_],
                right=self.parse_multiplicative(),
                lineno=token.line_number,
                col_offset=token.position,
            )
        return node

    def parse_multiplicative(self) -> ast.AST:
        node = self.parse_literal_or_parenthesized()
        while self.is_type_in(TokenType.STAR, TokenType.SLASH):
            token: Token = self.tokens.next()
            node = ast.BinOp(
                left=node,
                op=token_type_to_ast[token.type_],
                right=self.parse_literal_or_parenthesized(),
                lineno=token.line_number,
                col_offset=token.position,
            )
        return node

    def parse_literal_or_parenthesized(self) -> ast.AST:
        if self.is_type_in(TokenType.PARENTHESIS_OPEN, TokenType.PARENTHESIS_CLOSE):
            self.skip(TokenType.PARENTHESIS_OPEN)
            node = self.parse_expression()
            self.skip(TokenType.PARENTHESIS_CLOSE)
            return node
        if self.is_type_in(TokenType.INTEGER):
            token: Token = self.tokens.next()
            return ast.Num(token.value, lineno=token.line_number, col_offset=token.position)
        self.raise_expected_error(TokenType.PARENTHESIS_OPEN, TokenType.PARENTHESIS_CLOSE, TokenType.INTEGER)

    # Parser helpers.
    # ------------------------------------------------------------------------------------------------------------------

    def skip(self, *types: TokenType) -> Token:
        """
        Check the current token type, skip and return it.
        Raise syntax error if the current token has an unexpected type.
        """
        if self.is_type_in(*types):
            return self.tokens.next()
        self.raise_expected_error(*types)

    def is_type_in(self, *types: TokenType) -> bool:
        """
        Check the current token type.
        """
        return self.tokens and self.tokens.peek().type_ in types

    def skip_if_type_in(self, *types: TokenType) -> bool:
        """
        Check the current token type and skip it if matches.
        """
        if self.is_type_in(*types):
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
        self.raise_syntax_error(f'unexpected {token.type_}, expected one of: {types_string}', token)

    @staticmethod
    def raise_syntax_error(message: str, token: Optional[Token] = None) -> NoReturn:
        """
        Raise syntax error and provide some help message.
        """
        if token:
            raise ASSyntaxError(f'syntax error: {message} at line {token.line_number} position {token.position}')
        else:
            raise ASSyntaxError(f'syntax error: {message}')


token_type_to_ast: Dict[TokenType, ast.AST] = {
    TokenType.MINUS: ast.Sub(),
    TokenType.PLUS: ast.Add(),
    TokenType.SLASH: ast.Div(),
    TokenType.STAR: ast.Mult(),
}
