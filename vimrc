execute pathogen#infect()
set termguicolors
colorscheme PaperColor
set background=dark
	
syntax on
set wildmenu
set number
set cursorline
set autoindent
set backspace=indent,eol,start
set laststatus=2
filetype plugin indent on

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

map <F8> :w <CR> :!gcc % && ./a.out <CR>
