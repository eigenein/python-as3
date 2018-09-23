from __future__ import annotations

import os
import sys
import traceback
from pathlib import Path
from typing import Tuple

import click
from prompt_toolkit import PromptSession
from prompt_toolkit.lexers import PygmentsLexer
from prompt_toolkit.styles import style_from_pygments_cls
from pygments import highlight
from pygments.formatters.terminal import TerminalFormatter
from pygments.lexers.actionscript import ActionScript3Lexer
from pygments.lexers.python import Python3Lexer, Python3TracebackLexer
from pygments.styles.native import NativeStyle

from as3 import Environment, execute
from as3.exceptions import ASRuntimeError, ASSyntaxError


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
    environment = Environment()
    for script in scripts:
        path = Path(script)
        # noinspection PyBroadException
        try:
            execute(path.open('rt', encoding='utf-8').read(), str(path), environment)
        except Exception as e:
            print_exception(e)
            sys.exit(1)
    if shell:
        run_shell(environment)


def run_shell(environment: Environment):
    session = PromptSession()
    style = style_from_pygments_cls(NativeStyle)

    click.echo(f'{click.style("Welcome to as3 shell!", fg="yellow")}')

    while True:
        line = session.prompt('>>> ', lexer=PygmentsLexer(ActionScript3Lexer), style=style)
        # noinspection PyBroadException
        try:
            value = execute(line, '<shell>', environment)
        except Exception as e:
            print_exception(e)
        else:
            if value is not None:
                print(highlight(repr(value), Python3Lexer(), TerminalFormatter()))


def print_exception(e: Exception):
    if isinstance(e, ASSyntaxError):
        click.echo(f'{click.style("Error:", fg="red", bold=True)} {e}')
    elif isinstance(e, ASRuntimeError):
        # TODO: proper traceback.
        click.echo(f'{click.style("Runtime error:", fg="red", bold=True)} {e}')
    else:
        click.echo(f'{click.style("Internal interpreter error:", fg="red", bold=True)}')
        click.echo(highlight(traceback.format_exc(), Python3TracebackLexer(), TerminalFormatter()))


if __name__ == '__main__':
    main()
