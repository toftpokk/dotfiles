#!/bin/sh
set -euo pipefail

# Init ---------------------------------------------------------
if [ "$(whoami)" = "root" ]; then
  echo "Please run script as user"
  exit
fi

script_full_path=$(dirname "$0")
source "$script_full_path/env.sh"

# Helpers ---------------------------------------------------------
pacinstall() {
  sudo pacman -Syu --noconfirm --needed "$@"
}

simple_install() {
  pacinstall "$1"
  ln -sf "$DOTS/config/$1" "$CONFIG/"
}

## Custom Packages ---------------------------------------------------------
pkg-zathura(){
  pacinstall 'zathura' 'zathura-cb' 'tesseract-data-eng' 'zathura-pdf-mupdf'

  ln -sf $DOTS/config/zathura $CONFIG/
}

pkg-fcitx(){
  pacinstall 'fcitx5' 'fcitx5-configtool' 'fcitx5-mozc' 'fcitx5-gtk'

  mkdir -p "$CONFIG/fcitx5"
  ln -sf $DOTS/config/fcitx5/config $CONFIG/fcitx5/config
  ln -sf $DOTS/config/fcitx5/profile $CONFIG/fcitx5/profile

  mkdir -p "$CONFIG/fcitx5/conf"
  ln -sf $DOTS/config/fcitx5/classicui.conf $CONFIG/fcitx5/conf/classicui.conf

  mkdir -p "$LOCAL/share/fcitx5"
  mkdir -p "$LOCAL/share/fcitx5/themes"
  ln -sf $DOTS/config/fcitx5/thaumura $LOCAL/share/fcitx5/themes/thaumura
}

pkg-gtk(){
  ln -sf $DOTS/config/gtk-2.0 $CONFIG/

  mkdir -p "$CONFIG/gtk-3.0"
  ln -sf $DOTS/config/gtk-3.0/settings.ini $CONFIG/gtk-3.0/

  mkdir -p "$CONFIG/gtk-4.0"
  ln -sf $DOTS/config/gtk-4.0/settings.ini $CONFIG/gtk-4.0/
}

pkg-zsh(){
  pacinstall 'zsh' 'zsh-completions'

  mkdir -p "$CONFIG/zsh"
  ln -sf $DOTS/config/zsh/zshrc $CONFIG/zsh/.zshrc
  ln -sf $DOTS/config/zsh/zprofile $CONFIG/zsh/.zprofile

  mkdir -p "$STATE/zsh"
  ln -sf $DOTS/home/zshenv $HOME/.zshenv

  chsh -s /usr/bin/zsh
}

pkg-fish(){
  pacinstall 'fish'

  ln -sf $DOTS/config/fish $CONFIG/
  chsh -s /usr/bin/fish
}

