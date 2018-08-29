from __future__ import annotations

from typing import Any, List, Tuple

from pytest import mark, param

from as3.exceptions import ASSyntaxError

expressions: List[Tuple[str, Any]] = [
    ('42', 42),
    ('2 + 2', 4),
    ('2 + 2 * 2', 6),
    ('(2 + 2) * 2', 8),
    ('String(2)', '2'),
    ('Math.abs(-2)', 2),
    ('Math.acos.__name__', 'acos'),
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
    ('class X { var a = 1; function X() { a = 42; } } var expected = X().a;', {'expected': 42}),

    # Yes, I made it possible to have a function of one statement.
    ('function bar() return 42; var expected = bar()', {'expected': 42}),

    # Yeah, 1-statement class is also possible because why not?
    ('class X var a = 42; var expected = X().a', {'expected': 42}),
]

bad_scripts: List = [
    param('var a: *', {}, marks=mark.xfail(strict=True, raises=ASSyntaxError)),
    param('var a = 42; { var a = 43; } ', {'a': 42}, marks=mark.xfail(strict=True)),
    param('var a = b = 42;', {'a': 42, 'b': 42}, marks=mark.xfail(strict=True)),
    param('class X { var a = 43 } class Y extends X { var a = 42 } var output = Y().a', {'output': 42}, marks=mark.xfail(strict=True)),
    param('class X { var a; X() { a = 42 } } class Y extends X { Y() {} } var output = Y().a', {'output': 42}, marks=mark.xfail(strict=True)),
    param('a = 1 = b;', {}, marks=mark.xfail(raises=ASSyntaxError, strict=True)),
    param('a += b += a;', {}, marks=mark.xfail(raises=ASSyntaxError, strict=True)),
    param('var foo = function() {}', {}, marks=mark.xfail(raises=ASSyntaxError, strict=True)),
    param('function foo(bar: int) { return bar } var expected = foo(42);', {'expected': 42}, marks=mark.xfail(raises=TypeError, strict=True)),
]
