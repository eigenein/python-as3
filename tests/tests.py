from __future__ import annotations

import math
from typing import Any

from pytest import mark, param, raises

from as3 import execute
from as3.exceptions import ASReferenceError
from as3.runtime import Environment, undefined


@mark.parametrize('source, expected', [
    ('42', 42),
    ('0x2A', 42),
])
def test_int_literal(source: str, expected: Any):
    assert execute(source) == expected


def test_addition():
    assert execute('2 + 2') == 4


@mark.parametrize('source, expected', [
    ('2 + 2 * 2', 6),
    ('(2 + 2) * 2', 8),
    ('1 * (2 * (2 + 2))', 8),
    ('true || false && false', True),
    ('3 ^ 1 ^ 2', 0),
])
def test_priority(source: str, expected: Any):
    assert execute(source) == expected


def test_new_string_generic():
    assert execute('new String.<Whatever>(2)') == '2'


def test_new_string():
    assert execute('new String(2)') == '2'


@mark.parametrize('source, expected', [
    ('Math.abs(-2)', 2),
    ('Math.acos', math.acos),
])
def test_math(source: str, expected: Any):
    assert execute(source) == expected


@mark.parametrize('source, expected', [
    ('foo.baz + foo.baz * foo.baz', 6),
    ('(foo.baz + foo.baz) * foo.baz', 8),
])
def test_get_property(source: str, expected: Any):
    assert execute(source, environment=Environment({'foo': {'bar': 42, 'baz': 2}})) == expected


@mark.parametrize('source, expected', [
    ('bar(2, 42)', 44),
    ('baz()', 42),
])
def test_call_function(source: str, expected: Any):
    assert execute(source, environment=Environment({
        'bar': lambda a, b: a + b,
        'baz': lambda: 42,
    })) == expected


@mark.parametrize('source, expected', [
    ('false', False),
    ('true', True),
])
def test_boolean_literal(source: str, expected: Any):
    assert execute(source) == expected


@mark.parametrize('source, expected', [
    ('+1', 1),
    ('-1', -1),
    ('+-1', -1),
    ('-+-1', 1),
    ('-1 + -1', -2),
    ('!true', False),
    ('!false', True),
    ('var a = 42; [a++, a]', [42, 43]),
    ('var a = 42; [a--, a]', [42, 41]),
    ('var a = 42; [++a, a]', [43, 43]),
    ('var a = 42; [--a, a]', [41, 41]),
])
def test_unary(source: str, expected: Any):
    assert execute(source) == expected


@mark.parametrize('source, expected', [
    ('1 != 2', True),
    ('1 != 1', False),
    ('true && true', True),
    ('true || false', True),
    ('true && false', False),
    ('null as String', None),
    ('1 is int', True),
    ('1 is String', False),
    ('1 == 1', True),
    ('1 ^ 2', 3),
    ('10 % 4', 2),
    ('{1: 2} == {1: 2}', False),
    ('var foo = {1: 2}; foo == foo', True),
    ('{1: 2} != {1: 2}', True),
    ('var foo = {1: 2}; foo != foo', False),
    ('var bar = {"baz": "hello"}; "baz" in bar', True),
    ('var bar = {"baz": "hello"}; "qux" in bar', False),
])
def test_binary(source: str, expected: Any):
    assert execute(source) == expected


def test_undefined():
    assert execute('undefined') == undefined


@mark.parametrize('source, expected', [
    (r'"1\n2\n\""', '1\n2\n\"'),
])
def test_string_literal(source: str, expected: Any):
    assert execute(source) == expected


@mark.parametrize('source, expected', [
    ('0.25', 0.25),
])
def test_float_literal(source: str, expected: Any):
    assert execute(source) == expected


@mark.parametrize('source, expected', [
    ('true ? 42 : 0', 42),
    ('false ? 0 : 42', 42),
    ('(true ? 1 : true ? 2 : 3)', 1),
    ('(false ? 1 : true ? 2 : 3)', 2),
    ('(false ? 1 : false ? 2 : 3)', 3),
])
def test_conditional(source: str, expected: Any):
    assert execute(source) == expected


