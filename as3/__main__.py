from __future__ import annotations

import os
import random
import sys
from pathlib import Path
from typing import Any, Dict, Tuple

import click
from prompt_toolkit import PromptSession
from prompt_toolkit.lexers import PygmentsLexer
from prompt_toolkit.styles import style_from_pygments_cls
from pygments.lexers.actionscript import ActionScript3Lexer
from pygments.styles.native import NativeStyle

from as3 import constants, examples, execute_script


@click.command()
@click.option('-s', '--shell', is_flag=True, help='Start interactive shell.')
@click.option(
    '-p', '--packages-path',
    type=click.Path(exists=True, dir_okay=True, file_okay=False),
    default=os.getcwd(),
    help='Packages root path.',
)
@click.argument('scripts', type=click.Path(exists=True, dir_okay=False), nargs=-1)
def main(shell: bool, packages_path: str, scripts: Tuple[str]):
    """
    Execute ActionScript files.
    """
    globals_: Dict[str, Any] = {constants.packages_path_name: Path(packages_path)}
    for script in scripts:
        path = Path(script)
        # noinspection PyBroadException
        try:
            globals_.update(execute_script(path.open('rt', encoding='utf-8').read(), path.name, **globals_))
        except Exception as e:
            click.echo(f'{click.style("Error", fg="red")}: {e}')
            sys.exit(1)
    if shell:
        run_shell(globals_)


def run_shell(globals_: dict):
    session = PromptSession()
    style = style_from_pygments_cls(NativeStyle)

    example, _ = random.choice([*examples.scripts, *examples.expressions])  # type: str, Any
    click.echo(f'{click.style("Welcome to as3 shell!", fg="green")}')
    click.echo(f'{click.style("Try", fg="green")}: {click.style(example, fg="blue")}')
    click.echo(f'{click.style("Use", fg="green")}: {click.style("trace(...)", fg="blue")} {click.style("to print something.", fg="green")}')

    while True:
        line = session.prompt('>>> ', lexer=PygmentsLexer(ActionScript3Lexer), style=style)
        # noinspection PyBroadException
        try:
            globals_.update(execute_script(line, '<shell>', **globals_))
        except Exception as e:
            click.echo(f'{click.style("Error", fg="red")}: {e}')


if __name__ == '__main__':
    main()
