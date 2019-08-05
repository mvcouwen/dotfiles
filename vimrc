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
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Initialize plugin system
call plug#end()

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

""" LaTeX commands

"Script that cleans out tex auxiliary files when I close a tex-file
autocmd VimLeave *.tex !$(dirname $(greadlink -f $HOME/.vimrc))/scripts/texclear %
