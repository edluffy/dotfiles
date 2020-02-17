call plug#begin('~/.vim/plugged')

Plug 'rstacruz/vim-closer'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'edkolev/promptline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'christoomey/vim-tmux-navigator'

Plug 'drewtempelmeyer/palenight.vim'

Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

colorscheme palenight
"let g:palenight_terminal_italics=1

let &t_ut=''
set termguicolors

syntax on
set wildmenu
set number
set cursorline
set autoindent
set backspace=indent,eol,start
set laststatus=2
filetype plugin indent on


map <F8> :w <CR> :!make program="%:r" && ./"%:h" <CR>
