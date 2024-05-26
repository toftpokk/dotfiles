#!/bin/sh
# inspired by https://github.com/PoSayDone/.dotfiles_new
set -euo pipefail

# Initial checks
if [ "$(whoami)" = "root" ]; then
  echo "Please run script as user"
  exit
fi

DOTS="$HOME/dotfiles"
CONFIG="$HOME/.config"
LOCAL="$HOME/.local"
GIT_PROJECTS="$HOME/git-projects"
DESKTOP="$HOME/Desktop"
PERSONAL="$HOME/Personal"
PROJECTS="$HOME/Projects"
BACKGROUNDS="$HOME/Backgrounds"
STATE="$HOME/.local/state"

# Pacman
echo "Installing Pacman config"
sudo mv "/etc/pacman.conf" "/etc/pacman.conf.bak"
sudo cp "$DOTS/other/pacman.conf" "pacman.conf"
sudo chmod 644 "pacman.conf"
sudo chown root:root "pacman.conf"
sudo pacman -Syu

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
'neovim' 'foot' 'git' 'hyprland' 'lf' 'pipewire' \
'pipewire-jack' 'pipewire-pulse' 'wireplumber' 'noto-fonts' 'noto-fonts-cjk' \
'firefox' 'zathura' 'zathura-cb' 'zathura-pdf-mupdf' 'dunst' 'libnotify' \
'fcitx5' 'fcitx5-configtool' 'fcitx5-mozc' 'fcitx5-gtk' 'wget' 'pamixer' \
'highlight' 'zsh' 'zsh-completions' 'rofi' 'playerctl' \
'rsync' 'fzf' 'sshfs' 'udisks2' 'unzip' \
'cmus' 'openvpn' 'htop' 'trash-cli' 'mpv' \
'libcanberra' 'ncdu' 'usbutils' 'zip' 'p7zip' 'grim' 'slurp' 'cliphist' 'unrar' 'bash-completion' 'ripgrep' 'waybar' \
'libsixel' 'chafa' 'hunspell-en_us' 'rust-analyzer' 'swayidle' 'nfs-utils' \
'acpilight' 'man-db' 'imagemagick' 'ghostscript' \
'fuse2' 'xclip' 'deluge-gtk' \
'ldns' 'python-virtualenv' 'bash-language-server' 'pyright' 'python-pip' \
'docker' 'docker-compose' 'pavucontrol' 'typescript-language-server' 'wofi' \
'wine' 'libreoffice-fresh'

# for screenshare
# xdg-desktop-portal-hyprland https://gist.github.com/PowerBall253/2dea6ddf6974ba4e5d26c3139ffb7580

paru -S --needed --noconfirm \
'nsxiv' 'fonts-tlwg' 'swaylock-effects' 'wl-gammarelay' 'safeeyes' 'ripdrag-git' 'swww' \
'hunspell-th'

# Symlinks
echo "Symlinking"
[ ! -d "$CONFIG" ] && mkdir "$CONFIG"
[ ! -d "$CONFIG/cmus" ] && mkdir "$CONFIG/cmus"
ln -sf $DOTS/config/cmus/* $CONFIG/cmus/
[ ! -d "$CONFIG/fcitx5" ] && mkdir "$CONFIG/fcitx5"
ln -sf $DOTS/config/fcitx5/config $CONFIG/fcitx5/config
ln -sf $DOTS/config/fcitx5/profile $CONFIG/fcitx5/profile
[ ! -d "$CONFIG/gtk-3.0" ] && mkdir "$CONFIG/gtk-3.0"
ln -sf $DOTS/config/gtk-3.0/settings.ini $CONFIG/gtk-3.0/
ln -sf $DOTS/config/gtk-2.0 $CONFIG/
ln -sf $DOTS/config/dunst $CONFIG/
ln -sf $DOTS/config/highlight $CONFIG/
ln -sf $DOTS/config/lf $CONFIG/
ln -sf $DOTS/config/nvim $CONFIG/
ln -sf $DOTS/config/zathura $CONFIG/
ln -sf $DOTS/config/mimeapps.list $CONFIG/
ln -sf $DOTS/config/stalonetrayrc $CONFIG/
ln -sf $DOTS/config/python $CONFIG/
ln -sf $DOTS/config/fontconfig $CONFIG/
ln -sf $DOTS/config/hypr $CONFIG/
ln -sf $DOTS/config/wofi $CONFIG/
ln -sf $DOTS/config/mpv $CONFIG/
ln -sf $DOTS/config/foot $CONFIG/
ln -sf $DOTS/config/waybar $CONFIG/

# Firefox
ffconfig="$HOME/.mozilla/firefox"
firefox -CreateProfile default
profile="$(ls "$ffconfig" | grep "[^.]\+\.default")"
cp "$DOTS/config/mozilla/user.js" "$ffconfig/$profile/user.js"

# ZSH
chsh -s /usr/bin/zsh
[ ! -d "$CONFIG/zsh" ] && mkdir "$CONFIG/zsh"
ln -sf $DOTS/config/zsh/zshrc $CONFIG/zsh/.zshrc
ln -sf $DOTS/config/zsh/zprofile $CONFIG/zsh/.zprofile
[ ! -d "$STATE/zsh" ] && mkdir "$STATE/zsh"
ln -sf $DOTS/home/zshenv $HOME/.zshenv

ln -sf $DOTS/home/bash_profile $HOME/.bash_profile
ln -sf $DOTS/home/bashrc $HOME/.bashrc
ln -sf $DOTS/home/inputrc $HOME/.inputrc
ln -sf $DOTS/home/Xresources $HOME/.Xresources

[ ! -d "$LOCAL" ] && mkdir "$LOCAL"
ln -sf $DOTS/scripts $LOCAL/

[ ! -d "$LOCAL/share" ] && mkdir "$LOCAL/share"
[ ! -d "$LOCAL/share/fonts" ] && mkdir "$LOCAL/share/fonts"
ln -sf $DOTS/fonts/* $LOCAL/share/fonts


[ ! -d "$LOCAL/bin" ] && mkdir "$LOCAL/bin"
# Autostart is just a suggestion
cp $DOTS/other/autostart $LOCAL/bin/autostart

[ ! -d "$DESKTOP" ] && mkdir "$DESKTOP"
[ ! -d "$PERSONAL" ] && mkdir "$PERSONAL"
[ ! -d "$PROJECTS" ] && mkdir "$PROJECTS"
[ ! -d "$BACKGROUNDS" ] && mkdir "$BACKGROUNDS"
[ ! -d "$STATE" ] && mkdir -p "$STATE"

echo "Done!"
