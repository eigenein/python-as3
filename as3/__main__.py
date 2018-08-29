from __future__ import annotations

import random
import sys
from pathlib import Path
from typing import Any, Tuple

import click
from prompt_toolkit import PromptSession
from prompt_toolkit.lexers import PygmentsLexer
from prompt_toolkit.styles import style_from_pygments_cls
from pygments.lexers.actionscript import ActionScript3Lexer
from pygments.styles.native import NativeStyle

from as3 import examples, execute_script
from as3.runtime import default_globals


@click.command()
@click.option('--shell', is_flag=True,  help='Start interactive shell.')
@click.argument('scripts', type=click.Path(exists=True, dir_okay=False), nargs=-1)
def main(shell: bool, scripts: Tuple[str]):
    """
    Execute ActionScript files.
    """
    globals_ = dict(default_globals)
    for script in scripts:
        path = Path(script)
        # noinspection PyBroadException
        try:
            execute_script(path.open('rt', encoding='utf-8'), path.name, globals_)
        except Exception as e:
            click.echo(f'{click.style("Error", fg="red")}: {click.style(str(path), fg="blue")}: {e}')
            sys.exit(1)
    if shell:
        run_shell(globals_)


def run_shell(globals_: dict):
    session = PromptSession()
    style = style_from_pygments_cls(NativeStyle)

    example, _ = random.choice([*examples.scripts, *examples.expressions])  # type: str, Any
    click.echo(f'{click.style("Welcome to as3 shell!", fg="green")}')
    click.echo(f'{click.style("Try", fg="green")}: {click.style(example, fg="blue")}')

    while True:
        line = session.prompt('>>> ', lexer=PygmentsLexer(ActionScript3Lexer), style=style)
        # noinspection PyBroadException
        try:
            execute_script(line, '<shell>', globals_)
        except Exception as e:
            click.echo(f'{click.style("Error", fg="red")}: {e}')


if __name__ == '__main__':
    main()