pkg-cmus(){
  pacinstall 'cmus'

  mkdir -p "$CONFIG/cmus"
  ln -sf $DOTS/config/cmus/* $CONFIG/cmus/
}

pkg-bash(){
  pacinstall 'bash-completion'

  ln -sf $DOTS/home/bash_profile $HOME/.bash_profile
  ln -sf $DOTS/home/bashrc $HOME/.bashrc
}

pkg-firefox() {
  pacinstall 'firefox'

  ffconfig="$HOME/.mozilla/firefox"
  firefox --headless -CreateProfile default
  profile="$(ls "$ffconfig" | grep "[^.]\+\.default")"
  cp "$DOTS/config/mozilla/user.js" "$ffconfig/$profile/user.js"
}

pkg-hyprland() {
  pacinstall 'hyprland' 'xdg-desktop-portal-hyprland'

  ln -sf $DOTS/config/hypr $CONFIG/
}

pkg-system(){
  # config
  ln -sf $DOTS/config/mimeapps.list $CONFIG/
  ln -sf $DOTS/config/stalonetrayrc $CONFIG/
  ln -sf $DOTS/config/python $CONFIG/
  ln -sf $DOTS/config/fontconfig $CONFIG/
  ln -sf $DOTS/config/hypr $CONFIG/

  # home
  ln -sf $DOTS/home/inputrc $HOME/.inputrc
  ln -sf $DOTS/home/Xresources $HOME/.Xresources

  # scripts
  ln -sf $DOTS/scripts $LOCAL/

  # systemd
  mkdir -p "$LOCAL/share/systemd/user"
  ln -sf "$DOTS/systemd/automount.service" "$LOCAL/share/systemd/user/automount.service"
  systemctl start --user automount.service
  systemctl enable --user automount.service
}

# Main ---------------------------------------------------------

log Dependencies "Creating Local Directories"

mkdir -p "$CONFIG"
mkdir -p "$STATE"
mkdir -p "$LOCAL"

mkdir -p "$HOME/Desktop"
mkdir -p "$HOME/Personal"
mkdir -p "$HOME/Personal/Notes"
mkdir -p "$HOME/Projects"
mkdir -p "$HOME/Backgrounds"
mkdir -p "$HOME/Entertainment"
mkdir -p "$HOME/test"
mkdir -p "$HOME/Mount"

log Dependencies "Installing System Packages"

pkg-system
pacinstall 'libnotify' 'base-devel'
pkg-gtk
pkg-bash

log Dependencies "Installing Custom Packages"

deps(){
  ## Fonts
  pacinstall 'noto-fonts' 'noto-fonts-cjk' 'noto-fonts-emoji' 'ttf-liberation' 'ttf-hack-nerd'

  ## Desktop Agnostic
  pacinstall "xdg-utils"

  ## Meta
  pacinstall 'man-db' 'pacman-contrib' "debugedit"

  ## Compression
  pacinstall 'zip' 'unzip' 'p7zip' 'unrar'

  ## Documents
  pacinstall 'libreoffice-fresh'
  pkg-zathura

  ## Audio/Visual
  pacinstall 'pipewire' 'pipewire-jack' 'pipewire-pulse' 'wireplumber' 'pavucontrol' 'pamixer'
  simple_install mpv

  ## System Utilities
  pacinstall 'usbutils' 'brightnessctl' 'fontconfig'

  ## Image Capture & Editing
  pacinstall 'imagemagick' 'ghostscript' 'nsxiv'

  ## File Sharing & Access
  pacinstall 'udisks2' 'nfs-utils' 'fuse2' 'deluge-gtk' 'rsync'

  ## Web & Network (ldns for drill)
  pacinstall 'wget' 'ldns'
  pkg-firefox

  ## Directory & Search
  pacinstall 'fzf' 'dua-cli' 'ripgrep' 'borg'
  simple_install highlight
  simple_install lf

  ## Terminal
  pkg-fish
  simple_install foot

  ## Desktop Linux Utilities
  pacinstall 'swayidle' 'wl-clipboard' \
    'htop' 'trash-cli' 'libsixel' 'chafa' \
    'playerctl' 'libcanberra'  'swww'
  simple_install mako
  simple_install fuzzel
  pkg-hyprland

  # Dictionary
  pacinstall 'hunspell-en_us'

  ## Wine
  pacinstall 'wine'

  ## Powermanagement
  pacinstall 'tlp'
  # also do systemctl enable tlp
  # also mask rfkill: systemctl mask systemd-rfkill.service
  # ref: https://wiki.archlinux.org/title/TLP

  ## Development
  pacinstall 'docker' 'docker-compose' 'python-virtualenv' 'neovim' 'git' 'python-pip' \
    'bash-language-server' 'pyright' 'rust-analyzer' 'typescript-language-server' 'shfmt'
}
deps

# Deprecated
# simple_install waybar
# simple_install niri
# simple_install dunst
# simple_install wofi
# fcitx
# pkg-zsh
# pkg-cmus
# simple_install foot
# ghostty
