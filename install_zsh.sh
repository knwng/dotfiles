#!/bin/bash

set -euxo pipefail

sudo apt-get install -y zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

ZSH_CUSTOM=${HOME}/.oh-my-zsh/custom

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

echo "[[ -s /root/.autojump/etc/profile.d/autojump.sh ]] && source /root/.autojump/etc/profile.d/autojump.sh" >> ~/.zshrc
echo "autoload -U compinit && compinit -u" >> ~/.zshrc

