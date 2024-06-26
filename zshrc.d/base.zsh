# vim: fdm=marker

# zsh {{{1

setopt extended_glob
unsetopt share_history

autoload -U compinit && compinit
export fpath=(~/.dotfiles/zcompdef.d $fpath)

alias quit=exit
alias zsh!='exec env -i HOME="$HOME" TERM="$TERM" zsh'
alias edrc="$EDITOR ~/.dotfiles/zshrc.d/base.zsh"

# Not necessary to explicitly enable vi-mode.  `zsh` infers that we want it
# by inspecting the $EDITOR variable.

# Allow backspace to go beyond the point where insert mode started:
# https://superuser.com/questions/476532/how-can-i-make-zshs-vi-mode-behave-more-like-bashs-vi-mode
bindkey "^?" backward-delete-char

source ~/.dotfiles/plugins/agkozak-zsh-prompt/agkozak-zsh-prompt.plugin.zsh
source ~/.dotfiles/plugins/zsh-window-title/zsh-window-title.plugin.zsh

export AGKOZAK_USER_HOST_DISPLAY=0
export AGKOZAK_BLANK_LINES=1
export AGKOZAK_PROMPT_CHAR=( '$' '%F{red}$%f' ':' )
export AGKOZAK_CUSTOM_SYMBOLS=( '⇣⇡' '⇣' '⇡' '+' 'x' '!' '»' '?' )
export AGKOZAK_SHOW_VIRTUALENV=1

# home directories {{{1
hash -d research=~/research
hash -d hacking=~/hacking
hash -d personal=~/personal
hash -d sandbox=~/sandbox

# locale {{{1
# Necessary to suppress warning from perl when running `sloccount`.  Don't
# know if there are other consequences...
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# cd {{{1
alias lcd='cd'
alias dc='cd'
alias cd..='cd ..'

alias back='cd ~-'
alias here='cd -P .'

function cdd () {
  cd $(dirname $1)
}

# ls {{{1

eval $(dircolors ~/.dotfiles/dircolors.in)

function ls () {
	/bin/ls $@                                                          \
	    -h                                                              \
	    -v                                                              \
	    -X                                                              \
	    --color                                                         \
	    --group-directories-first                                       \
	    --hide="*~"                                                     \
	    --hide="*.pyc"                                                  \
	    --hide="\#*\#"                                                  \
	    --hide="*.aux"                                                  \
	    --hide="*.nlo"                                                  \
	    --hide="*.bbl"                                                  \
	    --hide="*.blg"                                                  \
	    --hide="_minted-*"                                              \
	    --hide="__pycache__"                                            \
	    --hide="R"                                                      \
	    --hide="lost+found"                                             \
	    --hide="autom4te.cache"                                         \
	    --hide="Makefile.in"                                            \
	    --hide="aclocal.m4"                                             \
	    --hide="autom4te.cache"                                         \
	    --hide="databases-incognito"                                    \
	    --hide="VideoDecodeStats"                                       \
	    --hide="tags"                                                   \
	    --hide="*.egg-info"
}

# There are a lot of ways that I tend to misspell 'ls'.

alias l='ls'
alias s='ls'
alias sl='ls'
alias ld='ls'
alias ks='ls'
alias sk='ls'
alias lls='ls'
alias lks='ls'
alias la='ls -A'
alias ll='ls -l'
alias lr='ls -R'
alias lsd='ls -d */'

# rm {{{1

# https://unix.stackexchange.com/questions/46535/can-i-make-rm-interactive-only-when-using-globbing-in-either-bash-or-zsh-or

