#!/bin/sh
# inspired by https://github.com/PoSayDone/.dotfiles_new
set -euo pipefail
DOTS="$HOME/dotfiles"
CONFIG="$HOME/.config"
LOCAL="$HOME/.local"

# Paru
echo "Installing paru"
sudo pacman -S --noconfirm --needed 'rustup' 'base-devel'
git clone https://aur.archlinux.org/paru.git
pushd paru
makepkg -si
popd

# Dependencies
echo "Installing dependencies"
sudo pacman -Syu --noconfirm --needed \
'neovim' 'alacritty' 'sxhkd' 'bspwm' 'git' 'xorg' 'xorg-xinit' 'lf' 'pipewire' \
'pipewire-jack' 'wireplumber' 'noto-fonts' 'noto-fonts-cjk' \
'firefox' 'zathura' 'zathura-cb' 'zathura-pdf-mupdf' 'dunst' \
'fcitx5' 'fcitx5-configtool' 'fcitx5-mozc'  'wget' \
'highlight' 'picom' 'rofi' 'playerctl' 'wmctrl' \
'xdotool' 'rsync' 'fzf' 'sshfs' 'udisks2' 'ueberzug' 'unzip' \
'xwallpaper' 'cmus' 'openvpn' 'htop' 'trash-cli' 'maim'
# 'zenity' 'wine' 'winetricks'

paru -S --needed --noconfirm \
'nsxiv' 'fonts-tlwg' 'eww-git'


# Clone dots
echo "Cloning dotfiles"
git clone https://github.com/kong-wep/dotfiles.git

# Symlinks
echo "Symlinking"
[ ! -d "$CONFIG" ] && mkdir "$CONFIG"
ln -sf $DOTS/config/alacritty $CONFIG/
ln -sf $DOTS/config/bspwm $CONFIG/
ln -sf $DOTS/config/cmus $CONFIG/
ln -sf $DOTS/config/dunst $CONFIG/
ln -sf $DOTS/config/eww $CONFIG/
ln -sf $DOTS/config/fcitx5 $CONFIG/
ln -sf $DOTS/config/gtk-3.0 $CONFIG/
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

ln -sf $DOTS/home/bash_profile $HOME/.bash_profile
ln -sf $DOTS/home/bashrc $HOME/.bashrc
ln -sf $DOTS/home/gtkrc-2.0 $HOME/.gtkrc-2.0
ln -sf $DOTS/home/inputrc $HOME/.inputrc
ln -sf $DOTS/home/xinitrc $HOME/.xinitrc
ln -sf $DOTS/home/Xresources $HOME/.Xresources

[ ! -d "$LOCAL" ] && mkdir "$LOCAL"
ln -sf $DOTS/scripts $LOCAL/

[ ! -d "$LOCAL/share" ] && mkdir "$LOCAL/share"
ln -sf $DOTS/fonts $LOCAL/share/

[ ! -d "$LOCAL/bin" ] && mkdir "$LOCAL/bin"
ln -sf $DOTS/other/autostart $LOCAL/bin/autostart

# Vim plug
echo "Installing Vim-plug"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "Done!"
