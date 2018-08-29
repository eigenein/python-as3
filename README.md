This is an ActionScript to Python AST [transpiler](https://en.wikipedia.org/wiki/Source-to-source_compiler). It parses ActionScript source code and produces an [`ast.Module`](https://docs.python.org/3/library/ast.html#abstract-grammar) instance which can be just normally compiled and executed with standard [`compile`](https://docs.python.org/3/library/functions.html#compile) and [`exec`](https://docs.python.org/3/library/functions.html#exec) functions.

### ⚡ Pulse

![Build status](https://travis-ci.org/eigenein/python-as3.svg?branch=master) [![GitHub tag](https://img.shields.io/github/tag/eigenein/python-as3.svg)](https://GitHub.com/eigenein/python-as3/tags/) [![GitHub license](https://img.shields.io/github/license/eigenein/python-as3.svg)](https://github.com/eigenein/python-as3/blob/master/LICENSE) [![Say Thanks!](https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg)](https://saythanks.io/to/eigenein)


### Why?

I needed to run some code from a Flash-based game decompiled by amazing [JPEXS Flash Decompiler](https://github.com/jindrapetrik/jpexs-decompiler).

### Disclaimer

The implementation may not strictly follow the ActionScript specification.

Though, you're welcome to make a pull request to improve it. Please, try to follow the code style, run [`isort`](https://github.com/timothycrosley/isort) and add unit tests where applicable.

### Development

* `Pipfile` is here to set up a development environment quickly.
* Use [`isort`](https://github.com/timothycrosley/isort) to sort imports.
* Run tests with [`pytest`](https://docs.pytest.org/en/latest/).

### Recipes

#### Interactive shell

The package contains an interactive shell to play around with the interpreter:

```text
$ as3 --shell
Welcome to as3 shell!
Try: class X { function X() { this.a = 42 } function baz() { return this.a; } }; a = X().baz()
>>> class X { function X() { this.a = 42 } function bar() { return this.a } }
>>> x = X()
>>> trace(x)
<X object at 0x10bbdad68>
>>> trace(x.bar())
42
```

#### Running a script

```python
from as3 import execute_script

execute_script('''
    function bar() {
        return 42
    }

    trace(bar());
''', '<ast>')
```

#### Magic functions

```text
$ as3 --shell
Welcome to as3 shell!
Try: baz()
>>> trace(__globals__().keys())
dict_keys(['__dir__', '__globals__', '__resolve__', 'int', 'Math', 'String', 'trace', 'undefined', 'ASAny', 'ASObject', '__builtins__'])
```
