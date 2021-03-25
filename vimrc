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
set showtabline=1
set noshowmode

Plug 'itchyny/vim-gitbranch'

Plug 'lervag/vimtex'
let g:tex_flavor = 'latex'
let g:vimtex_compiler_latexmk = {
    \ 'continuous' : 0,
    \ }
let g:vimtex_complete_enabled = v:false
let g:vimtex_view_method = 'skim'

Plug 'honza/vim-snippets'

Plug 'neoclide/coc.nvim'

Plug 'airblade/vim-gitgutter'

Plug 'christoomey/vim-tmux-navigator'

Plug 'benmills/vimux'

" Initialize plugin system
call plug#end()

if $COLORTERM == "truecolor" || $COLORTERM == "24bit"
    set termguicolors
endif
set background=dark
colorscheme gruvbox
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

" netrw settings
let g:netrw_liststyle=3
let g:netrw_banner=0
nnoremap <silent> <leader>nn :<c-u>Hexplore<cr>
nnoremap <silent> <leader>nv :<c-u>Vexplore!<cr>
nnoremap <silent> <leader>nt :<c-u>Texplore<cr>

" Lightline configuration
let g:lightline = {
    \ 'enable': {'statusline': 1, 'tabline': 1},
    \ 'colorscheme': 'gruvbox',
    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
    \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
    \ 'component_function': {
    \   'coc_diagnostics' : 'LightlineCocDiagnostics',
    \   'gitinfo' : 'GitInfo',
    \ },
    \ 'active': {
    \   'left': [   ['mode', 'paste' ],
    \               ['gitinfo', 'readonly', 'filename', 'modified'],
    \               [] ],
    \   'right': [  ['lineinfo'],
    \               ['percent'],
    \               ['fileformat', 'fileencoding', 'filetype'] ]
    \ },
    \ 'tabline': {'right': [[]]},
    \ 'tabline_separator': {'left':"\ue0b0",'right':''},
    \ 'tabline_subseparator': {'left':'\ue0b1','right':''}
    \ }

function! GitInfo() abort
    let branchname = gitbranch#name()
    let [a,m,r] = GitGutterGetHunkSummary()
    if empty(branchname)
        return ''
    else
        return printf('%s +%d ~%d -%d',branchname,a,m,r)
    endif
endfunction

function! LightlineCocDiagnostics() abort
    let info = get(b:, 'coc_diagnostic_info',0)
    if empty(info)
        return ''
    endif
    if get(info, 'error', 0) == 0
        let error = ''
    else
        let error = printf('%s %d',"",info['error'])
    endif
    if get(info, 'warning', 0) == 0
        let warning = ''
    else
        let warning = printf('%s %d',"",info['warning'])
    endif
    return printf('%s %s',error,warning)
endfunction
    
autocmd User CocDiagnosticChange call lightline#update()

" Define lightline colorscheme
" This is heavily based on the lightline colorscheme from
" https://github.com/morhetz/gruvbox
function! s:getGruvColor(group)
  let guiColor = synIDattr(hlID(a:group), "fg", "gui") 
  let termColor = synIDattr(hlID(a:group), "fg", "cterm") 
  return [ guiColor, termColor ]
endfunction

let s:bg0 = s:getGruvColor('GruvboxBg0')
let s:bg1 = s:getGruvColor('GruvboxBg1')
let s:bg2 = s:getGruvColor('GruvboxBg2')
let s:bg3 = s:getGruvColor('GruvboxBg3')
let s:bg4 = s:getGruvColor('GruvboxBg4')
let s:fg1 = s:getGruvColor('GruvboxFg1')
let s:fg4 = s:getGruvColor('GruvboxFg4')

let s:yellow = s:getGruvColor('GruvboxYellow')
let s:purple = s:getGruvColor('GruvboxPurple')
let s:aqua = s:getGruvColor('GruvboxAqua')
let s:red = s:getGruvColor('GruvboxRed')
let s:green = s:getGruvColor('GruvboxGreen')
let s:orange= s:getGruvColor('GruvboxOrange')
let s:blue= s:getGruvColor('GruvboxBlue')

