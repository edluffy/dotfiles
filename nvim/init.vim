call plug#begin()

Plug 'drewtempelmeyer/palenight.vim'

Plug 'vim-airline/vim-airline'
Plug 'edkolev/tmuxline.vim'
Plug 'urbainvaes/vim-tmux-pilot'

Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-clangx'
Plug 'raimondi/delimitmate'

call plug#end()

let g:palenight_terminal_italics = 1
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('auto_complete', v:false)
call neomake#configure#automake('w')

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ deoplete#manual_complete()


syntax on
set termguicolors
colorscheme palenight
hi Normal guibg=None ctermbg=None

set number
set completeopt-=preview
set completeopt+=menuone

set lazyredraw
set synmaxcol=180

set autoindent
filetype plugin indent on
set clipboard+=unnamed
