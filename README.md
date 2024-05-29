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

## Usage

To create a wrapper around Matlab, simply clone the repo and execute `./install.bash`.
The scripts assumes that you have Matlab installed in `/usr/local/MATLAB`, and that your target fake home directory is in `$XDG_DATA_HOME/MATLAB`, typically `~/.local/share/MATLAB`. If you want to change the defaults, you can modify the variables `TARGET_DIR` and `MATLAB_BASE_PATH` before calling the script like this:
```
MATLAB_BASE_PATH=/path/to/matlab TARGET_DIR=/path/to/fake/home ./install.bash
```
