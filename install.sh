#!/bin/bash

needed_packages="git nvim tmux fd ripgrep lazygit"
recommenedd="kitty ttf-jetbrains-mono-nerd"
config="https://github.com/REAPERali00/Nvim.git"

function pac_install() {
  sudo pacman -S "$needed_packages"
  sudo pacman -S "$recommenedd"
}

if command -v pacman >/dev/null; then
  pac_install
else
  echo "pacage manager not found"
  exit 1
fi

mkdir -p $HOME/.config/nvim
git clone "$config" $HOME/.config/nvim
