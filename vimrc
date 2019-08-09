set nocompatible
let g:mapleader = " "
let g:maplocalleader = "," 

" vim-plugin section
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Plugins
Plug 'morhetz/gruvbox'

Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1

Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='gruvbox'

Plug 'lervag/vimtex'
let g:vimtex_compiler_latexmk = {
    \ 'continuous' : 0,
    \}

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

Plug 'ycm-core/YouCompleteMe'
let g:ycm_semantic_triggers = { 'tex' : ['re!\w{3}']}

" Initialize plugin system
call plug#end()
let g:tex_flavor = 'latex'
colorscheme gruvbox
filetype plugin indent on
set mouse=a
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set autoindent
set breakindent
set linebreak
set hidden
set backspace=2

""" LaTeX commands

"Script that cleans out tex auxiliary files when I close a tex-file
autocmd VimLeave *.tex !$(dirname $(greadlink -f $HOME/.vimrc))/scripts/texclear %
