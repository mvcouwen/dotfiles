# dotfiles

This repository contains configurations files for zsh and vim.

## Required packages

We use [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) to configure zsh.

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

Install one of the [nerd fonts](https://nerdfonts.com).

We use [powerlevel10k](https://github.com/romkatv/powerlevel10k) as a theme in oh-my-zsh.
```sh
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
```

Install [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) as a plugin for oh-my-zsh.
```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

We manage our vim plugins with [vim-plug](https://github.com/junegunn/vim-plug).
```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Install a the homebrew version of vim for python support.
```sh
brew install vim
```

Install node and the latest stable nodejs (needed for coc.nvim).
```sh
brew install node
curl -sL install-node.now.sh | sh
```

## Installation

Download this repository in ~/.dotfiles.
```sh
git clone https://github.com/mvcouwen/dotfiles.git ~/.dotfiles
```

Make the necessary symbolic links.
```sh
ln -s ~/.dotfiles/zshrc ~/.zshrc
ln -s ~/.dotfiles/vimrc ~/.vimrc
```

Install the necessary vim plugins. Reload vim and run the following code.
```vim
:PlugInstall
```
