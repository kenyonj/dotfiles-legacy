Justin Kenyon's dotfiles
===============

I use [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles) and
kenyonj/dotfiles-local together using the `*.local` convention described in
thoughtbot/dotfiles.

Requirements
------------

These dotfiles are meant to work in conjunction with the [thoughtbot/dotfiles]
(https://github.com/thoughtbot/dotfiles). Please install those first.

Install
-------

Clone into your environment:

git clone git://github.com/kenyonj/dotfiles-local.git

Install:

rcup

This will create symlinks in your home (`~/`) directory for all the config files
that you have in your `dotfiles-local` directory.

You can safely run `rcup` multiple times to update.

What's in it?
-------------
These are a sampling. For complete changes, please review the source.

###[git](http://git-scm.com/) configuration:
  * `git` or `g` followed by:
    - `fuckit`: resets your current directory to it's last checked in state.
      (be careful with this command, as its name implies, this is a last case
option)
  * `amend`: `git commit --amend`
  * `amendne`: `git commit --amend --no-edit`
  * `ga`: `git add`
  * `gall`: `git add -A`
  * `gap`: `git add -p`
  * `gb`: `git branch`
  * `gba`: `git branch -a`
  * `gbrn`: `git branch -m`
  * `gc`: `git commit`
  * `gcl`: `git clone`
  * `gcm`: `git commit -m`
  * `gco`: `git checkout`
  * `gcp`: `git cherry-pick`
  * `gd`: `git diff`
  * `gf`: `git fetch`
  * `gl`: `git log -10 --pretty=colored`
  * `gpr`: `hub pull-request`
  * `gr`: `git rebase`
  * `gra`: `git rebase --abort`
  * `grc`: `git rebase --continue`
  * `gri`: `git rebase -i`
  * `gs`: `git status -s`
  * `standup`: `git standup`

####functions available:
  * `gpair()`: This can be run, followed by the first name of the person you
    are pairing with to change the lastest commit's author and email address.

    Example: If I run `gpair Bruce Wayne` it will use my `~/.gitconfig.local` to build this command:

    `git commit --amend --no-edit --author "Justin Kenyon & Bruce Wayne <justin+bruce@thoughtbot.com>"`

  * `gsolo()`: This can be run with no arguments and will change the latest
    commit to show only the current user as the author.

    Example: If I run `gsolo` it will use my `~/.gitconfig.local` to build this command:

    `git commit --amend --no-edit --author "Justin Kenyon <kenyonj@gmail.com>"`

###[zsh](http://zsh.sourceforge.net/FAQ/zshfaq01.html) configuration and aliases:
  * `..`: moves up 1 directory, alias of `cd ..`
  * `...`: moves up 2 directories, alias of `cd ../..`
  * `j <part of directory name>`: uses [fasd](https://github.com/clvv/fasd) to
    jump to previously visited directories (stored in `~/.fasd`). For example,
    if I execute `j local` it will `cd` into my `dotfiles-local` directory
    because it is the most recent directory I visited that matches my argument
    of `local`.

###[tmux](http://tmux.sourceforge.net/) configuration:
  * Uses `CTRL-a` for the command key
  * All of the following command keys need to be preceeded by entering command
    mode:
    - `r`: reloads the `~/.tmux.conf` config file
    - `^T`: vertical split, 25%
    - `^U`: horizontal split, 30%
    - `c`: new window in current session
    - `|`: splits the current pane horizontally, 50%
    - `-`: splits the current pane vertically, 50%
    - `^A`: cycles the cursor through the visable panes
    - `+`: zooms in and out of current pane
    - `^C`: clears the buffer in the current pane

###[vim](http://vim.org/) configuration:
  * Leader key (`space-bar`) followed by:
    - `i`: indent the whole file
    - `sc`: show the schema file
    - `n`: rename the current file
    - `s`: run the last spec file that was run, or the current test that the
      cursor is in
    - `p`: insert a `binding.pry` in a new line above the cursor position
    - `r`: toggle between `Relative Number` and normal line numbering
    - `sp`: toggle between on and off for `spell check` mode
    - `ws`: strips all whitespace from the file
    - `c`: removes all comments from the current file

  * Aliased commands
    - `:W`: `:w`
    - `:Q`: `:q`
    - `:Wq`: `:wq`
    - `jj`: `ESC`