alias rm='noglob rm'
function rm() {
  [[ "$*" = *[*[?]* ]] && set -- -i "$@"
  command rm $~@
}

# cp/mv/ln {{{1
alias cr='cp -r'

alias zmv='noglob zmv -W'
alias zcp='noglob zmv -W -p cp'
alias zln='noglob zmv -W -p ln'

# grep/head/less {{{1

export LESS="-RFX"

alias -g G=' | grep'
alias -g V=' | grep -v'
alias -g H=' | head'
alias -g L=' | less'

# I use this to limit the output from `rustc`.  It might be useful for other 
# compilers too.
alias -g HC50='--color=always 2>&1 | head -n50'
alias -g LC='--color=always 2>&1 | less'


# find {{{1
function findn () {
  if [ $# -eq 1 ]; then
    FIND_DIR=.
    FIND_NAME=$1
  elif [ $# -eq 2 ]; then
    FIND_DIR=$1
    FIND_NAME=$2
  fi

  find $FIND_DIR -name "*$FIND_NAME*"
}

# fzf {{{1
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d"
source <(fzf --zsh)

bindkey '\Cx' fzf-cd-widget

# date {{{1
alias date='\date +"%A, %B %-d%n%-I:%M %p"'
alias ymd='\date +"%Y%m%d"'

# ping {{{1
alias pg='ping google.com'
alias pa='ping archlinux.org'

# misc {{{1
alias top='\top -u $USER'
alias topall='\top'
alias which='/bin/which'
alias where='whereis'
alias len='wc -c'

# vim {{{1
export EDITOR=vim

alias v=vim
alias vi=vim

# I have a tendency to accidentally type these vim commands into the shell,
# and I don't like seeing the "command not found" errors that result.

alias :w=true
alias :q=true
alias :wq=true

# git {{{1

alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias grs='git restore'
alias gc='git commit'
alias gce='git commit -F $(git root)/.git/COMMIT_EDITMSG -e'
alias gc!='git commit --amend --no-edit'
alias gl='git log'
alias glo='git log --oneline --decorate'
alias gk='git checkout'
alias gp='git pull'
alias gpu='git pull && git push'
alias gpup='git pull && git push && sleep 300 && git pull'
alias gu='git push'
alias guf!='git push --force'

function gda () {
  git diff $1

  read "REPLY?Add $1 [Y/p/n]: "
  if [[ $REPLY =~ '^[Yy]?$' ]]; then
    echo "git add $1"
    git add $1
  elif [[ $REPLY =~ '^[Pp]$' ]]; then
    git add -p $1
  else
    echo "abort"
  fi
}

# https://stackoverflow.com/questions/19439333/how-do-you-use-an-existing-completion-for-a-function-in-zsh
compdef _git gda=git-add

# gpg {{{1

# From `man gpg-agent`:
#   You should always add the following lines to your .bashrc or whatever
#   initialization file is used for all shell invocations:

#     GPG_TTY=$(tty)
#     export GPG_TTY
#
#   It is important that this environment variable always reflects the output
#   of the tty command.

export GPG_TTY=$(tty)

# python {{{1
export PYTHONSTARTUP=~/.pythonrc

alias py=python3
alias py2=python2
alias py3=python3

alias ruff='ruff check'

alias py-exec-prefix='python -c "import sys; print(sys.exec_prefix)"'
alias py-site-packages='python -c "import sysconfig; print(sysconfig.get_paths()[\"purelib\"])"'

export fpath=("$(py-site-packages)/argcomplete/bash_completion.d" $fpath)

imports="from math import *"

function px () {
    python3 -c "$imports; $*"
}

function pxp () {
    python3 -c "$imports; print($*)"
}

function pxh () {
    python3 -c "$imports; help($1)"
}

alias px="noglob px"
alias pxp="noglob pxp"
alias pxh="noglob pxh"

# c/c++ {{{1
export CC=$(which clang)
export CXX=$(which clang++)

# java {{{1
alias ja='java -ea'
alias jc='javac -g'
alias ju='java org.junit.runner.JUnitCore'

# R {{{1
alias R='R --no-save'

# make {{{1
alias ,ale=make
alias make!='make clean && make'

# ninja {{{1
export NINJA_STATUS="[%f/%t] [-j%r] "

# nextflow {{{1
alias nf=nextflow

# duckdb {{{1
alias duckdb='duckdb -readonly'
alias duckdb!='\duckdb'

