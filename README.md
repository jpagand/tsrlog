# tsrlog

A tool to make working with streaming log files easier.

## Usage

- Run `ruby main.rb production` to start tailing the production logs (staging and development are also supported).
- Type `fail` (or `f`) to see failed requests since last time you ran `fail`. This will search the logs for lines matching `Completed [^2]`.
- Type `exit` to exit.
- Type anything else to search the logs for that pattern, this will often the ID of some request you want to investigate.

## A better UX

I recommend installing `rlwrap` with `brew install rlwrap` and running the command with `rlwrap ruby main.rb`. `rlwrap` will make the up and down arrows traverse the history just like the shell.

You can make a shell alias to avoid typing to much. I have this on my `.zshrc`:

```
alias tsrlogs='rlwrap ruby ~/source/work/tonsser/tsrlog/main.rb'
```
