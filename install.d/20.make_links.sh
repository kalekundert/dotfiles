#!/usr/bin/env sh

# Link the configure script so that the shells know where to find it.

ln -nsf $SCRIPT_DIR/configure.sh ~/.zshrc
ln -nsf $SCRIPT_DIR/configure.sh ~/.bashrc
ln -nsf $SCRIPT_DIR/configure.sh ~/.bash_profile

# Tell programs where various kinds of media should be downloaded.

if [ $EUID -ne 0 ]; then
    mkdir -p ~/.config
    mkdir -p ~/.config/sakura

    ln -nsf $INSTALL_DIR/resources/cookiecutterrc ~/.cookiecutterrc
    ln -nsf $INSTALL_DIR/resources/gitignore ~/.gitignore
    ln -nsf $INSTALL_DIR/resources/inputrc ~/.inputrc
    ln -nsf $INSTALL_DIR/resources/pypirc ~/.pypirc
    ln -nsf $INSTALL_DIR/resources/sakura.conf ~/.config/sakura/
    ln -nsf $INSTALL_DIR/resources/user-dirs.dirs ~/.config/
    ln -nsf $INSTALL_DIR/resources/user-dirs.locale ~/.config/
fi
