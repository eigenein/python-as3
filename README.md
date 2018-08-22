Adobe ActionScript 3 interpreter in Python.

This is an ActionScript to Python AST compiler. It parses ActionScript source code and produces an [`ast.Module`](https://docs.python.org/3/library/ast.html#abstract-grammar) instance which can be just normally compiled and executed with standard [`compile`](https://docs.python.org/3/library/functions.html#compile) and [`exec`](https://docs.python.org/3/library/functions.html#exec) functions.

##### Disclaimer

I just needed to execute a specific set of ActionScript scripts produced by amazing [JPEXS Flash Decompiler](https://github.com/jindrapetrik/jpexs-decompiler), and not to build a strict ActionScript compiler. So, this implementation may not strictly follow the ActionScript specification.

Though, you're welcome to make a pull request to improve it. Please, try to follow the code style and add unit tests where it's reasonable.

## Recipes

TODO
