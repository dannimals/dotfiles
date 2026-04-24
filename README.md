Forked from https://github.com/tylerwolf/dotfiles

## dotfiles

Your dotfiles are how you personalize your system. These are mine.

## install

Run this:

```sh
git clone https://github.com/jxc/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

`dotup` is a simple script that installs some dependencies, sets sane OS X
defaults, and so on. Tweak this script, and occasionally run `dotup` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `bin/` of the `dotfiles` checkout.

## topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

## secrets

Some tools expect secrets that are not tracked in this repo. After bootstrapping, create `~/.secrets` and add any tokens there:

```sh
# ~/.secrets — not tracked in dotfiles
export JIRA_TOKEN="..."
```

This file is sourced automatically by `~/.zshrc` if it exists.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.

