runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

syntax on
colorscheme palenight
hi Normal guibg=NONE ctermbg=NONE

let g:palenight_terminal_italics=1
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

let &t_ut=''
set termguicolors

set lazyredraw
set number
set autoindent

set undodir=~/.vim/undodir
set undofile

set clipboard+=unnamed

map <F8> :w <CR> :!make program="%:r" && ./"%:h" <CR>
