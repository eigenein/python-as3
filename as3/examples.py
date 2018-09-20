"""
Examples used in unit tests and the interactive shell.
"""

from __future__ import annotations

from typing import Any, List, Tuple

from pytest import mark, param

from as3.exceptions import ASSyntaxError
from as3.runtime import ASBoolean, ASInteger, ASNumber, ASObject, ASString, uninitialized

expressions: List[Tuple[str, Any]] = [
    ('42', ASInteger(42)),
    ('2 + 2', 4),
    ('2 + 2 * 2', 6),
    ('(2 + 2) * 2', 8),
    ('1 * (2 * (2 + 2))', 8),
    ('String.<Whatever>(2)', ASString('2')),
    ('String(2)', ASString('2')),
    ('new String(2)', ASString('2')),
    ('Math.abs(-2)', 2.0),
    ('Math.acos.__name__', 'acos'),
    ('foo.baz + foo.baz * foo.baz', 6),
    ('(foo.baz + foo.baz) * foo.baz', 8),
    ('bar(2, 42)', 44),
    ('baz()', 42),
    ('false', ASBoolean(False)),
    ('true', ASBoolean(True)),
    ('+1', ASInteger(1)),
    ('-1', ASInteger(-1)),
    ('+-1', -1),
    ('-+-1', 1),
    ('-1 + -1', -2),
    ('1 != 2', True),
    ('1 != 1', False),
    ('undefined', uninitialized),
    (r'"1\n2\n\""', ASString('1\n2\n\"')),
    ('!true', False),
    ('!false', True),
    ('true && true', ASBoolean(True)),
    ('true || false', ASBoolean(True)),
    ('true || false && false', ASBoolean(True)),
    ('true && false', ASBoolean(False)),
    ('null as ASString', None),
    ('0x2A', ASInteger(42)),
    ('0.25', ASNumber(0.25)),
    ('true ? 42 : 0', ASInteger(42)),
    ('false ? 0 : 42', ASInteger(42)),
    ('[]', []),
    ('["1", "2"]', [ASString('1'), ASString('2')]),
    ('1 is int', True),
    ('1 is String', False),
    ('null', None),
    ('{}', ASObject()),
    ('{1: 2}', ASObject({ASInteger(1): ASInteger(2)})),
    ('{1: {2: 3}}', ASObject({ASInteger(1): ASObject({ASInteger(2): ASInteger(3)})})),
    ('(true ? 1 : true ? 2 : 3)', ASInteger(1)),
    ('(false ? 1 : true ? 2 : 3)', ASInteger(2)),
    ('(false ? 1 : false ? 2 : 3)', ASInteger(3)),
    ('1 == 1', True),
    ('1 ^ 2', 3),
    ('3 ^ 1 ^ 2', 0),

    # For the sake of simplicity a label is evaluated to `None`.
    ('addr58:', None),
]

scripts: List[Tuple[str, dict]] = [
    ('var a;', {}),
    ('var a = 1 + 1;', {}),
    ('var a = 42;', {'a': 42}),
    ('var a = 42; var b = 3', {'a': 42, 'b': 3}),
    ('var a = 42; a += 1;', {'a': 43}),
    ('var a = 42; a++;', {'a': 43}),
    ('var a = 42; a--;', {'a': 41}),
    ('var a: *', {'a': uninitialized}),
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
    ('function foo(bar: *) { return bar } var expected = foo();', {'expected': uninitialized}),
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
    ('while (false) {}', {}),
    ('var foo = 42; while (false) { foo = 0 }', {'foo': 42}),
    ('var foo = 42; while (true) { break; foo = 0 }', {'foo': 42}),
    ('dict_[1] = 42', {'dict_': {1: 42}}),
    ('class X { static var foo = 42 } var bar = X.foo', {'bar': 42}),
    ('class X { static var foo = 42 } var bar = X().foo', {'bar': 42}),
    ('class X { static var foo = 0; function bar() { foo = 42 } }; X().bar(); var baz = X.foo', {'baz': 42}),
    ('class X { static var foo = 42; static var bar = foo }; var baz = X.bar', {'baz': 42}),
    ('class X { static var foo = 0; static function bar() { foo = 42 } }; X.bar(); var baz = X.foo', {'baz': 42}),
    ('class X { static var foo = 42 }; var x = new X(); var baz = x.foo', {'baz': 42}),
    ('function foo() : void {}', {}),
    ('var foo = 0; try { 1 / 0 } catch (e: *) { foo = 42 }', {'foo': 42}),
    ('var foo = 0; try { 1 / 0 } catch (e: FakeException) { foo = 43 } catch (e: *) { foo = 42 }', {'foo': 42}),
    ('var foo = 0; try { 1 / 0 } catch (e: *) { foo = 43 } finally { foo = 42 }', {'foo': 42}),
    ('var foo = 0; try { throw new FakeException() } catch (e: FakeException) { foo = 42 } catch (e: *) { foo = 43 }', {'foo': 42}),
    ('addr58:', {}),
    ('§§push(43); §§push(42); var foo = §§pop(); var bar = §§pop()', {'foo': 42, 'bar': 43}),
    ('import flash.display.MovieClip', {}),
    ('var map: Object = new Object(); map.name1 = "Lee"', {'map': {'name1': 'Lee'}}),
    ('import flash.utils.getQualifiedClassName', {}),
    ('class X { var a = 42 } var expected = X().a', {'expected': 42}),
    ('class X { static var foo = X() }', {}),
    ('class X { static var foo = 43 }; X().foo = 42; var bar = X.foo', {'bar': 42}),
    ('class X { static var foo = bar; static var bar = 42 } var baz = X.foo', {'baz': 42}),
    ('class X { var foo = bar; static var bar = 42 } var baz = X().foo', {'baz': 42}),
    ('class X { static var x = X() }', {}),
    ('function foo(bar: Vector.<Whatever>) { return bar }; var baz = foo()', {'baz': None}),
    ('var bar = {"baz": "hello"}; var baz = "baz" in bar; var qux = "qux" in bar', {'baz': True, 'qux': False}),
    ('public interface IDisposable { function dispose() : void; }', {}),

    # Yes, it's possible to have a function of one statement.
    ('function bar() return 42; var expected = bar()', {'expected': 42}),
]

bad_scripts: List = [
    param('var a = 42; { var a = 43; } ', {'a': 42}, marks=mark.xfail),
    param('var a = b = 42;', {'a': 42, 'b': 42}, marks=mark.xfail),
    param('class X { var foo }; var bar = "foo" in X()', {'bar': True}, marks=mark.xfail),
    param('a = 1 = b;', {}, marks=mark.xfail(raises=ASSyntaxError)),
    param('a += b += a;', {}, marks=mark.xfail(raises=ASSyntaxError)),
    param('var foo = function() {}', {}, marks=mark.xfail(raises=ASSyntaxError)),
]
