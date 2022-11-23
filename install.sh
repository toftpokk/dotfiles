#!/bin/sh
# inspired by https://github.com/PoSayDone/.dotfiles_new
CONFIG="$HOME/dotfiles/config"
CONFIG_DIR="$HOME/.config"

# Paru
echo "Installing paru"
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

# Dependencies
echo "Installing dependencies"
pacman -Syu --needed \
'neovim' 'alacritty' 'sxhkd' 'bspwm' 'git' 'xorg' 'xorg-xinit' 'lf' 'pipewire' \
'pipewire-jack' 'wireplumber' 'noto-fonts' 'noto-fonts-cjk' 'fonts-tlwg' \
'firefox' 'zathura' 'zathura-cb' 'zathura-pdf-mupdf' 'dunst' \
'fcitx5' 'fcitx5-configtool' 'fcitx5-mozc'  'wget' \
'highlight' 'picom' 'rofi' 'playerctl' 'wmctrl' \
'xdotool' 'rsync' 'fzf' 'sshfs' 'udisks2' 'ueberzug' 'unzip' \
'xwallpaper' 'cmus' 'openvpn' 'zenity' 'wine' 'winetricks' 'base-devel'

paru -S 'nsxiv'

# Clone dots
echo "Cloning dotfiles"
git clone https://github.com/kong-wep/dotfiles.git

# Symlinks
echo "Symlinking"
ln -sf $DIR/config/alacritty $CONFIG_DIR/alacritty
ln -sf $DIR/config/bspwm $CONFIG_DIR/bspwm
ln -sf $DIR/config/cmus $CONFIG_DIR/cmus
ln -sf $DIR/config/dunst $CONFIG_DIR/dunst
ln -sf $DIR/config/eww $CONFIG_DIR/eww
ln -sf $DIR/config/fcitx5 $CONFIG_DIR/fcitx5
ln -sf $DIR/config/gtk-3.0 $CONFIG_DIR/gtk-3.0
ln -sf $DIR/config/highlight $CONFIG_DIR/highlight
ln -sf $DIR/config/lf $CONFIG_DIR/lf
ln -sf $DIR/config/nvim $CONFIG_DIR/nvim
ln -sf $DIR/config/picom $CONFIG_DIR/picom
ln -sf $DIR/config/rofi $CONFIG_DIR/rofi
ln -sf $DIR/config/sxhkd $CONFIG_DIR/zathura
ln -sf $DIR/config/commands $CONFIG_DIR/commands
ln -sf $DIR/config/locations $CONFIG_DIR/locations
ln -sf $DIR/config/mimeapps.list $CONFIG_DIR/mimeapps.list

ln -sf $DIR/home/bash_profile $HOME/.bash_profile
ln -sf $DIR/home/bashrc $HOME/.bashrc
ln -sf $DIR/home/gtkrc-2.0 $HOME/.gtkrc-2.0
ln -sf $DIR/home/xinputrc $HOME/.xinputrc
ln -sf $DIR/home/xinitrc $HOME/.xinitrc
ln -sf $DIR/home/Xresources $HOME/.Xresources

ln -sf $DIR/scripts $HOME/.local/scripts

echo "Done!"
