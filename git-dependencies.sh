#!/bin/sh
set -euo pipefail

# Init ---------------------------------------------------------
if [ "$(whoami)" = "root" ]; then
  echo "Please run script as user"
  exit
fi

script_full_path=$(dirname "$0")
source "$script_full_path/env.sh"

pacinstall() {
  sudo pacman -Syu --noconfirm --needed "$@"
}

# Main ---------------------------------------------------------
log Git-Dependencies "Creating Directories"

mkdir -p "$LOCAL/bin"
mkdir -p "$GIT_PROJECTS"

log Git-Dependencies "Installing"
pushd "$HOME/git-projects"

# Paru
git clone --depth 1 https://aur.archlinux.org/paru.git
pushd paru
makepkg -si
popd

# Eww
paru -S eww
ln -sf "$DOTS/config/eww" "$CONFIG/"

# Nvim config
git clone --depth 1 https://github.com/toftpokk/nvim-config
ln -sf "$GIT_PROJECTS/nvim-config" "$CONFIG/nvim"

paru -S ripdrag-git
paru -S vscodium-bin
paru -S hunspell-th
paru -S swaylock-effects
popd
