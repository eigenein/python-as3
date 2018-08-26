from __future__ import annotations

import ast
from ast import AST
from dataclasses import dataclass
from typing import Callable, Dict, Iterable, List, NoReturn, Optional

from more_itertools import consume, peekable

from as3.constants import augmented_assign_operations, binary_operations, unary_operations
from as3.enums import ContextType, TokenType
from as3.exceptions import ASSyntaxError
from as3.scanner import Token


@dataclass
class Context:
    """
    Represents the current parser context and used to link entities to each other.
    """
    type_: ContextType
    name: Optional[str] = None  # context object name


class Parser:
    def __init__(self, tokens: Iterable[Token]):
        self.tokens = peekable(filter_tokens(tokens))

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
                statements.append(self.parse_statement(Context(ContextType.CODE_BLOCK)))
        return ast.Module(body=statements)

    def parse_package(self) -> Iterable[AST]:
        self.expect(TokenType.PACKAGE)
        package_name = tuple(self.parse_qualified_name()) if self.is_type(TokenType.IDENTIFIER) else ()
        yield from self.parse_code_block(Context(ContextType.PACKAGE, package_name))

    def parse_class(self, context: Context) -> AST:
        class_token = self.expect(TokenType.CLASS)
        name = self.expect(TokenType.IDENTIFIER).value
        bases = [self.parse_additive_expression(context)] if self.skip(TokenType.EXTENDS) else []  # FIXME: `ASObject`.
        body = list(self.parse_code_block(Context(ContextType.CLASS, name)))
        return make_ast(class_token, ast.ClassDef, name=name, bases=bases, keywords=[], body=body, decorator_list=[])

    def parse_parameter_definition(self, context: Context) -> AST:
        parameter_name = self.expect(TokenType.IDENTIFIER).value
        self.expect(TokenType.COLON)
        type_name = tuple(self.parse_qualified_name())
        if self.skip(TokenType.ASSIGN):
            default_value = self.parse_additive_expression(context)

    def parse_code_block(self, context: Context) -> Iterable[AST]:
        self.expect(TokenType.CURLY_BRACKET_OPEN)
        while not self.is_type(TokenType.CURLY_BRACKET_CLOSE):
            yield self.parse_statement(context)
        # Always add `pass` to be sure the body is not empty.
        yield make_ast(self.expect(TokenType.CURLY_BRACKET_CLOSE), ast.Pass)

    def parse_code_block_or_statement(self, context: Context) -> Iterable[AST]:
        if self.is_type(TokenType.CURLY_BRACKET_OPEN):
            yield from self.parse_code_block(context)
        else:
            yield self.parse_statement(context)

    def parse_statement(self, context: Context) -> AST:
        consume(self.parse_modifiers())  # FIXME: should only be allowed in some contexts
        return self.switch({
            TokenType.IMPORT: self.parse_import,
            TokenType.CLASS: self.parse_class,
            TokenType.VAR: self.parse_variable_definition,
            TokenType.IF: self.parse_if,
            TokenType.SEMICOLON: self.parse_semicolon,
            TokenType.RETURN: self.parse_return,
            TokenType.FUNCTION: self.parse_function_definition,
        }, else_=self.parse_expression_statement, context=context)

    def parse_expression_statement(self, context: Context) -> AST:
        value = self.parse_expression(context)
        self.skip(TokenType.SEMICOLON)
        if isinstance(value, (ast.Assign, ast.AugAssign, ast.FunctionDef, ast.ClassDef)):
            # Assignments, functions and classes are not expressions in Python.
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

    def parse_import(self, context: Context) -> AST:
        self.expect(TokenType.IMPORT)
        qualified_name = tuple(self.parse_qualified_name())
        self.expect(TokenType.SEMICOLON)

    def parse_if(self, context: Context) -> AST:
        if_token = self.expect(TokenType.IF)
        self.expect(TokenType.PARENTHESIS_OPEN)
        test = self.parse_additive_expression(context)
        self.expect(TokenType.PARENTHESIS_CLOSE)
        body = list(self.parse_code_block_or_statement(context))
        or_else = list(self.parse_code_block_or_statement(context)) if self.skip(TokenType.ELSE) else []
        return make_ast(if_token, ast.If, test=test, body=body, orelse=or_else)

    def parse_variable_definition(self, context: Context) -> AST:
        raise NotImplementedError(TokenType.VAR)

    def parse_semicolon(self, context: Context) -> AST:
        pass_token = self.expect(TokenType.SEMICOLON)
        return make_ast(pass_token, ast.Pass)

    def parse_return(self, context: Context) -> AST:
        return_token = self.expect(TokenType.RETURN)
        if not self.skip(TokenType.SEMICOLON):
            value = self.parse_expression(context)
        else:
            value = None
        return make_ast(return_token, ast.Return, value=value)

    def parse_function_definition(self, context: Context) -> AST:
        function_token = self.expect(TokenType.FUNCTION)
        name = self.expect(TokenType.IDENTIFIER).value  # TODO: anonymous functions.

        # Parse arguments.
        self.expect(TokenType.PARENTHESIS_OPEN)
        args: List[AST] = []
        while not self.skip(TokenType.PARENTHESIS_CLOSE):
            self.parse_parameter_definition(context)
            self.skip(TokenType.COMMA)
        returns = self.parse_additive_expression(context) if self.skip(TokenType.COLON) else None

        # Is it a method?
        if context.type_ == ContextType.CLASS:
            args.append(ast.arg(arg='self', annotation=None, lineno=function_token.line_number, col_offset=0))
            # Is this a constructor?
            if name == context.name:
                # FIXME: call `super()`: https://stackoverflow.com/a/7538926/359730
                name = '__init__'

        # Parse body.
        body_context = Context(ContextType.METHOD if context.type_ == ContextType.CLASS else ContextType.CODE_BLOCK)
        body = list(self.parse_code_block(body_context))

        # TODO: arguments.
        # TODO: defaults.
        # TODO: modifiers in `decorator_list`.
        # TODO: `staticmethod`.
        return make_ast(
            function_token,
            ast.FunctionDef,
            name=name,
            args=ast.arguments(args=args, vararg=None, kwonlyargs=[], kw_defaults=[], kwarg=None, defaults=[]),
            body=body,
            decorator_list=[],
            returns=returns,
        )

    # Expression rules.
    # Methods are ordered according to reversed precedence.
    # https://www.adobe.com/devnet/actionscript/learning/as3-fundamentals/operators.html#articlecontentAdobe_numberedheader_1
    # ------------------------------------------------------------------------------------------------------------------

    def parse_expression(self, context: Context) -> AST:
        return self.parse_assignment_expression(context)

    def parse_assignment_expression(self, context: Context) -> AST:
        left = self.parse_additive_expression(context)
        return self.switch({
            TokenType.ASSIGN: self.parse_chained_assignment_expression,
            TokenType.ASSIGN_ADD: self.parse_augmented_assignment_expression,
        }, default=left, left=left, context=context)

    def parse_chained_assignment_expression(self, left: AST, context: Context) -> AST:
        # First, assume it's not a chained assignment.
        assignment_token = self.expect(TokenType.ASSIGN)
        set_store_context(left, assignment_token)
        value = self.parse_additive_expression(context)
        left = make_ast(assignment_token, ast.Assign, targets=[left], value=value)
        # Then, check if it's chained.
        while self.skip(TokenType.ASSIGN):
            # Yes, it is. Read a value at the right.
            value = self.parse_additive_expression(context)
            # Former value becomes a target.
            set_store_context(left.value, assignment_token)
            left.targets.append(left.value)
            # Value at the right becomes the assigned value.
            left.value = value
        return left

    def parse_augmented_assignment_expression(self, left: AST, context: Context) -> AST:
        # FIXME: I didn't find a good way to implement chained augmented assignments like `a += b += a` in Python AST.
        # FIXME: So, only `a += b` is allowed. Sorry.
        assignment_token = self.expect(*augmented_assign_operations)
        set_store_context(left, assignment_token)
        value = self.parse_additive_expression(context)
        return make_ast(
            assignment_token,
            ast.AugAssign,
            target=left,
            op=augmented_assign_operations[assignment_token.type_],
            value=value,
        )

    def parse_additive_expression(self, context: Context) -> AST:
        return self.parse_binary_operations(
            self.parse_multiplicative_expression,
            context,
            TokenType.PLUS,
            TokenType.MINUS,
        )

    def parse_multiplicative_expression(self, context: Context) -> AST:
        return self.parse_binary_operations(
            self.parse_unary_expression,
            context,
            TokenType.MULTIPLY,
            TokenType.DIVIDE,
        )

    def parse_unary_expression(self, context: Context) -> AST:
        if self.is_type(*unary_operations):
            operation_token: Token = self.tokens.next()
            return make_ast(
                operation_token,
                ast.UnaryOp,
                op=unary_operations[operation_token.type_],
                operand=self.parse_unary_expression(context),
            )
        return self.parse_primary_expression(context)

    def parse_primary_expression(self, context: Context) -> AST:
        left = self.parse_terminal_or_parenthesized(context)
        cases = {
            TokenType.DOT: self.parse_attribute_expression,
            TokenType.PARENTHESIS_OPEN: self.parse_call_expression,
        }
        while self.is_type(*cases):
            left = self.switch(cases, left=left, context=context)
        return left

    def parse_attribute_expression(self, left: AST, context: Context) -> AST:
        attribute_token = self.expect(TokenType.DOT)
        return make_ast(
            attribute_token,
            ast.Attribute,
            value=left,
            attr=self.expect(TokenType.IDENTIFIER).value,
            ctx=ast.Load(),
        )

    def parse_call_expression(self, left: AST, context: Context) -> AST:
        call_token = self.expect(TokenType.PARENTHESIS_OPEN)
        args: List[AST] = []
        while not self.skip(TokenType.PARENTHESIS_CLOSE):
            args.append(self.parse_assignment_expression(context))
            self.skip(TokenType.COMMA)
        return make_ast(call_token, ast.Call, func=left, args=args, keywords=[])

    def parse_terminal_or_parenthesized(self, context: Context) -> AST:
        return self.switch({
            TokenType.PARENTHESIS_OPEN: self.parse_parenthesized_expression,
            TokenType.INTEGER: self.parse_integer_expression,
            TokenType.IDENTIFIER: self.parse_name_expression,
            TokenType.TRUE: lambda **_: make_ast(self.expect(TokenType.TRUE), ast.NameConstant, value=True),
            TokenType.FALSE: lambda **_: make_ast(self.expect(TokenType.FALSE), ast.NameConstant, value=False),
            TokenType.THIS: lambda **_: make_ast(self.expect(TokenType.THIS), ast.Name, id='self', ctx=ast.Load()),
        }, context=context)

    def parse_parenthesized_expression(self, context: Context) -> AST:
        self.expect(TokenType.PARENTHESIS_OPEN)
        inner = self.parse_expression(context)
        self.expect(TokenType.PARENTHESIS_CLOSE)
        return inner

    def parse_integer_expression(self, context: Context) -> AST:
        value_token = self.expect(TokenType.INTEGER)
        return make_ast(value_token, ast.Num, n=value_token.value)

    def parse_name_expression(self, context: Context) -> AST:
        name_token = self.expect(TokenType.IDENTIFIER)
        return make_ast(name_token, ast.Name, id=name_token.value, ctx=ast.Load())

    # Expression rule helpers.
    # ------------------------------------------------------------------------------------------------------------------

    def parse_binary_operations(self, child_parser: Callable[[Context], AST], context: Context, *types: TokenType) -> AST:
        left = child_parser(context)
        while self.is_type(*types):
            operation_token: Token = self.tokens.next()
            left = make_ast(
                operation_token,
                ast.BinOp,
                left=left,
                op=binary_operations[operation_token.type_],
                right=child_parser(context),
            )
        return left

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
            raise_syntax_error(f'unexpected end of file, expected one of: {types_string}')
        token: Token = self.tokens.peek()
        raise_syntax_error(f'unexpected {token.type_.name} "{token.value}", expected one of: {types_string}', token)


def filter_tokens(tokens: Iterable[Token]) -> Iterable[Token]:
    return (token for token in tokens if token.type_ != TokenType.COMMENT)


def make_ast(token: Token, init: Callable[..., AST], **kwargs) -> AST:
    """
    Helper method to avoid passing `lineno` and `col_offset` all the time.
    """
    return init(**kwargs, lineno=token.line_number, col_offset=token.position)


def set_store_context(left: AST, assignment_token: Token):
    if not hasattr(left, 'ctx'):
        raise_syntax_error(f"{ast.dump(left)} can't be assigned to", assignment_token)
    left.ctx = ast.Store()


def raise_syntax_error(message: str, token: Optional[Token] = None) -> NoReturn:
    """
    Raise syntax error and provide some help message.
    """
    if token:
        raise ASSyntaxError(f'syntax error: {message} at line {token.line_number} position {token.position}')
    else:
        raise ASSyntaxError(f'syntax error: {message}')