let s:p = {'normal':{}, 'inactive':{}, 'command':{}, 'insert':{}, 'replace':{}, 'visual':{}, 'tabline':{}, 'terminal':{}}
let s:p.normal.left = [ [ s:bg0, s:aqua, 'bold' ], [ s:fg4, s:bg2 ] ]
let s:p.normal.right = [ [ s:bg0, s:aqua ], [ s:fg4, s:bg2 ] ]
let s:p.normal.middle = [ [ s:fg4, s:bg1 ] ]
let s:p.inactive.right = [ [ s:bg4, s:bg1 ], [ s:bg4, s:bg1 ] ]
let s:p.inactive.left =  [ [ s:bg4, s:bg1 ], [ s:bg4, s:bg1 ] ]
let s:p.inactive.middle = [ [ s:bg4, s:bg1 ] ]
let s:p.command.left = [ [ s:bg0, s:blue, 'bold' ], [ s:fg1, s:bg3 ] ]
let s:p.command.right = [ [ s:bg0, s:blue], [ s:fg1, s:bg3 ] ]
let s:p.command.middle = [ [ s:fg4, s:bg2 ] ]
let s:p.insert.left = [ [ s:bg0, s:green, 'bold' ], [ s:fg1, s:bg3 ] ]
let s:p.insert.right = [ [ s:bg0, s:green ], [ s:fg1, s:bg3 ] ]
let s:p.insert.middle = [ [ s:fg4, s:bg2 ] ]
let s:p.terminal.left = [ [ s:bg0, s:purple, 'bold' ], [ s:fg1, s:bg3 ] ]
let s:p.terminal.right = [ [ s:bg0, s:purple], [ s:fg1, s:bg3 ] ]
let s:p.terminal.middle = [ [ s:fg4, s:bg2 ] ]
let s:p.replace.left = [ [ s:bg0, s:red, 'bold' ], [ s:fg1, s:bg3 ] ]
let s:p.replace.right = [ [ s:bg0, s:red], [ s:fg1, s:bg3 ] ]
let s:p.replace.middle = [ [ s:fg4, s:bg2 ] ]
let s:p.visual.left = [ [ s:bg0, s:yellow, 'bold' ], [ s:fg1, s:bg3 ] ]
let s:p.visual.right = [ [ s:bg0, s:yellow], [ s:fg1, s:bg3 ] ]
let s:p.visual.middle = [ [ s:fg4, s:bg2 ] ]
let s:p.tabline.left = [ [ s:fg4, s:bg2 ] ]
let s:p.tabline.tabsel = [ [ s:bg0, s:yellow ] ]
let s:p.tabline.middle = [ [ s:fg4, s:bg1 ] ]
let s:p.tabline.right = [ [ s:fg4, s:bg1 ] ]
let s:p.normal.error = [ [ s:bg0, s:red] ]
let s:p.normal.warning = [ [ s:bg0, s:orange] ]

let g:lightline#colorscheme#gruvbox#palette = lightline#colorscheme#flatten(s:p) "flatten makes pairs of pairs into quadruples

" Settings for coc.nvim
set cmdheight=1 "one line for under statusline
set updatetime=500 "time vim waits before triggering plugin, standard 4000, too low can lead to highlighting glitches.
set signcolumn=yes "sign column left of line numbers
set shortmess+=c "don't pass messages to ins-completion-menu, i.e. do not show `match n of m'

" Implement the use of the TAB-key.
" If inside jumpable snippet, go to next placeholder.
" If not, insert a <TAB> character.
inoremap <silent><expr> <TAB>
      \ coc#jumpable() ? "\<C-r>=coc#rpc#request('snippetNext',[])\<CR>" :
      \ "\<TAB>"

inoremap <silent><expr> <S-TAB>
    \ coc#jumpable() ? "\<C-r>=coc#rpc#request('snippetPrev',[])\<CR>" :
    \ "\<C-h>"

let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

" Use TAB to put the selected text into the visual placeholder
vmap <TAB> <plug>(coc-snippets-select)

" Use <cr> to confirm completion. '<C-g>u' means break undo chain at current
" position.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Remap keys for gotos
nmap <silent> gd <plug>(coc-definition)
nmap <silent> gy <plug>(coc-type-definition)
nmap <silent> gi <plug>(coc-implementation)
nmap <silent> gr <plug>(coc-references)

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
nmap <leader>rn <plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <plug>(coc-format-selected)
nmap <leader>f  <plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <plug>(coc-codeaction-selected)
nmap <leader>a  <plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <plug>(coc-funcobj-i)
xmap af <plug>(coc-funcobj-a)
omap if <plug>(coc-funcobj-i)
omap af <plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <plug>(coc-range-select)
xmap <silent> <C-d> <plug>(coc-range-select)

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
nmap <silent> <leader>j <plug>(coc-diagnostic-next)
" Jump to previous diagnostic
nmap <silent> <leader>k <plug>(coc-diagnostic-prev)

" Build file (define <plug>(build) based on filetype)
nmap <leader>b <plug>(build)

" Execute (define <plug>(execute) based on filetype)
nmap <leader>x <plug>(execute)
vmap <leader>x <plug>(execute)

" View output (define <plug>(view) based on filetype)
nmap <leader>v <plug>(view)

let g:coc_global_extensions = ["coc-snippets","coc-texlab","coc-python","coc-java"]

" Enable italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

""" LaTeX commands

augroup tex_config
    autocmd!
    autocmd User VimtexEventQuit call vimtex#compiler#clean(0)
    autocmd FileType tex nnoremap <buffer><silent> <plug>(build) :CocCommand latex.Build<CR>
    autocmd FileType tex nnoremap <buffer><silent> <plug>(view) :CocCommand latex.ForwardSearch<CR>
augroup END

""" Python commands

augroup python_config
    autocmd!
    autocmd FileType python nnoremap <buffer><silent> <plug>(execute) :CocCommand python.execInTerminal<CR>
    autocmd FileType python vnoremap <buffer><silent> <plug>(execute) :CocCommand python.execSelectionInTerminal<CR>
    autocmd FileType python nnoremap <buffer><silent> <plug>(view) :CocCommand python.viewOutput<CR>
augroup END

augroup java_config
    autocmd!
    autocmd FileType java nnoremap <buffer><silent> <plug>(execute) :call VimuxRunCommand("javac " . bufname("%") . " && " . "java " . expand("%:t:r"))<CR>
augroup END

""" Magma commands
autocmd BufEnter *.m :setlocal filetype=magma

