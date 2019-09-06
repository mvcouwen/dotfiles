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
let g:tex_flavor = 'latex'
let g:vimtex_compiler_latexmk = {
    \ 'continuous' : 0,
    \}
let g:vimtex_view_method = 'skim'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

Plug 'ycm-core/YouCompleteMe'

" Initialize plugin system
call plug#end()
colorscheme gruvbox
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
set mouse=a
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set autoindent
set breakindent
set breakindentopt=shift:2
set linebreak
set hidden
set backspace=2
set number

""" LaTeX commands

augroup tex_config
    autocmd!
    autocmd FileType tex let g:ycm_min_num_of_chars_for_completion=99
"    if !exists('g:ycm_semantic_triggers')
"        let g:ycm_semantic_triggers={}
"    endif
"    autocmd VimEnter * let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme
    autocmd User VimtexEventQuit call vimtex#compiler#clean(0) 
augroup END
