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
let g:vimtex_complete_close_braces = 1

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

Plug 'ycm-core/YouCompleteMe'

" Initialize plugin system
call plug#end()

colorscheme gruvbox
set termguicolors
set guifont=Hack\ Nerd\ Font
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
set mouse=a
set tabstop=4 " the amount of spaces that one tab is worth
set softtabstop=4 " determines the amount of whitespace introduced by typing <tab>
set shiftwidth=4 " the amount of spaces used for indenting, i.e. when using > en <
set expandtab " expand tabs to spaces
set smarttab " whitespace at beginning of a line introduced by <tab> is shiftwidth instead of softtabstop
set autoindent
set breakindent
set breakindentopt=shift:2
set linebreak " wraps lines without inserting line breaks
set hidden " make buffers work better
set backspace=2 " make backspace work across lines
set number

" Enable italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

""" LaTeX commands

augroup tex_config
    autocmd!
    autocmd FileType tex let g:ycm_min_num_of_chars_for_completion=99
    if !exists('g:ycm_semantic_triggers')
        let g:ycm_semantic_triggers={}
    endif
    " semantic triggers are based on g:vimtex#re#youcompleteme, only the
    " completion for \ is removed
    autocmd VimEnter * let g:ycm_semantic_triggers.tex = [
        \ 're!\\(usepackage|RequirePackage|PassOptionsToPackage)(\s*\[[^]]*\])?\s*\{[^}]*',
        \ 're!\\documentclass(\s*\[[^]]*\])?\s*\{[^}]*',
        \ 're!\\begin(\s*\[[^]]*\])?\s*\{[^}]*',
        \ 're!\\end(\s*\[[^]]*\])?\s*\{[^}]*',
        \ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
        \ 're!\\(text|block)cquote\*?(\[[^]]*\]){0,2}{[^}]*',
        \ 're!\\(for|hy)[A-Za-z]*cquote\*?{[^}]*}(\[[^]]*\]){0,2}{[^}]*',
        \ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
        \ 're!\\hyperref\[[^]]*',
        \ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
        \ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
        \ 're!\\(include(only)?|input|subfile){[^}]*',
        \ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
        \ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
        \]
    autocmd User VimtexEventQuit call vimtex#compiler#clean(0)
augroup END
