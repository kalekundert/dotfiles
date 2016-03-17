# General Utilities {{{1
# =================
alias edit_aliases='gvim ~/.shell/configure.d/40.aliases.sh'
alias xx='exec $SHELL'
alias xrc='source ~/.zshrc'
alias quit='exit'
alias xsu='exec su'
alias simon-says='sudo'
alias top='\top -u $USER'
alias topall='\top'
alias date='\date +"%A, %B %-d%n%-I:%M %p"'
alias which='/bin/which'
alias where='whereis'
alias len='wc -c'

alias pu='pushd'
alias po='popd'
alias back='cd ~-'
alias here='cd -P .'

alias network='fork wicd-client -n'
alias monitor='fork lxrandr'

alias yum='sudo dnf'
alias apt-get='sudo apt-get'
alias apt-cache='sudo apt-get'
alias virt-manager='sudo virt-manager'
alias reboot='sudo reboot'
alias shutdown='sudo shutdown now'
alias updatedb='sudo updatedb'
alias zzz='sudo pm-suspend'

# In some directories, I like to have more control over what 'ls' displays.  
# For example, sometimes I like to sort files alphabetically and sometimes I 
# like to sort them by file extension.  
#
# To get this behavior, I have 'ls' look for an '.lsrc' file before executing.  
# If such a file is found, then that file is executed in lieu of 'ls' itself.  
# Otherwise, 'ls' is run.  By default, a few file extensions are ignored.
#
# This is still a pretty rough implementation.  It's easy to get around (i.e.  
# by passing any arguments to 'ls') and the '.lsrc' files are hard to write.  I 
# might have to write a more involved python script to get around these issues.

function ls () {
    if [ $# -eq 1 ] && [ -e '.lsrc' ]; then
        ./.lsrc
    else
        /bin/ls $@                                                          \
            -X                                                              \
            --color                                                         \
            --group-directories-first                                       \
            --hide="*~"                                                     \
            --hide="*.o"                                                    \
            --hide="*.pyc"                                                  \
            --hide="\#*\#"                                                  \
            --hide="*.aux"                                                  \
            --hide="*.nlo"                                                  \
            --hide="*.bbl"                                                  \
            --hide="*.blg"                                                  \
            --hide="__pycache__"                                            \
            --hide="lost+found"                                             \
            --hide="*.egg-info"
    fi
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

alias cr='cp -r'

alias zmv='noglob zmv -W'
alias zcp='noglob zmv -W -p cp'
alias zln='noglob zmv -W -p ln'

# Vim {{{1
# ===
alias vi='vim'
alias m='gvim'
alias givm='gvim'
alias gvss='gvim +"set guifont=Monospace\ 18" +"set nospell"'

# I have a tendency to accidentally type these vim commands into the shell, and 
# I don't like seeing the "command not found" errors that result.

alias :w='true'
alias :q='true'
alias :wq='true'

# Git {{{1
# ===
alias ga='git add --all'
alias gc='git commit'
alias gca='git commit --all'
alias gb='git branch'
alias gk='git checkout'
alias gl='git log'
alias gm='git merge'
alias gd='git diff'
alias gp='git pull'
alias gu='git push'
alias gpu='git pull && git push'
alias wgs='watch git status'

# Make 'git status' seem to understand a directory argument.

function gs () {
    if [ -d "$1" ]; then
        cd $1; git status; cd ~- 
    else
        git status
    fi
}

# Python {{{1
# ======
alias py=python3
alias py2=python2
alias py3=python3
alias ipy='ipython3 --pylab'
alias ipy2='ipython2 --pylab'
alias ipy3='ipython3 --pylab'
alias ism=isympy3
alias ism2=isympy2
alias ism3=isympy3
alias pytest='py.test'
alias pytest2='py.test-2.7'
alias pytest3='py.test-3.4'

# Sometimes I want to run small snippets of python code without launching the 
# entire interpreter.  Usually this is either to do a bit of arithmetic (pxp) 
# or to get help on simple objects (pxh).

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

# Java {{{1
# ====
alias ja='java -ea'
alias jc='javac -g'
alias ju='java org.junit.runner.JUnitCore'

# Rosetta {{{1
# =======
alias rk='rdt_stub'
alias rb='rdt_build debug'
alias rr='rdt_build release'
alias ru='rdt_unit_test'
alias rd='rdt_doxygen'

# Other Applications {{{1
# ==================
alias abiword='fork abiword'
alias chemdraw='fork gchempaint'
alias dia='fork dia'
alias eog='fork eog'
alias exfalso='fork exfalso'
alias firefox='fork firefox'
alias gimp='fork gimp'
alias gnumeric='fork gnumeric'
alias gtkpod='fork gtkpod'
alias img='fork gpicview'
alias imagej='fork /home/kale/research/software/third_party/fiji/ImageJ-linux64'
alias libreoffice='fork libreoffice'
alias mendeley='fork /home/kale/research/software/projects/mendeley/bin/mendeleydesktop'
alias mysql-workbench='fork mysql-workbench'
alias pithos='fork pithos'
alias pyspread='fork pyspread'
alias qiv='fork qiv'
alias quodlibet='fork quodlibet'
alias rhythmbox='fork rhythmbox'
alias sakura='fork sakura'
alias scribus='fork scribus'
alias skype='fork skype'
alias snapgene='fork /opt/gslbiotech/snapgene/snapgene.sh'
alias snapgene-viewer='fork /opt/gslbiotech/snapgene-viewer/snapgene-viewer.sh'
alias sqliteman='fork sqliteman'
alias thunderbird='fork thunderbird'
alias vlc='fork vlc'
alias zotero='fork ~/hacking/third_party/zotero/run-zotero.sh'

# The 'pymol' alias doesn't launch the Tk menu that usually starts with pymol, 
# because it's ugly and I don't use it anyways.  Use the 'pymol-tk' alias if 
# that menu is desired.

alias pymol='fork pymol -qx'
alias pymol-tk='fork pymol -q'

# I need a function to alias two_cents so I can provide the -D option only if 
# no other arguments are specified.

function two_cents () {
    if [ $# = 0 ]; then
        command two_cents -D
    else
        command two_cents $@
    fi
}

# The zsh completion system doesn't seem to work very well on aliases.  Since I 
# have a custom completion script for evince, I had to write the 'fork' alias 
# as a shell function instead.  (I would have written it as a one-liner, but 
# that confuses bash.)

function zathura () {
    fork zathura $@
}

function evince () {
    fork evince $@
}

function inkscape () {
    fork inkscape $@
}

# If nautilus is not given an argument, run it on the current working directory 
# instead of the home directory.

function nautilus () {
    if [ $# -eq 0 ]; then
        fork nautilus .
    else
        fork nautilus
    fi
}

# SSH and Networking {{{1
# ==================
alias ssh-alanine-proxy='ssh -fND 1080 alanine-proxy'
alias ssh-guybrush-proxy='ssh -fND 1080 guybrush-proxy'

alias pg='ping google.com'
alias pk='ping kxgames.net'

