"""
Describes ActionScript syntax.
"""

from __future__ import annotations

from as3 import handlers
from as3.constants import augmented_assign_operations, name_constants, unary_operations
from as3.enums import TokenType
from as3.parsers import end_of_stream, expect, handled, many, maybe, sequence, switch

integer = handled(expect(TokenType.INTEGER), handlers.integer)

identifier = expect(TokenType.IDENTIFIER)

name = handled(identifier, handlers.name)

name_constant = handled(expect(*name_constants.keys()), handlers.name_constant)

parenthesized = handled(sequence(
    expect(TokenType.PARENTHESIS_OPEN),
    lambda tokens: expression(tokens),
    expect(TokenType.PARENTHESIS_CLOSE),
), handlers.parenthesized)

this = expect(TokenType.THIS)

super_expression = sequence(expect(TokenType.SUPER), switch(
    lambda tokens: call_expression(tokens),
    lambda tokens: attribute_expression(tokens),
))

terminal_or_parenthesized = switch(
    parenthesized,
    integer,
    name,
    name_constant,
    this,
    super_expression,
)

attribute_expression = sequence(expect(TokenType.DOT), identifier)

call_expression = sequence(
    expect(TokenType.PARENTHESIS_OPEN),
    many(sequence(lambda tokens: non_assignment_expression(tokens), maybe(expect(TokenType.COMMA)))),
)

primary_expression = sequence(
    terminal_or_parenthesized,
    many(switch(attribute_expression, call_expression)),
)

unary_expression = handled(sequence(many(expect(*unary_operations)), primary_expression), handlers.unary)

multiplicative_expression = sequence(
    unary_expression,
    many(sequence(
        expect(TokenType.MULTIPLY, TokenType.DIVIDE),
        unary_expression,
    )),
)

additive_expression = sequence(
    multiplicative_expression,
    many(sequence(
        expect(TokenType.PLUS, TokenType.MINUS),
        multiplicative_expression,
    )),
)

equality_expression = sequence(
    additive_expression,
    many(sequence(
        expect(TokenType.NOT_EQUALS),
        additive_expression,
    )),
)

non_assignment_expression = equality_expression

chained_assignment_expression = sequence(
    non_assignment_expression,
    many(sequence(expect(TokenType.ASSIGN), non_assignment_expression)),
)

augmented_assignment_expression = sequence(expect(*augmented_assign_operations), non_assignment_expression)

assignment_expression = sequence(
    non_assignment_expression,
    maybe(switch(
        sequence(expect(TokenType.ASSIGN), chained_assignment_expression),
        sequence(expect(TokenType.ASSIGN_ADD), augmented_assignment_expression),
    )),
)

expression = assignment_expression

qualified_name = sequence(identifier, many(sequence(expect(TokenType.DOT), identifier)))

code_block = sequence(
    expect(TokenType.CURLY_BRACKET_OPEN),
    many(lambda tokens: statement(tokens)),
    expect(TokenType.CURLY_BRACKET_CLOSE),
)

import_ = sequence(expect(TokenType.IMPORT), qualified_name, expect(TokenType.SEMICOLON))

type_annotation = switch(expect(TokenType.MULTIPLY), primary_expression)

var = sequence(
    expect(TokenType.VAR),
    expect(TokenType.IDENTIFIER),
    maybe(sequence(expect(TokenType.COLON), type_annotation)),
    maybe(sequence(expect(TokenType.ASSIGN), non_assignment_expression)),
)

if_ = sequence(
    expect(TokenType.IF),
    expect(TokenType.PARENTHESIS_OPEN),
    non_assignment_expression,
    expect(TokenType.PARENTHESIS_CLOSE),
    lambda tokens: statement(tokens),
    maybe(sequence(expect(TokenType.ELSE), lambda tokens: statement(tokens))),
)

semicolon = expect(TokenType.SEMICOLON)

return_ = sequence(
    expect(TokenType.RETURN),
    switch(semicolon, non_assignment_expression),
)

function_ = sequence(
    expect(TokenType.FUNCTION),
    expect(TokenType.IDENTIFIER),
    expect(TokenType.PARENTHESIS_OPEN),
    many(sequence(
        expect(TokenType.IDENTIFIER),
        maybe(sequence(expect(TokenType.COLON), type_annotation)),
        maybe(sequence(expect(TokenType.ASSIGN), non_assignment_expression)),
        maybe(expect(TokenType.COMMA)),
    )),
    expect(TokenType.PARENTHESIS_CLOSE),
    maybe(sequence(expect(TokenType.COLON), non_assignment_expression)),
    lambda tokens: statement(tokens),
)

expression_statement = sequence(expression, maybe(semicolon))

statement = switch(
    code_block,
    import_,
    lambda tokens: class_(tokens),
    var,
    if_,
    semicolon,
    return_,
    function_,
    expression_statement,
)

class_ = sequence(
    expect(TokenType.CLASS),
    identifier,
    maybe(sequence(expect(TokenType.EXTENDS), primary_expression)),
    many(statement),
)

package = sequence(
    expect(TokenType.PACKAGE),
    maybe(qualified_name),
    many(statement),
)

script = handled(sequence(many(switch(package, statement)), end_of_stream), handlers.script)
