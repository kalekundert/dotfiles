SRC=~/.dotfiles

git submodule init
git submodule update --recursive

mkdir -p ~/.zprofile.d
ln -sf $SRC/zprofile ~/.zprofile
ln -sf $SRC/zprofile.d/base.zsh ~/.zprofile.d/50-base.zsh

mkdir -p ~/.zshrc.d
ln -sf $SRC/zshrc ~/.zshrc
ln -sf $SRC/zshrc.d/base.zsh ~/.zshrc.d/50-base.zsh

mkdir -p ~/.vim
mkdir -p ~/.vim/spell
ln -sf $SRC/vim/after ~/.vim
ln -sf $SRC/vim/colors ~/.vim
ln -sf $SRC/vim/ftplugin ~/.vim
ln -sf $SRC/vim/indent ~/.vim
ln -sf $SRC/vimrc ~/.vimrc
ln -sf $SRC/vim/spell/en.utf-8.add ~/.vim/spell
ln -sf $SRC/vim/syntax ~/.vim
ln -sf $SRC/vim/templates ~/.vim

ln -sf $SRC/cookiecutterrc ~/.cookiecutterrc
ln -sf $SRC/gitignore ~/.gitignore
ln -sf $SRC/gitconfig ~/.gitconfig
ln -sf $SRC/inputrc ~/.inputrc
ln -sf $SRC/pythonrc ~/.pythonrc
