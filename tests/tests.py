from __future__ import annotations

import math
from typing import Any

from pytest import mark, param, raises

from as3 import execute
from as3.interpreter import undefined, Environment


@mark.parametrize('source, expected', [
    ('42', 42),
    ('2 + 2', 4),
    ('2 + 2 * 2', 6),
    ('(2 + 2) * 2', 8),
    ('1 * (2 * (2 + 2))', 8),
    ('new String.<Whatever>(2)', '2'),
    ('new String(2)', '2'),
    ('new String(2)', '2'),
    ('Math.abs(-2)', 2),
    ('Math.acos', math.acos),
    ('foo.baz + foo.baz * foo.baz', 6),
    ('(foo.baz + foo.baz) * foo.baz', 8),
    ('bar(2, 42)', 44),
    ('baz()', 42),
    ('false', False),
    ('true', True),
    ('+1', (1)),
    ('-1', (-1)),
    ('+-1', -1),
    ('-+-1', 1),
    ('-1 + -1', -2),
    ('1 != 2', True),
    ('1 != 1', False),
    ('undefined', undefined),
    (r'"1\n2\n\""', '1\n2\n\"'),
    ('!true', False),
    ('!false', True),
    ('true && true', True),
    ('true || false', True),
    ('true || false && false', True),
    ('true && false', False),
    ('null as String', None),
    ('0x2A', 42),
    ('0.25', 0.25),
    ('true ? 42 : 0', 42),
    ('false ? 0 : 42', 42),
    ('[]', []),
    ('["1", "2"]', ['1', '2']),
    ('1 is int', True),
    ('1 is String', False),
    ('null', None),
    ('{}', {}),
    ('{1: 2}', {1: 2}),
    ('{1: {2: 3}}', {1: {2: 3}}),
    ('(true ? 1 : true ? 2 : 3)', 1),
    ('(false ? 1 : true ? 2 : 3)', 2),
    ('(false ? 1 : false ? 2 : 3)', 3),
    ('1 == 1', True),
    ('1 ^ 2', 3),
    ('3 ^ 1 ^ 2', 0),
    ('new <String>["1", "2", "3"]', ['1', '2', '3']),
    ('new Array.<String>("1", "2", "3")', ['1', '2', '3']),
    ('10 % 4', 2),

    # For the sake of simplicity a label is evaluated to `None`.
    ('addr58:', None),
])
def test_execute_1(source: str, expected: Any) -> None:
    actual = execute(source, '<ast>', Environment(values={
        'foo': {'bar': 42, 'baz': 2},
        'bar': lambda a, b: a + b,
        'baz': lambda: 42,
    }))
    assert type(actual) == type(expected), f'actual: {actual!r}'
    assert actual == expected, f'actual: {actual!r}'


