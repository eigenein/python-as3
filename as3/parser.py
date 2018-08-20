from __future__ import annotations

import ast
from typing import Iterable, NoReturn

from more_itertools import peekable, take

from as3.exceptions import ASSyntaxError
from as3.scanner import Token, TokenType


class Parser:
    def __init__(self, tokens: Iterable[Token]):
        self.tokens = peekable(tokens)

    def parse(self) -> ast.AST:
        ...

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

    def to_ast(self, token: Token) -> ast.AST:
        ...

    def is_peeked_type_in(self, *types: TokenType) -> bool:
        return self.tokens and self.tokens.peek().type_ in types

    def raise_if_not_types(self, *types: TokenType):
        if not self.tokens:
            self.raise_syntax_error(f'unexpected end of file, expected: {types}')
        if not self.is_peeked_type_in(*types):
            self.raise_syntax_error(f'unexpected {self.tokens.peek().type_}, expected: {types}')

    def raise_syntax_error(self, message: str) -> NoReturn:
        raise ASSyntaxError(f'syntax error: {message} near: "{"".join(take(5, self.tokens))}"')


token_type_to_operation = {
    TokenType.PLUS: ast.Add(),
    TokenType.MINUS: ast.Sub(),
    TokenType.DIVIDE: ast.Div(),
    TokenType.STAR: ast.Mult(),
}
