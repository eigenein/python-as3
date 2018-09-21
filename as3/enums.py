from enum import Enum, auto


class TokenType(Enum):
    # Special types that are only used by the scanner.
    # Though, `NEW_LINE` potentially could be used by the parser.
    NEW_LINE = auto()
    UNKNOWN = auto()
    WHITESPACE = auto()

    # Non-instructions.
    COMMENT = auto()

    # Brackets.
    BRACKET_CLOSE = auto()
    BRACKET_OPEN = auto()
    CURLY_BRACKET_CLOSE = auto()
    CURLY_BRACKET_OPEN = auto()
    PARENTHESIS_CLOSE = auto()
    PARENTHESIS_OPEN = auto()
    GENERIC_OPEN = auto()

    # Punctuation.
    COLON = auto()
    COMMA = auto()
    DOT = auto()
    QUESTION_MARK = auto()
    SEMICOLON = auto()

    # Literals.
    NUMBER = auto()
    STRING = auto()
    STRING_1 = STRING_2 = STRING

    # Operators.
    ASSIGN = auto()
    ASSIGN_ADD = auto()
    BITWISE_XOR = auto()
    DECREMENT = auto()
    DIVIDE = auto()
    EQUALS = auto()
    GREATER = auto()
    GREATER_OR_EQUAL = auto()
    INCREMENT = auto()
    LEFT_SHIFT = auto()
    LESS = auto()
    LESS_OR_EQUAL = auto()
    LOGICAL_AND = auto()
    LOGICAL_NOT = auto()
    LOGICAL_OR = auto()
    MINUS = auto()
    MULTIPLY = auto()
    NOT_EQUALS = auto()
    PLUS = auto()
    RIGHT_SHIFT = auto()
    STRICTLY_EQUAL = auto()
    UNSIGNED_RIGHT_SHIFT = auto()

    # Reserved identifiers and keywords.
    AS = auto()
    BREAK = auto()
    CATCH = auto()
    CLASS = auto()
    CONST = auto()
    EACH = auto()
    ELSE = auto()
    EXTENDS = auto()
    FALSE = auto()
    FINALLY = auto()
    FOR = auto()
    FUNCTION = auto()
    GET = auto()
    IDENTIFIER = auto()
    IF = auto()
    IMPLEMENTS = auto()
    IMPORT = auto()
    IN = auto()
    INTERFACE = auto()
    INTERNAL = auto()
    IS = auto()
    NEW = auto()
    NULL = auto()
    OVERRIDE = auto()
    PACKAGE = auto()
    PRIVATE = auto()
    PROTECTED = auto()
    PUBLIC = auto()
    RETURN = auto()
    STATIC = auto()
    SUPER = auto()
    THIS = auto()
    THROW = auto()
    TRUE = auto()
    TRY = auto()
    UNDEFINED = auto()
    VAR = auto()
    VOID = auto()
    WHILE = auto()
