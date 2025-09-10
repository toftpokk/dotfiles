#!/bin/sh
set -euo pipefail

# Init ---------------------------------------------------------
if [ "$(whoami)" = "root" ]; then
  echo "Please run script as user"
  exit
fi

script_full_path=$(dirname "$0")
source "$script_full_path/env.sh"

log Git-Dependencies "Creating Directories"

mkdir -p "$LOCAL/bin"
mkdir -p "$GIT_PROJECTS"

log Git-Dependencies "Installing"
pushd "$HOME/git-projects"

# Eww
git clone --depth 1 https://github.com/elkowar/eww
pushd eww
cargo build --release --no-default-features --features=wayland
mv target/release/eww "$LOCAL/bin/"
eww -V
popd

popd
