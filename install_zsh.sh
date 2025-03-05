#!/bin/bash

set -euxo pipefail

sudo apt-get install -y zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

git clone https://github.com/wting/autojump.git
cd autojump && ./install.py && cd ..

# Add plugins to zshrc:
# plugins=(git zsh-autosuggestions zsh-syntax-highlighting autojump)

sudo apt-get install -y fonts-powerline
sudo apt-get install -y ttf-ancient-fonts
wget http://raw.github.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme -O $ZSH_CUSTOM/themes/bullet-train.zsh-theme

# Add these to zshrc:
#
# export TERM="xterm-256color"
# ZSH_THEME="bullet-train"