@mark.parametrize('source, expected', [
    ('[]', []),
    ('["1", "2"]', ['1', '2']),
    ('new <String>["1", "2", "3"]', ['1', '2', '3']),
    ('new Array.<String>("1", "2", "3")', ['1', '2', '3']),
    ('new Vector.<*>()', []),
])
def test_array(source: str, expected: Any):
    assert execute(source) == expected


def test_null():
    assert execute('null') is None


@mark.parametrize('source, expected', [
    ('{}', {}),
    ('{1: 2}', {1: 2}),
    ('{1: {2: 3}}', {1: {2: 3}}),
])
def test_map_literal(source: str, expected: Any):
    assert execute(source) == expected


def test_label():
    # For the sake of simplicity a label is evaluated to `None`.
    assert execute('addr58:') is None


@mark.parametrize('source, expected', [
    ('var a; a', undefined),
    ('var a = 1 + 1; a', 2),
    ('var a = 42; a', 42),
    ('var a = 42; var b = 3; [a, b]', [42, 3]),
    ('var a: *; a', undefined),
    ('var b; var a = b = 42; [a, b]', [42, 42]),
])
def test_variable_definition(source: str, expected: Any):
    assert execute(source) == expected


@mark.parametrize('source, expected', [
    ('var a = 42; a += 1; a', 43),
])
def test_augmented_assignment(source: str, expected: Any):
    assert execute(source) == expected


@mark.parametrize('source, expected', [
    ('for each (var i in {"a": 1, "b": 2, "c": 3}) foo += i; foo', 6),
    ('for (var i in {2: 1, 3: 2, 4: 3}) foo += i; foo', 9),
])
def test_for(source: str, expected: Any):
    environment = Environment({'foo': 0})
    assert execute(source, environment=environment) == expected


@mark.parametrize('source, expected', [
    ('var a; if (true) { a = 42 } else { a = 43 }; a', 42),
    ('var a; if (false) a = 43; else a = 42; a', 42),
])
def test_if(source: str, expected: Any):
    assert execute(source) == expected


@mark.parametrize('source, expected', [
    ('function foo(bar: int) { return bar } foo(42)', 42),
    ('function foo(bar: int = 42) { return bar } foo()', 42),
    ('function foo(bar: int) { return bar } foo()', 0),
    ('function foo(bar: *) { return bar } foo()', undefined),
])
def test_function_parameter(source: str, expected: Any):
    assert execute(source) == expected


@mark.parametrize('source, expected', [
    ('function foo() : void {}; foo()', None),
    ('function bar() return 42; bar()', 42),
    ('function bar() { function baz() { return 42 }; return baz; }; var b = bar()(); b', 42),
    ('function foo(bar: Vector.<Whatever>) { return bar }; foo()', None),
])
def test_function_return(source: str, expected: Any):
    assert execute(source) == expected


@mark.parametrize('source, expected', [
    ('dict_[1] = 42; dict_', {1: 42}),
    ('var map: Object = new Object(); map.name1 = "Lee"; map', {'name1': 'Lee'}),
])
def test_assign_property(source: str, expected: Any):
    assert execute(source, environment=Environment({'dict_': {}})) == expected


@mark.parametrize('source', [
    param('a = 1'),
])
def test_reference_error(source: str):
    with raises(ASReferenceError):
        execute(source)