@mark.parametrize('source, expected', [
    ('var a; a', undefined),
    ('var a = 1 + 1; a', 2),
    ('var a = 42; a', 42),
    ('var a = 42; var b = 3; [a, b]', [42, 3]),
    ('var a = 42; a += 1; a', 43),
    ('var a = 42; [a++, a]', [42, 43]),
    ('var a = 42; [a--, a]', [42, 41]),
    ('var a = 42; [++a, a]', [43, 43]),
    ('var a = 42; [--a, a]', [41, 41]),
    ('var a: *; a', undefined),
    ('foo(42)', 42),
    ('function bar() { return 42 }; var a = bar(); a', 42),
    ('function bar() { function baz() { return 42 }; return baz; }; var b = bar()(); b', 42),
    ('var a; if (true) { a = 42 } else { a = 43 }; a', 42),
    ('var a; if (false) a = 43; else a = 42; a', 42),
    ('{1: 2} == {1: 2}', False),
    ('var foo = {1: 2}; foo == foo', True),
    ('{1: 2} != {1: 2}', True),
    ('var foo = {1: 2}; foo != foo', False),
    ('class X { }', {}),
    ('class X { var a = 1; function X() { a = 42; } } var expected = new X().a;', {'expected': 42}),
    ('function foo(bar: int) { return bar } var expected = foo(42);', {'expected': 42}),
    ('function foo(bar: int = 42) { return bar } var expected = foo();', {'expected': 42}),
    ('function foo(bar: int) { return bar } var expected = foo();', {'expected': 0}),
    ('function foo(bar: *) { return bar } var expected = foo();', {'expected': undefined}),
    ('class X { var bar; function X(foo: int) { bar = foo } }; var a = new X(42).bar', {'a': 42}),
    ('class X { var a = 43 } class Y extends X { var a = 42 } var expected = new Y().a', {'expected': 42}),
    (
        'class X { var a: int; function X() { this.a = 42 } function baz() { return this.a; } }; '
        'var expected = new X().baz()',
        {'expected': 42},
    ),
    (
        'class X { var foo = 0; function X() { foo = 42; } } '
        'class Y extends X { function Y() { super(); } } '
        'var expected = new Y().foo;',
        {'expected': 42},
    ),
    (
        'class X { function foo() { return 42 } } '
        'class Y extends X { function foo() { return super.foo() } } '
        'var expected = new Y().foo();',
        {'expected': 42},
    ),
    (
        'class X { var a; function X() { a = 42 } } '
        'class Y extends X { function Y() { /* No explicit `super()` call. */ } } '
        'var expected = new Y().a;',
        {'expected': 42},
    ),
    ('while (false) {}', None),
    ('var foo = 42; while (false) { foo = 0 }; foo', 42),
    ('var foo = 42; while (true) { break; foo = 0 }; foo', 42),
    ('dict_[1] = 42; dict_', {1: 42}),
    ('class X { static var foo = 42 } var bar = X.foo', {'bar': 42}),
    ('class X { static var foo = 42 } var bar = new X().foo', {'bar': 42}),
    ('class X { static var foo = 0; function bar() { foo = 42 } }; new X().bar(); var baz = X.foo', {'baz': 42}),
    ('class X { static var foo = 42; static var bar = foo }; var baz = X.bar', {'baz': 42}),
    ('class X { static var foo = 0; static function bar() { foo = 42 } }; X.bar(); var baz = X.foo', {'baz': 42}),
    ('class X { static var foo = 42 }; var x = new X(); var baz = x.foo', {'baz': 42}),
    ('function foo() : void {}', {}),
    ('var foo = 0; try { 1 / 0 } catch (e: *) { foo = 42 }', {'foo': 42}),
    ('var foo = 0; try { 1 / 0 } catch (e: FakeException) { foo = 43 } catch (e: *) { foo = 42 }', {'foo': 42}),
    ('var foo = 0; try { 1 / 0 } catch (e: *) { foo = 43 } finally { foo = 42 }', {'foo': 42}),
    ('var foo = 0; try { throw new FakeException() } catch (e: FakeException) { foo = 42 } catch (e: *) { foo = 43 }', {'foo': 42}),
    ('addr58:', None),
    ('§§push(43); §§push(42); var foo = §§pop(); var bar = §§pop()', {'foo': 42, 'bar': 43}),
    ('import flash.display.MovieClip', {}),
    ('var map: Object = new Object(); map.name1 = "Lee"', {'map': {'name1': 'Lee'}}),
    ('import flash.utils.getQualifiedClassName', {}),
    ('class X { var a = 42 } var expected = new X().a', {'expected': 42}),
    ('class X { static var foo = X() }', {}),
    ('class X { static var foo = 43 }; new X().foo = 42; var bar = X.foo', {'bar': 42}),
    ('class X { static var foo = bar; static var bar = 42 } var baz = X.foo', {'baz': 42}),
    ('class X { var foo = bar; static var bar = 42 } var baz = new X().foo', {'baz': 42}),
    ('class X { static var x = new X() }', {}),
    ('function foo(bar: Vector.<Whatever>) { return bar }; var baz = foo()', {'baz': None}),
    ('var bar = {"baz": "hello"}; var baz = "baz" in bar; var qux = "qux" in bar', {'baz': True, 'qux': False}),
    ('public interface IDisposable { function dispose() : void; }', {}),
    ('class X { public function get foo() { return 42 } }; var foo = new X().foo', {'foo': 42}),
    ('var foo = 0; for each (var i in {"a": 1, "b": 2, "c": 3}) foo += i', {'foo': 6}),
    ('var foo = 0; for (var i in {2: 1, 3: 2, 4: 3}) foo += i', {'foo': 9}),
    ('class X { var foo = 0; function X() { foo = 42 } }; var foo = new X().foo', {'foo': 42}),
    ('class X { var foo = 0; function X() { foo = 42; super() } }; var foo = new X().foo', {'foo': 42}),
    ('function bar() return 42; var expected = bar()', {'expected': 42}),
    ('new Vector.<*>()', []),
    param('var a = 42; { var a = 43; } ', {'a': 42}, marks=mark.xfail),
    ('var b; var a = b = 42; [a, b]', [42, 42]),
    param('class X { var foo }; var bar = "foo" in X()', {'bar': True}, marks=mark.xfail),
])
def test_execute_2(source: str, expected: Any) -> None:
    class FakeException(Exception):
        pass
    assert execute(source, '<ast>', Environment(values={
        'foo': lambda x: x,
        'dict_': {},
        'FakeException': FakeException,
    })) == expected


@mark.parametrize('source', [
    param('a = 1'),
    param('{ var a = 42; } trace(a);', marks=mark.xfail),
    param('{ var a = 42; } a = 43;', marks=mark.xfail),
])
def test_execute_name_error(source: str):
    with raises(NameError):
        execute(source)
