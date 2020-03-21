call plug#begin('~/.config/nvim/plugged')

Plug 'drewtempelmeyer/palenight.vim'

Plug 'vim-airline/vim-airline'
Plug 'edkolev/tmuxline.vim'
Plug 'mhinz/vim-signify'
Plug 'sheerun/vim-polyglot'

Plug 'neomake/neomake'
"Plug 'dense-analysis/ale'
"Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'Shougo/deoplete-clangx'

call plug#end()

let g:deoplete#enable_at_startup = 1
let g:palenight_terminal_italics=1

syntax on
set termguicolors
colorscheme palenight
hi Normal guibg=None ctermbg=None

set number

set lazyredraw

set autoindent
filetype plugin indent on
set clipboard+=unnamed
