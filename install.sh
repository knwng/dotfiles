#!/bin/bash

cp vimrc ~/.vimrc
cp tmux.conf ~/.tmux.conf

if [[ ! -e ~/.zshrc ]]; then
    echo 'Installing zsh...'
    ./install_zsh.sh
fi

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
