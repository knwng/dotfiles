#!/bin/bash

USE_ZSH=$1

if [[ "$USE_ZSH" == "" ]]; then
    USE_SZH=true
fi

cp vimrc ~/.vimrc
cp tmux.conf ~/.tmux.conf

if $USE_ZSH; then
    if [[ ! -e ~/.zshrc ]]; then
        echo 'Installing zsh...'
        ./install_zsh.sh
    fi
    
    cp ~/.zshrc ~/.zshrc.bak
    cat zshrc >> ~/.zshrc
    
    if [[ ! -e ~/.local/bin/broot ]]; then
        echo 'Installing broot...'
        ROOT=$(pwd)
        mkdir -p ~/.local/bin
        cd ~/.local/bin
        wget https://dystroy.org/broot/download/x86_64-linux/broot
        chmod +x broot
        echo 'export PATH="${HOME}/.local/bin:${PATH}"' >> ~/.zshrc
        cd $ROOT
    fi
 fi

# Register functions
if $USE_ZSH; then
    cat shell_functions.sh >> ~/.zshrc
else
    cat shell_functions.sh >> ~/.bashrc
fi
