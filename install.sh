#!/bin/zsh

####################
# Install Homebrew #
####################

echo "Installing Homebrew..."
#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

############
# Dotfiles #
############

echo "Linking dotfiles..."

cd $(dirname $0)
echo $(pwd)

local date=$(date +%Y%m%d)

declare -A dotfiles
dotfiles=(
    [~/.zshrc]="$(pwd)/zsh/zshrc"
    [~/.vimrc]="$(pwd)/vim/vimrc"
    [~/.config/nvim/init.vim]="$(pwd)/vim/init.vim"
    [~/.config/nvim/coc-settings.json]="$(pwd)/vim/coc-settings.json"
)

for key val in ${(@kv)dotfiles}; do
    [ -e $key ] && [ ! -L $key ] && mv $key ${key}.backup.${date}
    [ -L $key ] && unlink $key
    mkdir -p $(dirname $key)
    ln -s $val $key
done
