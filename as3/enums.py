from enum import Enum, auto


class TokenType(Enum):
    # Special types that are only used by the scanner.
    # Though, `NEW_LINE` potentially could be used by the parser.
    NEW_LINE = auto()
    UNKNOWN = auto()
    WHITESPACE = auto()

    # Comments and whitespaces.
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

    # Operators.
    ASSIGN = auto()
    ASSIGN_ADD = auto()
    DECREMENT = auto()
    DIVIDE = auto()
    EQUALS = auto()
    GREATER = auto()
    INCREMENT = auto()
    LEFT_SHIFT = auto()
    LESS = auto()
    LESS_OR_EQUALS = auto()
    LOGICAL_AND = auto()
    LOGICAL_NOT = auto()
    LOGICAL_OR = auto()
    MINUS = auto()
    MULTIPLY = auto()
    NOT_EQUALS = auto()
    PLUS = auto()
    RIGHT_SHIFT = auto()
    UNSIGNED_RIGHT_SHIFT = auto()

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
    NEW = auto()
    OVERRIDE = auto()
    PACKAGE = auto()
    PUBLIC = auto()
    RETURN = auto()
    STATIC = auto()
    SUPER = auto()
    THIS = auto()
    TRUE = auto()
    VAR = auto()
