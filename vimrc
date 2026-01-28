set laststatus=2
set number
set hlsearch
set incsearch
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set smarttab
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set nocompatible
set history=1000
filetype on
set completeopt=longest,menu
syntax enable
syntax on
set showmatch
set statusline=%F%m%r%h%w\[POS=%l,%v][%p%%]\%{strftime(\"%d/%m/%y\ -\ %H:%M\")}
set backspace=2
filetype plugin on
set omnifunc=syntaxcomplete#Complete
set ft=nasm
set ic

"Map Ctrl-w to <space>w to avoid conflict with Wezterm
let mapleader = " "
nnoremap <leader>wh <C-w>h
nnoremap <leader>wj <C-w>j
nnoremap <leader>wk <C-w>k
nnoremap <leader>wl <C-w>l
nnoremap <leader>wc <C-w>c
nnoremap <leader>wo <C-w>o
nnoremap <leader>wp <C-w>p
