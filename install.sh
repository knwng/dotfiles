#!/bin/bash

cp vimrc ~/.vimrc
cp tmux.conf ~/.tmux.conf

if [[ ! -e ~/.zshrc ]]; then
    ./install_zsh.sh
fi

cat zshrc >> ~/.zshrc

