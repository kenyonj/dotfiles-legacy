MattMSumner dotfiles
===============

I use [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles) and
kenyonj/dotfiles-local together using the `*.local` convention described in
thoughtbot/dotfiles.

Requirements
------------

Set zsh as your login shell.

    chsh -s /bin/zsh

Install [rcm](https://github.com/mike-burns/rcm).

    brew tap mike-burns/rcm
    brew install rcm

Install
-------

Clone onto your laptop:

    git clone git://github.com/kenyonj/dotfiles-local.git

Install:

    rcup

This will create symlinks for config files in your home directory.

You can safely run `rcup` multiple times to update.

What's in it?
-------------

[git](http://git-scm.com/) configuration:

* `l` alias for tight, colored, log output.
* `cb` alias for checkout of a new branch.
* `db` alias for deletion of branches.
* `d` alias for `diff`.
* `ds` alias for `diff --cached`.
* `fuckit` alias for throwing everything away.
* My name and email.

[zsh](http://zsh.sourceforge.net/FAQ/zshfaq01.html) configuration and aliases:

* `todo` to edit my todo file, located at `~/Dropbox/todo`.
* Specify location of [Go workspace](http://golang.org/doc/code.html#GOPATH).

[tmux](http://tmux.sourceforge.net/) configuration:

* fix for copy/paste functionality with osx
* vim like selection of text
* smaller increment resizing with alt+(h,j,k,l)
* smart pane switching with ctrl+(h,j,k,l) to move between panes and vim
