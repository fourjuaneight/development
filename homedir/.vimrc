"""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""

" change the mapleader from \ to SPC
let mapleader=" "

set timeoutlen=1000 ttimeoutlen=0

" encoding
set encoding=utf-8
set fileencoding=utf-8

syntax on                       " Enable syntax highlight

set foldmethod=manual           " manual folding
set mouse=a                     " when copying, keeping the line numbers out
set number                      " show line numbers
set scrolloff=2                 " context lines above and below the cursor
set showcmd                     " see commands as you type them
set autowrite                   " Automatically :write before running commands

" Show white spaces as a character
set list
set listchars=tab:··,trail:·
set listchars=eol:·,tab:··,trail:·,extends:·,precedes:·

set hlsearch                    " highlight search terms
set ic                          " ignore case
set incsearch                   " show search matches as you type

" tab is two spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2 noexpandtab

" Open new split panes to right and bottom; more natural
set splitbelow
set splitright

" no backup files written on save
set nobackup
set noswapfile
set nowritebackup

" Always use vertical diffs
if &diff
    set diffopt-=internal
    set diffopt+=vertical
endif

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

filetype plugin indent on        " indentation

" italic comments on terminal and gui
highlight Comment cterm=italic gui=italic

" theme
packadd! dracula_pro
let g:dracula_colorterm = 0
colorscheme dracula_pro_van_helsing

" Ignored files/directories from autocomplete (and CtrlP)
set wildignore+=*/tmp/*
set wildignore+=*.so
set wildignore+=*.zip
set wildignore+=*/vendor/bundle/*
set wildignore+=*/node_modules/

"""""""""""""""""""""""""""""""""""""""""""""""
" Key Remaps
"""""""""""""""""""""""""""""""""""""""""""""""
" quit
noremap <leader>q :q<cr>

" force quit
noremap <leader>q! :q!<cr>

" write
noremap <leader>s :w<cr>

" write and quit
noremap <leader>sq ZZ<cr>

" write and force quit
noremap <leader>sq! :wq!<cr>

" copy selection to system clipboard
vnoremap <leader>by "+y

" window navigation
nmap <leader>wj <C-w>j
nmap <leader>wk <C-w>k
nmap <leader>wh <C-w>h
nmap <leader>wl <C-w>l

" delete all empty lines
map <leader>dln :g/^$/d

" tabs
map <leader>tn :bn<cr>
map <leader>tp :bp<cr>
map <leader>td :bd<cr>
