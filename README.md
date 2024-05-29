# Matlab Deceiver
Simple workaround to stop Matlab from littering your $HOME

## Problem description
Most modern programs made for Unix-based systems use XDG Base Directory Specification, typically defaulting on most distros to `~/.local` `~/.config` `~/.cache` and so on.
However Matlab being first and foremost a program made with Windows users in mind doesn't follow any such specification, instead littering your `$HOME` directory with its own files.
Currently MATLAB R2024a creates three directories in your `$HOME`:

```bash
ls -lah ~
…
.MathWorks
.matlab
.MATLABConnector
…
```
This is a problem, because many programs still refuse to follow XDG guidelines or any sensible conventions, thus cluttering up your `$HOME` directory.

## Solution

The solution is simple workaround. Matlab Deceiver modifies the `$HOME` variable before launching Matlab and before autostarting MathWorks Service Host, so that the directories that Matlab uses are located somewhere else where they don't clutter your home dir (eg. `~/.local/share/matlab` or whatever you like).
