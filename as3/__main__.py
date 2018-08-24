from __future__ import annotations

from pathlib import Path
from typing import Tuple

from click import Path, argument, command, echo, option, style
from prompt_toolkit import PromptSession
from prompt_toolkit.lexers import PygmentsLexer
from prompt_toolkit.styles import style_from_pygments_cls
from pygments.lexers.actionscript import ActionScript3Lexer
from pygments.styles.native import NativeStyle

from as3 import execute_script
from as3.stdlib import default_globals


@command()
@option('--shell', is_flag=True,  help='Start interactive shell.')
@argument('scripts', type=Path(exists=True, dir_okay=False), nargs=-1)
def main(shell: bool, scripts: Tuple[str]):
    """
    Execute ActionScript files.
    """
    globals_ = dict(default_globals)
    for script in scripts:
        path = Path(script)
        execute_script(path.open('rt', encoding='utf-8'), path.name, globals_)
    if shell:
        run_shell(globals_)


def run_shell(globals_: dict):
    session = PromptSession()
    prompt_style = style_from_pygments_cls(NativeStyle)

    while True:
        line = session.prompt('> ', lexer=PygmentsLexer(ActionScript3Lexer), style=prompt_style)
        # noinspection PyBroadException
        try:
            execute_script(line, '<shell>', globals_)
        except Exception as e:
            echo(f'{style("Error:", fg="red")} {e}')


if __name__ == '__main__':
    main()
