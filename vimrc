runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

syntax on
colorscheme palenight

let g:palenight_terminal_italics=1
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

if$SSH_CONNECTION
	highlight! Normal guibg=#15161F
endif

let &t_ut=''
set termguicolors

set number
set cursorline

map <F8> :w <CR> :!make program="%:r" && ./"%:h" <CR>
