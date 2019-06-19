" vim-plugin section
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Plugins
Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1

Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='base16color'

" Initialize plugin system
call plug#end()
