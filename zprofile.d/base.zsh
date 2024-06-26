export path=($HOME/.dotfiles/bin $HOME/.local/bin $path)

# The main reason for setting up `pyenv` in `.zprofile` is to ensure
# that the python environment is completely sane and ready to use by
# the time `.zshrc` is invoked.  This setup does modify $PATH, but it
# does so in an idempotent way, so that's not a reason why it has to
# happen in `.zprofile`.
eval "$(pyenv init -)"

