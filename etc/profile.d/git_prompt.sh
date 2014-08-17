#!/bin/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# This adds the active git branch name to the prompt when you cd to a repository on the command line

function parse_git_branch_and_add_brackets {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \[\1\]/'
}

if [ "$PS1" ]; then
    if [ "$BASH" ]; then
        if [ "`id -u`" -eq 0 ]; then
            export PS1='\[\033[1;31m\]${USER}@${HOSTNAME}\[\033[1;33m\]$(parse_git_branch_and_add_brackets) \[\033[1;34m\]${PWD/#$HOME/~} $\[\033[0m\] '
        else
            export PS1='\[\033[1;32m\]${USER}@${HOSTNAME}\[\033[1;33m\]$(parse_git_branch_and_add_brackets) \[\033[1;34m\]${PWD/#$HOME/~} $\[\033[0m\] '
        fi
    else
        if [ "`id -u`" -eq 0 ]; then
            PS1='# '
        else
            PS1='$ '
        fi
    fi
fi
