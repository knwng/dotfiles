#!/bin/bash

set -euxo pipefail

cat host_shell_functions.sh >> ~/.bashrc

cp vimrc ~/.vimrc
cp tmux.conf ~/.tmux.conf

