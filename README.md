# dotfiles

This repository contains my personal configurations files. The main goal of this repository is for my own use. I like to keep my configuration consistent across my devices.

A lot of inspiration for these dotfiles, came from similar repositories. Hopefully they can also be of inspiration to you. Feel free to fork this repository and customize to your liking. If you have any suggestions or cool ideas, please let me know.

The general principle of these dotfiles is to keep it simple. I only add things I use and I understand. I opt for dependencies that do one thing very well rather than full blown solutions.

# Installation

I have written an install script that does the following things automatically.
1. Install [Homebrew](https://brew.sh).
2. Install some dependencies using `brew bundle`.
3. Compile terminfo for tmux.
4. Link the dotfiles in the correct place (backing up any configuration files already present).
5. Telling iTerm2 to sync its preferences with the plist in this repository.

It shouldn't be too hard to customize this install script. I definitely recommend looking at the Brewfile to specify the dependencies that you want to install using Homebrew.

You run the install script by executing the following command.

```
./install.sh
```

## neovim

In order to install the neovim plugins, run `:PackerSync` inside neovim.

# Configuration

## Brewfile

The Brewfile lists the dependencies that I can't live without and that I want to have on all my devices. Running `brew bundle` installs these dependencies. I suggest you write your own Brewfile. You can find more information on the [hombrew-bundle](https://github.com/Homebrew/homebrew-bundle) repository.

## iTerm2

I use [iTerm2](https://iterm2.com) as my main terminal emulator on macos. I sync my preferences by using the built in iTerm2 feature to load its configuration from a custom folder. The install script specifies this folder in the iTerm2 preferences.

## neovim

[Vim](https://www.vim.org) and by extension [neovim](https://neovim.io) are amazing text editors. Once you get used to the vim-way of doing stuff, you never want to look back. I choose neovim over vim mostly for the builtin lsp support and because I want to support the project. They've done some amazing things with (neo)vim over the past few years.

I've migrated all my neovim configuration files to lua and use [packer.nvim](https://github.com/wbthomason/packer.nvim) as my plugin manager. I only add plugins that I actually use. Many thanks for the amazing work that the developers of the following plugins did.

- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [ellisonleao/gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim)
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)
- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- [jose-elias-alvarez/null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)
- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim)
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)

## tmux

I use [tmux](https://github.com/tmux/tmux/wiki) to easily manage and switch between multiple terminal windows. The key bindings of [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) also allow to easily switch between vim and terminal windows.

## vim

Even though I almost always use neovim instead of neovim, I've kept (a part) of my vimrc for cases where I don't have neovim at my disposal. However, since I don't spent much time in vim, I don't touch the configuration that often.

## zsh

The shell that I use in my terminal is [zsh](https://www.zsh.org). The most popular customization framework for zsh is definitely [oh-my-zsh](https://ohmyz.sh). The project is backed by an amazing community and I recommend it to everyone who wants cool customization without having to configure everything yourself. Since I like to keep things simple and I don't need all the features that oh-my-zsh adds, I don't use the framework but only use a few more minimal plugins. I simply install the following plugins using Homebrew.

- [zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [sindresorhus/pure](https://github.com/sindresorhus/pure)
