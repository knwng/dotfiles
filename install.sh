#!/bin/bash

USE_ZSH=$1

if [[ "$USE_ZSH" == "" ]]; then
    USE_SZH=true
fi

fix_sudo_for_root() {
  local out rc

  out="$(sudo apt-get update 2>&1)"
  rc=$?

  if [ "$rc" -eq 0 ]; then
    echo "sudo apt-get update works; no fix needed."
    return 0
  fi

  if printf '%s' "$out" | grep -qi 'root is not in the sudoers file'; then
    echo "Detected: root is not in the sudoers file"
    echo "Applying sudoers fix..."

    apt-get update &&
    apt-get install -y sudo &&
    mkdir -p /etc/sudoers.d &&
    (
      grep -q '^#includedir /etc/sudoers.d' /etc/sudoers ||
      echo '#includedir /etc/sudoers.d' >> /etc/sudoers
    ) &&
    printf '%s\n' 'root ALL=(ALL:ALL) NOPASSWD:ALL' > /etc/sudoers.d/00-root &&
    chown root:root /etc/sudoers.d/00-root &&
    chmod 0440 /etc/sudoers.d/00-root &&
    visudo -c
    return $?
  fi

  echo "sudo apt-get update failed, but not due to the known root/sudoers issue."
  printf '%s\n' "$out" >&2
  return "$rc"
}

fix_sudo_for_root

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

# Switch to zsh so all changes take effect
if $USE_ZSH; then
    echo 'Switching to zsh...'
    exec zsh -l
fi
