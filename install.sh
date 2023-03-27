#!/bin/sh
# inspired by https://github.com/PoSayDone/.dotfiles_new
set -euo pipefail
DOTS="$HOME/dotfiles"
CONFIG="$HOME/.config"
LOCAL="$HOME/.local"
GIT_PROJECTS="$HOME/git-projects"
DESKTOP="$HOME/Desktop"

# Paru
echo "Installing paru"
[ ! -d "$GIT_PROJECTS" ] && mkdir "$GIT_PROJECTS"
sudo pacman -S --noconfirm --needed 'rustup' 'base-devel'
rustup default stable
pushd "$GIT_PROJECTS"
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
popd

# Dependencies
echo "Installing dependencies"
sudo pacman -Syu --noconfirm --needed \
'neovim' 'alacritty' 'sxhkd' 'bspwm' 'git' 'xorg' 'xorg-xinit' 'lf' 'pipewire' \
'pipewire-jack' 'pipewire-pulse' 'wireplumber' 'noto-fonts' 'noto-fonts-cjk' \
'firefox' 'zathura' 'zathura-cb' 'zathura-pdf-mupdf' 'dunst' \
'fcitx5' 'fcitx5-configtool' 'fcitx5-mozc' 'fcitx5-gtk' 'wget' 'pamixer' \
'highlight' 'picom' 'rofi' 'playerctl' 'wmctrl' \
'xdotool' 'rsync' 'fzf' 'sshfs' 'udisks2' 'ueberzug' 'unzip' \
'xwallpaper' 'cmus' 'openvpn' 'htop' 'trash-cli' 'maim' 'xclip' 'mpv'

paru -S --needed --noconfirm \
'nsxiv' 'fonts-tlwg' 'eww'

# Symlinks
echo "Symlinking"
[ ! -d "$CONFIG" ] && mkdir "$CONFIG"
ln -sf $DOTS/config/alacritty $CONFIG/
ln -sf $DOTS/config/bspwm $CONFIG/
[ ! -d "$CONFIG/cmus" ] && mkdir "$CONFIG/cmus"
ln -sf $DOTS/config/cmus/superblue.theme $CONFIG/cmus
ln -sf $DOTS/config/dunst $CONFIG/
ln -sf $DOTS/config/eww $CONFIG/
ln -sf $DOTS/config/fcitx5 $CONFIG/
[ ! -d "$CONFIG/gtk-3.0" ] && mkdir "$CONFIG"
ln -sf $DOTS/config/gtk-3.0/settings.ini $CONFIG/gtk-3.0/
ln -sf $DOTS/config/highlight $CONFIG/
ln -sf $DOTS/config/lf $CONFIG/
ln -sf $DOTS/config/nvim $CONFIG/
ln -sf $DOTS/config/picom $CONFIG/
ln -sf $DOTS/config/rofi $CONFIG/
ln -sf $DOTS/config/sxhkd $CONFIG/
ln -sf $DOTS/config/zathura $CONFIG/
ln -sf $DOTS/config/commands $CONFIG/
ln -sf $DOTS/config/locations $CONFIG/
ln -sf $DOTS/config/mimeapps.list $CONFIG/
ln -sf $DOTS/config/stalonetrayrc $CONFIG/
ln -sf $DOTS/config/python $CONFIG/

ln -sf $DOTS/home/bash_profile $HOME/.bash_profile
ln -sf $DOTS/home/bashrc $HOME/.bashrc
ln -sf $DOTS/home/gtkrc-2.0 $HOME/.gtkrc-2.0
ln -sf $DOTS/home/inputrc $HOME/.inputrc
ln -sf $DOTS/home/xinitrc $HOME/.xinitrc
ln -sf $DOTS/home/Xresources $HOME/.Xresources

[ ! -d "$LOCAL" ] && mkdir "$LOCAL"
ln -sf $DOTS/scripts $LOCAL/

[ ! -d "$LOCAL/share" ] && mkdir "$LOCAL/share"
[ ! -d "$LOCAL/share/fonts" ] && mkdir "$LOCAL/share/fonts"
ln -sf $DOTS/fonts/* $LOCAL/share/fonts


[ ! -d "$LOCAL/bin" ] && mkdir "$LOCAL/bin"
ln -sf $DOTS/other/autostart $LOCAL/bin/autostart

[ ! -d "$DESKTOP" ] && mkdir "$DESKTOP"

echo "Done!"
