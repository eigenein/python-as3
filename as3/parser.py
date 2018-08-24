from __future__ import annotations

import ast
from ast import AST
from typing import Callable, Dict, Iterable, List, NoReturn, Optional

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
        statements: List[AST] = []
        while self.tokens:
            statements.append(self.parse_statement())
        return ast.Module(body=statements)

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

    def parse_function_definition(self) -> AST:
        self.expect(TokenType.FUNCTION)
        name = self.expect(TokenType.IDENTIFIER).value
        self.expect(TokenType.PARENTHESIS_OPEN)
        while not self.skip(TokenType.PARENTHESIS_CLOSE):
            self.parse_parameter_definition()
            self.skip(TokenType.COMMA)
        if self.skip(TokenType.COLON):
            return_type_name = tuple(self.parse_qualified_name())
        self.parse_code_block()

    def parse_parameter_definition(self) -> AST:
        parameter_name = self.expect(TokenType.IDENTIFIER).value
        self.expect(TokenType.COLON)
        type_name = tuple(self.parse_qualified_name())
        if self.skip(TokenType.ASSIGN):
            default_value = self.parse_additive_expression()

    def parse_code_block(self) -> AST:
        self.expect(TokenType.CURLY_BRACKET_OPEN)
        while not self.skip(TokenType.CURLY_BRACKET_CLOSE):
            self.parse_statement()

    def parse_statement(self) -> AST:
        consume(self.parse_modifiers())  # FIXME: should only be allowed in some contexts
        return self.switch({
            TokenType.PACKAGE: self.parse_package,
            TokenType.IMPORT: self.parse_import,
            TokenType.CLASS: self.parse_class,
            TokenType.FUNCTION: self.parse_function_definition,  # FIXME: one can define anonymous function inside an expression
            TokenType.VAR: self.parse_variable_definition,
            TokenType.IF: self.parse_if,
            TokenType.SEMICOLON: self.parse_semicolon,
            TokenType.RETURN: self.parse_return,
        }, else_=self.parse_expression_statement)

    def parse_expression_statement(self) -> AST:
        value = self.parse_expression()
        self.skip(TokenType.SEMICOLON)
        if isinstance(value, (ast.Assign, ast.AugAssign)):
            # Assignment is not an expression in Python.
            return value
        return ast.Expr(value=value, lineno=value.lineno, col_offset=0)

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

    def parse_variable_definition(self) -> AST:
        raise NotImplementedError(TokenType.VAR)

    def parse_semicolon(self) -> AST:
        pass_token = self.expect(TokenType.SEMICOLON)
        return ast.Pass(**pass_token.ast_args)

    def parse_return(self) -> AST:
        return_token = self.expect(TokenType.RETURN)
        if not self.skip(TokenType.SEMICOLON):
            value = self.parse_expression()
        else:
            value = None
        return ast.Return(value=value, **return_token.ast_args)

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
        self.assign_to(left, assignment_token)
        value = self.parse_additive_expression()
        left = ast.Assign(targets=[left], value=value, **assignment_token.ast_args)
        # Then, check if it's chained.
        while self.skip(TokenType.ASSIGN):
            # Yes, it is. Read a value at the right.
            value = self.parse_additive_expression()
            # Former value becomes a target.
            self.assign_to(left.value, assignment_token)
            left.targets.append(left.value)
            # Value at the right becomes the assigned value.
            left.value = value
        return left

    def parse_augmented_assignment_expression(self, left: AST) -> AST:
        # FIXME: I didn't find a good way to implement chained augmented assignments like `a += b += a` in Python AST.
        # FIXME: So, only `a += b` is allowed. Sorry.
        assignment_token = self.expect(*augmented_assign_operations)
        self.assign_to(left, assignment_token)
        value = self.parse_additive_expression()
        return ast.AugAssign(
            target=left,
            op=augmented_assign_operations[assignment_token.type_],
            value=value,
            **assignment_token.ast_args,
        )

    def parse_additive_expression(self) -> AST:
        return self.parse_binary_operations(self.parse_multiplicative_expression, TokenType.PLUS, TokenType.MINUS)

    def parse_multiplicative_expression(self) -> AST:
        return self.parse_binary_operations(self.parse_unary_expression, TokenType.STAR, TokenType.SLASH)

    def parse_unary_expression(self) -> AST:
        if self.is_type(*unary_operations):
            operation_token: Token = self.tokens.next()
            return ast.UnaryOp(
                op=unary_operations[operation_token.type_],
                operand=self.parse_unary_expression(),
                **operation_token.ast_args,
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
        return ast.Attribute(
            value=left,
            attr=self.expect(TokenType.IDENTIFIER).value,
            ctx=ast.Load(),
            **attribute_token.ast_args,
        )

    def parse_call_expression(self, left: AST) -> AST:
        call_token = self.expect(TokenType.PARENTHESIS_OPEN)
        args: List[AST] = []
        while not self.skip(TokenType.PARENTHESIS_CLOSE):
            args.append(self.parse_assignment_expression())
            self.skip(TokenType.COMMA)
        # TODO: keywords.
        return ast.Call(func=left, args=args, keywords=[], **call_token.ast_args)

    def parse_terminal_or_parenthesized(self) -> AST:
        return self.switch({
            TokenType.PARENTHESIS_OPEN: self.parse_parenthesized_expression,
            TokenType.INTEGER: self.parse_integer_expression,
            TokenType.IDENTIFIER: self.parse_name_expression,
        })

    def parse_parenthesized_expression(self) -> AST:
        self.expect(TokenType.PARENTHESIS_OPEN)
        inner = self.parse_expression()
        self.expect(TokenType.PARENTHESIS_CLOSE)
        return inner

    def parse_integer_expression(self) -> AST:
        value_token = self.expect(TokenType.INTEGER)
        return ast.Num(n=value_token.value, **value_token.ast_args)

    def parse_name_expression(self) -> AST:
        name_token = self.expect(TokenType.IDENTIFIER)
        return ast.Name(id=name_token.value, ctx=ast.Load(), **name_token.ast_args)

    # Expression rule helpers.
    # ------------------------------------------------------------------------------------------------------------------

    def parse_binary_operations(self, child_parser: Callable[[], AST], *types: TokenType) -> AST:
        left = child_parser()
        while self.is_type(*types):
            operation_token: Token = self.tokens.next()
            left = ast.BinOp(
                left=left,
                op=binary_operations[operation_token.type_],
                right=child_parser(),
                **operation_token.ast_args,
            )
        return left

    def assign_to(self, left: AST, token: Token):
        if not hasattr(left, 'ctx'):
            self.raise_syntax_error(f"{ast.dump(left)} can't be assigned to", token)
        left.ctx = ast.Store()

    # Parser helpers.
    # ------------------------------------------------------------------------------------------------------------------

    TParser = Callable[..., AST]

    def switch(self, cases: Dict[TokenType, TParser], else_: TParser = None, default: AST = None, **kwargs) -> AST:
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

augmented_assign_operations: Dict[TokenType, AST] = {
    TokenType.ASSIGN_ADD: ast.Add(),
}
