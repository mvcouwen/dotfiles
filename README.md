# dotfiles

This repository contains configurations files for zsh and vim.

## Required packages

We use [prezto](https://github.com/sorin-ionesco/prezto) to configure zsh.
```sh
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
```

Install one of the [nerd fonts](https://nerdfonts.com).

We manage our vim plugins with [vim-plug](https://github.com/junegunn/vim-plug).
```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Install neovim.
```sh
brew install neovim
```

Install node (needed for coc.nvim).
```sh
brew install node
```

Make sure you use a terminal emulator that supports true color, e.g. iTerm2.
```sh
brew cask install iterm2
```

## Installation

Download this repository in ~/.dotfiles.
```sh
git clone https://github.com/mvcouwen/dotfiles.git ~/.dotfiles
```

Make the necessary symbolic links.
```sh
ln -s ~/.dotfiles/zshrc ~/.zshrc
ln -s ~/.dotfiles/zpreztorc ~/.zpreztorc
ln -s ~/.dotfiles/vimrc ~/.vimrc
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
mkdir -p ~/.config/nvim
ln -s ~/.dotfiles/init.vim ~/.config/nvim/init.vim
```

Install the necessary vim plugins. Reload vim and run the following code.
```vim
:PlugInstall
```

Install Charles Campbell's amsmath vimball for better highlighting in tex-files when using the amsmath package.
```sh
vim http://www.drchip.org/astronaut/vim/vbafiles/amsmath.vba.gz
```
Then run the following in vim.
```vim
:UseVimball
```
Press enter and quit vim afterwards.
