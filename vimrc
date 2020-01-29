set nocompatible
let g:mapleader = "\<space>"
let g:maplocalleader = ","

" vim-plugin section
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Plugins
Plug 'morhetz/gruvbox'

Plug 'itchyny/lightline.vim'
set laststatus=2
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
    \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
    \ }

" let g:airline_powerline_fonts = 1

" Plug 'vim-airline/vim-airline-themes'
" let g:airline_theme='gruvbox'

Plug 'lervag/vimtex'
let g:tex_flavor = 'latex'
let g:vimtex_compiler_latexmk = {
    \ 'continuous' : 0,
    \ }
let g:vimtex_complete_enabled = 0
let g:vimtex_view_method = 'skim'

Plug 'honza/vim-snippets'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'PetRUShka/vim-magma'

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

" Settings for coc.nvim
set cmdheight=2 "two lines for under statusline
set updatetime=500 "time vim waits before triggering plugin, standard 4000, too low can lead to highlighting glitches.
set signcolumn=yes "sign column left of line numbers

" The following function checks whether the cursor is at the beginning of a
" line or the previous character is a space.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Implement the use of the TAB-key.
" If pum is visible, then complete.
" If not but inside jumpable snippet, go to next placeholder.
" If none of the above but after a space or at the beginning of a line, insert
" a <TAB> character.
" Otherwise, make pum visible.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#jumpable() ? "\<C-r>=coc#rpc#request('snippetNext',[])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <silent><expr> <S-TAB>
    \ pumvisible() ? "\<C-p>" :
    \ coc#jumpable() ? "\<C-r>=coc#rpc#request('snippetPrev',[])\<CR>" :
    \ "\<C-h>"

" Use TAB to put the selected text into the visual placeholder
vmap <TAB> <Plug>(coc-snippets-select)

" Use <cr> to confirm completion. '<C-g>u' means break undo chain at current
" position.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


" don't give |ins-completion-menu| messages.
" set shortmess+=c

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <leader>e :<C-u>CocList --normal diagnostics<cr>
" Jump to next diagnostic
nmap <silent> <leader>j <Plug>(coc-diagnostic-next)
" Jump to previous diagnostic
nmap <silent> <leader>k <Plug>(coc-diagnostic-prev)

" Build file (define <Plug>(build) based on filetype)
nmap <buffer><silent> <leader>b <plug>(build)

let g:coc_global_extensions = ['coc-snippets','coc-texlab']
let g:coc_user_config = {
    \ 'latex.build.args': ["-pdf","-pv","-synctex=1"],
    \ 'latex.forwardSearch.executable': '/Applications/Skim.app/Contents/SharedSupport/displayline',
    \ 'latex.forwardSearch.args': ["%l", "%p", "%f"]
    \ }

" Enable italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

""" LaTeX commands

augroup tex_config
    autocmd!
    autocmd User VimtexEventQuit call vimtex#compiler#clean(0)
    autocmd FileType tex nnoremap <buffer><silent> <Plug>(build) :CocCommand latex.Build<CR>
    autocmd FileType tex nnoremap <buffer><silent> <leader>v :CocCommand latex.ForwardSearch<CR>
augroup END

""" Magma commands
autocmd BufEnter *.m :setlocal filetype=magma

