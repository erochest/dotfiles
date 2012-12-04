#!/bin/bash

# Load RVM, if you are using it
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

# Path to the bash it configuration
export BASH_IT=$HOME/.bash_it

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='pete'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@github.com'

# Set my editor and git editor
export EDITOR="/usr/local/bin/vim"
export GIT_EDITOR='/usr/local/bin/vim'

# Set the path nginx

# Don't check mail when opening terminal.
unset MAILCHECK


# Set this to the command you use for todo.txt-cli
export TODO="t"

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if which brew > /dev/null 2>&1 ; then
    if [ -f `brew --prefix`/etc/bash_completion ]; then
        . `brew --prefix`/etc/bash_completion
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi

# Load Bash It
source $BASH_IT/bash_it.sh
