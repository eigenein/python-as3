from __future__ import annotations

from typing import Any, List, Tuple

expressions: List[Tuple[str, Any]] = [
    ('42', 42),
    ('2 + 2', 4),
    ('2 + 2 * 2', 6),
    ('(2 + 2) * 2', 8),
    ('String(2)', '2'),
    ('math.fabs(-2)', 2),
    ('math.acos.__name__', 'acos'),
    ('foo.baz + foo.baz * foo.baz', 6),
    ('(foo.baz + foo.baz) * foo.baz', 8),
    ('bar(2, 42)', 44),
    ('baz()', 42),
    ('false', False),
    ('true', True),
]

scripts: List[Tuple[str, dict]] = [
    ('var a;', {}),
    ('var a = 1 + 1;', {}),
    ('var a = 42;', {'a': 42}),
    ('var a = 42; var b = 3', {'a': 42, 'b': 3}),
    ('var a = 42; a += 1;', {'a': 43}),
    ('foo(42);', {}),
    ('function bar() { return 42 }; var a = bar()', {'a': 42}),
    ('function bar() { function baz() { return 42 }; return baz; }; var b = bar()()', {'b': 42}),
    ('class X { var a: int; function X() { this.a = 42 } function baz() { return this.a; } }; var b = X().baz()', {'b': 42}),
    ('var a; if (true) { a = 42 } else { a = 43 }', {'a': 42}),
    ('var a; if (false) a = 43; else a = 42;', {'a': 42}),
    ('{ { } }', {}),
    # FIXME: ('var a = 42; { var a = 43; } ', {'a': 42}),
    # FIXME: ('var a = b = 42;', {'a': 42, 'b': 42}),
]
