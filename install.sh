#!/bin/sh
# inspired by https://github.com/PoSayDone/.dotfiles_new
DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"

echo "Installing dependencies"
pacman -Syu --needed
'neovim' 'alacritty' 'sxhkd' 'bspwm' 'git' 'xorg' 'xorg-xinit' 'lf' 'pipewire' \
'pipewire-jack' 'wireplumber' 'noto-fonts' 'noto-fonts-cjk' 'fonts-tlwg' \
'firefox' 'zathura' 'zathura-cb' 'zathura-pdf-mupdf' 'dunst' \
'fcitx5' 'fcitx5-configtool' 'fcitx5-mozc'  'wget' \
'highlight' 'picom' 'rofi' 'playerctl' 'wmctrl' \
'xdotool' 'rsync' 'fzf' 'sshfs' 'udisks2' 'ueberzug' 'unzip' \
'xwallpaper' 'cmus' 'openvpn' 'zenity' 'wine' 'winetricks'
paru -S 'nsxiv'
# Clone dots
echo "Cloning dotfiles"
git clone https://github.com/kong-wep/dotfiles

# Symlinks
ln -sf $DIR/
