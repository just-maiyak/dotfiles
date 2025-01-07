set nocompatible
set t_Co=256
set termguicolors
set nu
syntax enable
set nohlsearch
set ignorecase
set autoindent
set ts=4 sw=4 sts=4 et
set sr
set et
set sta
set ru
set encoding=utf-8
set fileencoding=utf-8
set tabstop=4 shiftwidth=4 expandtab
"set spell

" python env location
let g:python3_host_prog = $HOME . '/.local/nvimenv/venv/bin/python'

" move line map
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

nnoremap <C-h> :ALEPrevious<CR>==
nnoremap <C-l> :ALENext<CR>==

" tab maps
" nnoremap <C-h> :tabprevious<CR>
" nnoremap <C-l> :tabnext<CR>

" map <leader> to ,
let mapleader = ","

" close buffer not window mapping
map <leader>q :bp<bar>vsp<bar>bn<bar>bd<CR>

" nohl
nnoremap <silent><expr> <leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

" space folds
set foldmethod=syntax
" set foldnestmax=2
nnoremap <space> za
vnoremap <space> zf

" Black python format mapping
nnoremap <buffer><silent> <C-f> <cmd>call Black()<cr>

" set ripgrep as grpe tool
set grepprg=rg\ --vimgrep
set grepformat^=%f:%l:%c:%m

" vim-polyglot disable
let g:polyglot_disabled = ['elm']

call plug#begin('~/.config/nvim')
  " tools
  Plug 'jeffkreeftmeijer/vim-numbertoggle'
  Plug 'preservim/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'ryanoasis/vim-devicons'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'APZelos/blamer.nvim'
  "Plug 'FabijanZulj/blame.nvim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'tpope/vim-fugitive'
  Plug 'itchyny/vim-gitbranch'
  Plug 'jreybert/vimagit'
  Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
  Plug 'masukomi/vim-markdown-folding'
  Plug 'pedrohdz/vim-yaml-folds'
  Plug 'samuelstevens/vim-python-folding'
  Plug 'farmergreg/vim-lastplace'
  Plug 'sindrets/diffview.nvim'

  " themes and color schemes
  Plug 'itchyny/lightline.vim'
  Plug 'maximbaz/lightline-ale'
  Plug 'mengelbrecht/lightline-bufferline'
  Plug 'sainnhe/edge'
  Plug 'nvim-tree/nvim-web-devicons'
  " Plug 'vim-airline/vim-airline'
  " Plug 'vim-airline/vim-airline-themes'
  " Plug 'ajmwagar/vim-deus'

  " language syntax support
  Plug 'sheerun/vim-polyglot'
  Plug 'mattn/emmet-vim'
  Plug 'dart-lang/dart-vim-plugin'
  Plug 'neovimhaskell/haskell-vim'
  Plug 'cespare/vim-toml'
  Plug 'jtratner/vim-flavored-markdown'
  Plug 'vim-python/python-syntax'
  Plug 'fladson/vim-kitty'
  Plug 'hasufell/ghcup.vim'
  Plug 'gleam-lang/gleam.vim'
  Plug 'ElmCast/elm-vim'
  Plug 'averms/black-nvim', {'do': ':UpdateRemotePlugins'}
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " linting and LSP
  Plug 'dense-analysis/ale'
call plug#end()

" lightline options
set laststatus=2
set showtabline=2
set noshowmode
let g:lightline = {}
let g:lightline = {
      \ 'colorscheme': 'edge',
      \ 'active': {
      \   'left':  [ [ 'mode', 'paste' ],
      \              [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok', 'gitbranch', 'readonly', 'relativepath', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['bufnum'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers',
      \   'linter_checking': 'lightline#ale#checking',
      \   'linter_infos': 'lightline#ale#infos',
      \   'linter_warnings': 'lightline#ale#warnings',
      \   'linter_errors': 'lightline#ale#errors',
      \   'linter_ok': 'lightline#ale#ok',
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel',
      \   'linter_checking': 'right',
      \   'linter_infos': 'right',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_ok': 'right',
      \ }
      \ }
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = {'left': '', 'right': '' }
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos = "\uf129"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"

" vim-airline options
" let g:airline#extensions#tabline#enabled = 1
" let g:airline_powerline_fonts = 1
" let g:airline#extensions#coc#enabled = 1
" let g:airline_theme='edge'

" color scheme
set bg=dark
colorscheme edge
hi Normal guibg=NONE ctermbg=NONE
let t:is_transparent = 0

" vim-clap options
let g:clap_theme = 'edge'

" NERDTree keymaps
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

" blamer.nvim maps
nnoremap <C-b> :BlamerToggle<CR>

" NERDTree
let g:NERDTreeShowHidden = 1

" NERDTreeHl
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1

" LSP config
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'python': ['ruff', 'mypy'],
\}
let g:ale_linters_explicit = 1
let g:ale_fixers = { 
\   'python': ['ruff'],
\}
let g:ale_python_auto_pipenv = 1