# FIXME: these constructs should be implemented and grouped into tests.
@mark.parametrize('source, expected', [
    # ('class X { }; new X()', {}),
    # ('class X { var a = 1; function X() { a = 42; } } var expected = new X().a;', {'expected': 42}),
    # ('class X { var bar; function X(foo: int) { bar = foo } }; var a = new X(42).bar', {'a': 42}),
    # ('class X { var a = 43 } class Y extends X { var a = 42 } var expected = new Y().a', {'expected': 42}),
    # (
    #     'class X { var a: int; function X() { this.a = 42 } function baz() { return this.a; } }; '
    #     'var expected = new X().baz()',
    #     {'expected': 42},
    # ),
    # (
    #     'class X { var foo = 0; function X() { foo = 42; } } '
    #     'class Y extends X { function Y() { super(); } } '
    #     'var expected = new Y().foo;',
    #     {'expected': 42},
    # ),
    # (
    #     'class X { function foo() { return 42 } } '
    #     'class Y extends X { function foo() { return super.foo() } } '
    #     'var expected = new Y().foo();',
    #     {'expected': 42},
    # ),
    # (
    #     'class X { var a; function X() { a = 42 } } '
    #     'class Y extends X { function Y() { /* No explicit `super()` call. */ } } '
    #     'var expected = new Y().a;',
    #     {'expected': 42},
    # ),
    # ('while (false) {}', None),
    # ('var foo = 42; while (false) { foo = 0 }; foo', 42),
    # ('var foo = 42; while (true) { break; foo = 0 }; foo', 42),
    # ('class X { static var foo = 42 } var bar = X.foo', {'bar': 42}),
    # ('class X { static var foo = 42 } var bar = new X().foo', {'bar': 42}),
    # ('class X { static var foo = 0; function bar() { foo = 42 } }; new X().bar(); var baz = X.foo', {'baz': 42}),
    # ('class X { static var foo = 42; static var bar = foo }; var baz = X.bar', {'baz': 42}),
    # ('class X { static var foo = 0; static function bar() { foo = 42 } }; X.bar(); var baz = X.foo', {'baz': 42}),
    # ('class X { static var foo = 42 }; var x = new X(); var baz = x.foo', {'baz': 42}),
    # ('var foo = 0; try { 1 / 0 } catch (e: *) { foo = 42 }', {'foo': 42}),
    # ('var foo = 0; try { 1 / 0 } catch (e: FakeException) { foo = 43 } catch (e: *) { foo = 42 }', {'foo': 42}),
    # ('var foo = 0; try { 1 / 0 } catch (e: *) { foo = 43 } finally { foo = 42 }', {'foo': 42}),
    # ('var foo = 0; try { throw new FakeException() } catch (e: FakeException) { foo = 42 } catch (e: *) { foo = 43 }', {'foo': 42}),
    # ('§§push(43); §§push(42); var foo = §§pop(); var bar = §§pop()', {'foo': 42, 'bar': 43}),
    # ('import flash.display.MovieClip', {}),
    # ('import flash.utils.getQualifiedClassName', {}),
    # ('class X { var a = 42 } var expected = new X().a', {'expected': 42}),
    # ('class X { static var foo = X() }', {}),
    # ('class X { static var foo = 43 }; new X().foo = 42; var bar = X.foo', {'bar': 42}),
    # ('class X { static var foo = bar; static var bar = 42 } var baz = X.foo', {'baz': 42}),
    # ('class X { var foo = bar; static var bar = 42 } var baz = new X().foo', {'baz': 42}),
    # ('class X { static var x = new X() }', {}),
    # ('public interface IDisposable { function dispose() : void; }', {}),
    # ('class X { public function get foo() { return 42 } }; var foo = new X().foo', {'foo': 42}),
    # ('class X { var foo = 0; function X() { foo = 42 } }; var foo = new X().foo', {'foo': 42}),
    # ('class X { var foo = 0; function X() { foo = 42; super() } }; var foo = new X().foo', {'foo': 42}),
    # param('{ var a = 42 }', 42),
    # param('var a = 42; { var a = 43; }; a', 43),
    # param('class X { var foo }; var bar = "foo" in X()', {'bar': True}, marks=mark.xfail),
])
def test_execute_deprecated(source: str, expected: Any) -> None:
    class FakeException(Exception):
        pass
    assert execute(source, '<ast>', Environment(values={'FakeException': FakeException})) == expected
