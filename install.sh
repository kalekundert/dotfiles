SRC=~/.dotfiles

git submodule init
git submodule update --recursive

mkdir -p ~/.zprofile.d
ln -sf $SRC/zprofile ~/.zprofile
ln -sf $SRC/zprofile.d/base.zsh ~/.zprofile.d/50-base.zsh

mkdir -p ~/.zshrc.d
ln -sf $SRC/zshrc ~/.zshrc
ln -sf $SRC/zshrc.d/base.zsh ~/.zshrc.d/50-base.zsh

ln -sf $SRC/cookiecutterrc ~/.cookiecutterrc
ln -sf $SRC/gitignore ~/.gitignore
ln -sf $SRC/gitconfig ~/.gitconfig
ln -sf $SRC/inputrc ~/.inputrc
ln -sf $SRC/pythonrc ~/.pythonrc
