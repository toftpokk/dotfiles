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

log Git-Dependencies "Creating Directories"

mkdir -p "$LOCAL/bin"
mkdir -p "$GIT_PROJECTS"

log Git-Dependencies "Installing"
pushd "$HOME/git-projects"

# Eww
pacinstall 'libdbusmenu-gtk3' 'gtk-layer-shell'
git clone --depth 1 https://github.com/elkowar/eww
pushd eww
cargo build --release --no-default-features --features=wayland
mv target/release/eww "$LOCAL/bin/"
eww -V
popd

# Vim
git clone --depth 1 https://github.com/toftpokk/nvim-config
ln -sf "$GIT_PROJECTS/nvim-config" "$CONFIG/nvim"

popd
