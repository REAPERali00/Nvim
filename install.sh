#!/bin/bash

needed_packages="git nvim tmux fd ripgrep lazygit"
recommenedd="kitty "
config="git clone https://github.com/REAPERali00/Nvim.git ~/.config/nvim"

pac_install() {

}

if command -v pacman >/dev/null; then
  pac_install
else
  echo "pacage manager not found"
  exit 1
fi
