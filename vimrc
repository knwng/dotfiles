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
