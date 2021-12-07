" non-compatible mode
set nocompatible

" relative line numbers
set number relativenumber

" Leader key
let mapleader=" "

execute pathogen#infect()
autocmd vimenter * NERDTree
" Key bindings
" Open new tab
map <leader>+ :tabnew<CR>
" Toggle spelling
map <leader>s :set spell!<CR>
" Easy navigate buffers with arrow keys
nmap <leader><Left> :bp<CR>
nmap <leader><Right> :bn<CR>
nmap <leader><Up> :buffers<CR>
nmap <leader><Down> :b
" Map double leader to fuzzy file finder
nmap <leader><leader> :FZF<CR>

" set tabs
set expandtab
set tabstop=4
set shiftwidth=4
set shiftround
set smarttab

" indention
set autoindent
set copyindent

" search
set ignorecase
set smartcase
set hlsearch
set incsearch
" esc to remove highlight after search
" nnoremap <esc> :noh<return><esc>
" use fuzzy finder
set rtp+=/usr/local/opt/fzf

" brackets
set showmatch

" highlighting
syntax on

" spell check
set spell spelllang=en_us

" set character encoding
set encoding=utf-8
set fileencoding=utf-8

" fix double-save problem (see https://superuser.com/questions/1543754/stop-entr-from-running-twice/1569733#1569733)
set backupcopy=yes

" fix ESC key delay
set timeoutlen=1000 ttimeoutlen=0

" colors scheme
colo pablo
" should help wit bgcolor but no effect
" let &t_ut=''
" set t_Co=256

" word wrap and line breaks - don't break words
set formatoptions=1
set linebreak

" set scrolloff so file over and under cursor is visible for a few lines
set scrolloff=6

" Auto remove trailing white space on save
autocmd BufWritePre * :%s/\s\+$//e

" Enable fzf
set rtp+=/usr/local/opt/fzf

" File type template .html
if has("autocmd")
    augroup templates
        autocmd BufNewFile *.html 0r ~/.vim/templates/skeleton.html
    augroup END
endif

" Auto install plug-ins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plug-ins
call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ollykel/v-vim'
Plug 'junegunn/fzf.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'arcticicestudio/nord-vim'
Plug 'dense-analysis/ale'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'maximbaz/lightline-ale'
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }

call plug#end()

" Activate Light line
set laststatus=2

if !has('gui_running')
      set t_Co=256
endif

let g:ale_linters = {
      \   'python': ['flake8', 'pylint'],
      \   'ruby': ['standardrb', 'rubocop'],
      \   'javascript': ['eslint'],
      \}

let g:ale_fixers = {
      \    'python': ['yapf'],
      \}

let g:lightline = {}

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }

let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ]] }


nmap <F10> :ALEFix<CR>
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 1
let g:ale_sign_error = '🔴'
let g:ale_sign_warning = '🔸'

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '✨ all good ✨' : printf(
    \   '😞 %dW %dE',
    \   all_non_errors,
    \   all_errors
    \)

endfunction

        set statusline=
        set statusline+=%m
        set statusline+=\ %f
        set statusline+=%=
        set statusline+=\ %{LinterStatus()}

packloadall
silent! helptags ALL
