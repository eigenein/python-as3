"""
Examples used in unit tests and the interactive shell.
"""

from __future__ import annotations

from typing import Any, List, Tuple

from pytest import mark, param

from as3.exceptions import ASSyntaxError
from as3.runtime import ASAny, ASInteger

# FIXME: arithmetic operations still return normal `int` instead of `ASInteger`.
expressions: List[Tuple[str, Any]] = [
    ('42', ASInteger(42)),
    ('2 + 2', 4),
    ('2 + 2 * 2', 6),
    ('(2 + 2) * 2', 8),
    ('1 * (2 * (2 + 2))', 8),
    ('String(2)', '2'),
    ('Math.abs(-2)', 2.0),
    ('Math.acos.__name__', 'acos'),
    ('foo.baz + foo.baz * foo.baz', 6),
    ('(foo.baz + foo.baz) * foo.baz', 8),
    ('bar(2, 42)', 44),
    ('baz()', 42),
    ('false', False),
    ('true', True),
    ('+1', 1),
    ('-1', -1),
    ('+-1', -1),
    ('-+-1', 1),
    ('-1 + -1', -2),
    ('1 != 2', True),
    ('1 != 1', False),
    ('undefined', ASAny()),
    (r'"1\n2\n\""', '1\n2\n\"'),
    ('!true', False),
    ('!false', True),
]

scripts: List[Tuple[str, dict]] = [
    ('var a;', {}),
    ('var a = 1 + 1;', {}),
    ('var a = 42;', {'a': 42}),
    ('var a = 42; var b = 3', {'a': 42, 'b': 3}),
    ('var a = 42; a += 1;', {'a': 43}),
    ('var a = 42; a++;', {'a': 43}),
    ('var a = 42; a--;', {'a': 41}),
    ('var a: *', {'a': ASAny()}),
    ('foo(42);', {}),
    ('function bar() { return 42 }; var a = bar()', {'a': 42}),
    ('function bar() { function baz() { return 42 }; return baz; }; var b = bar()()', {'b': 42}),
    ('var a; if (true) { a = 42 } else { a = 43 }', {'a': 42}),
    ('var a; if (false) a = 43; else a = 42;', {'a': 42}),
    ('{ { } }', {}),
    ('class X { }', {}),
    ('class X { var a = 1; function X() { a = 42; } } var expected = X().a;', {'expected': 42}),
    ('function foo(bar: int) { return bar } var expected = foo(42);', {'expected': 42}),
    ('function foo(bar: int = 42) { return bar } var expected = foo();', {'expected': 42}),
    ('function foo(bar: int) { return bar } var expected = foo();', {'expected': 0}),
    ('function foo(bar: *) { return bar } var expected = foo();', {'expected': ASAny()}),
    ('class X { var bar; function X(foo: int) { bar = foo } }; var a = X(42).bar', {'a': 42}),
    (
        'class X { var a = 43 } '
        'class Y extends X { var a = 42 } '
        'var expected = Y().a',
        {'expected': 42},
    ),
    (
        'class X { var a: int; function X() { this.a = 42 } function baz() { return this.a; } }; '
        'var expected = X().baz()',
        {'expected': 42},
    ),
    (
        'class X { var foo = 0; function X() { foo = 42; } } '
        'class Y extends X { function Y() { super(); } } '
        'var expected = Y().foo;',
        {'expected': 42},
    ),
    (
        'class X { function foo() { return 42 } } '
        'class Y extends X { function foo() { return super.foo() } } '
        'var expected = Y().foo();',
        {'expected': 42},
    ),
    (
        'class X { var a; function X() { a = 42 } } '
        'class Y extends X { function Y() { /* No explicit `super()` call. */ } } '
        'var expected = Y().a;',
        {'expected': 42},
    ),
    ('var foo = 42; while (false) { foo = 0 }', {'foo': 42}),
    ('var foo = 42; while (true) { break; foo = 0 }', {'foo': 42}),

    # Yes, I made it possible to have a function of one statement.
    ('function bar() return 42; var expected = bar()', {'expected': 42}),

    # Yeah, 1-statement class is also possible because why not?
    ('class X var a = 42; var expected = X().a', {'expected': 42}),
]

bad_scripts: List = [
    param('var a = 42; { var a = 43; } ', {'a': 42}, marks=mark.xfail),
    param('var a = b = 42;', {'a': 42, 'b': 42}, marks=mark.xfail),
    param('42 +', {}, marks=mark.xfail(raises=ASSyntaxError, strict=True)),
    param('a = 1 = b;', {}, marks=mark.xfail(raises=ASSyntaxError, strict=True)),
    param('a += b += a;', {}, marks=mark.xfail(raises=ASSyntaxError, strict=True)),
    param('var foo = function() {}', {}, marks=mark.xfail(raises=ASSyntaxError, strict=True)),
]
