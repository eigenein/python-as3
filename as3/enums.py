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

    # Reserved identifiers and keywords.
    BREAK = auto()
    CLASS = auto()
    ELSE = auto()
    EXTENDS = auto()
    FALSE = auto()
    FUNCTION = auto()
    IDENTIFIER = auto()
    IF = auto()
    IMPORT = auto()
    OVERRIDE = auto()
    PACKAGE = auto()
    PUBLIC = auto()
    RETURN = auto()
    STATIC = auto()
    SUPER = auto()
    THIS = auto()
    TRUE = auto()
    VAR = auto()
