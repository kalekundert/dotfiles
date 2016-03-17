if [ -z "$PATH_CONFIGURED" ]; then
    export PATH_CONFIGURED='yes'
    export PATH="/bin:/usr/bin:/usr/local/bin:/usr/local/sbin:/usr/sbin"
    if [ -d ~/.local/bin ]; then
        for SUBDIR in ~/.local/bin ~/.local/bin/*; do
            if [[ -d $SUBDIR ]]; then
                export PATH=$SUBDIR:$PATH
            fi
        done
    fi
    export PATH="$HOME/.shell/scripts:$PATH"
    export MANPATH="$MANPATH:$HOME/.local/man:$HOME/.local/share/man"
fi

export EDITOR=vim
export BROWSER=firefox

export OPENBOX_TERMINAL=sakura
export OPENBOX_EDITOR=gvim
export OPENBOX_BROWSER=firefox
export OPENBOX_EMAIL=thunderbird

eval $(dircolors ~/.shell/configure.d/resources/colors.ls)

export PYTHONPATH=~/research/software/third_party/imp/build/lib
export CLASSPATH=.:./bin/:usr/share/java:/home/kale/hacking/third_party:/home/kale/hacking/projects/android-sdk/tools
export TEXINPUTS=~/hacking/config/latex:
export BSTINPUTS=~/hacking/config/latex:

export AUTOSSH_PORT=21109
export AUTOSSH_POLL=5
export AUTOSSH_PIDFILE=~/.ssh/autossh.pid

export GPG_TTY=`tty`
