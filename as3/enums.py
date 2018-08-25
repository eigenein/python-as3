from enum import Enum, auto


class TokenType(Enum):
    # Comments.
    COMMENT = auto()

    # Brackets.
    BRACKET_CLOSE = auto()
    BRACKET_OPEN = auto()
    CURLY_BRACKET_CLOSE = auto()
    CURLY_BRACKET_OPEN = auto()
    PARENTHESIS_CLOSE = auto()
    PARENTHESIS_OPEN = auto()

    # Punctuation.
    COLON = auto()
    COMMA = auto()
    DOT = auto()
    SEMICOLON = auto()

    # Literals.
    FLOAT = auto()
    INTEGER = auto()

    # Binary operators.
    ASSIGN = auto()
    ASSIGN_ADD = auto()
    DIVIDE = auto()
    LEFT_SHIFT = auto()
    LESS = auto()
    MINUS = auto()
    PLUS = auto()
    MULTIPLY = auto()

    # Identifiers.
    BREAK = auto()
    CLASS = auto()
    EXTENDS = auto()
    FUNCTION = auto()
    IDENTIFIER = auto()
    IF = auto()
    IMPORT = auto()
    OVERRIDE = auto()
    PACKAGE = auto()
    PUBLIC = auto()
    RETURN = auto()
    STATIC = auto()
    VAR = auto()
    # TODO: true
    # TODO: false
    # TODO: this


class ContextType(Enum):
    CODE_BLOCK = auto()
    PACKAGE = auto()
    CLASS = auto()
    METHOD = auto()
