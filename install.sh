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
STATE="$HOME/.local/state"
# Fix bug: leftover gopath in $HOME
GOPATH="$CONFIG/go"

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
pacinstall(){
  sudo pacman -Syu --noconfirm --needed "$@"
}
echo "Installing dependencies"
# Fonts
pacinstall 'noto-fonts' 'noto-fonts-cjk' 'noto-fonts-emoji' 'ttf-liberation'
## Meta
pacinstall 'man-db'
## Compression
pacinstall 'zip' 'unzip' 'p7zip' 'unrar'
## Documents
pacinstall 'libreoffice-fresh' 'zathura' 'zathura-cb' 'zathura-pdf-mupdf'
## Development
pacinstall 'docker' 'docker-compose' 'python-virtualenv' 'neovim' 'git' 'python-pip' \
  'bash-language-server' 'pyright' 'rust-analyzer' 'typescript-language-server'
## Image Capture & Editing
pacinstall 'imagemagick' 'ghostscript' 'grim' 'slurp'
## File Sharing & Access
pacinstall 'openvpn' 'sshfs' 'udisks2' 'nfs-utils' 'fuse2' 'deluge-gtk' 'rsync'
## Web & Network
pacinstall 'wget' 'firefox' 'ldns'
## Directory & Search
pacinstall 'lf' 'highlight' 'fzf' 'ncdu' 'ripgrep'
## Terminal
pacinstall 'zsh' 'zsh-completions' 'bash-completion' 'foot'
## Desktop Linux Utilities
pacinstall 'hyprland' 'xdg-desktop-portal-hyprland' 'swayidle' 'xclip' 'cliphist' \
   'htop' 'trash-cli' 'libsixel' 'chafa' \
   'waybar' 'dunst' 'libnotify' 'playerctl' 'libcanberra' 'wofi'
## System Utilities
pacinstall 'usbutils' 'acpilight'
## Audio/Visual
pacinstall 'pipewire' 'pipewire-jack' 'pipewire-pulse' 'wireplumber' 'pavucontrol' 'pamixer' 'mpv'
## Language
pacinstall 'fcitx5' 'fcitx5-configtool' 'fcitx5-mozc' 'fcitx5-gtk' 'hunspell-en_us'
## Wine
pacinstall 'wine'

paru -S --needed --noconfirm \
'nsxiv' 'fonts-tlwg' 'swaylock-effects' 'wl-gammarelay' 'safeeyes' 'ripdrag-git' 'swww' \
'hunspell-th' 'vscodium-bin'

# Symlinks
echo "Symlinking"
[ ! -d "$CONFIG" ] && mkdir "$CONFIG"
[ ! -d "$CONFIG/cmus" ] && mkdir "$CONFIG/cmus"
ln -sf $DOTS/config/cmus/* $CONFIG/cmus/
## Fcitx
[ ! -d "$CONFIG/fcitx5" ] && mkdir "$CONFIG/fcitx5"
ln -sf $DOTS/config/fcitx5/config $CONFIG/fcitx5/config
ln -sf $DOTS/config/fcitx5/profile $CONFIG/fcitx5/profile

## GTK
ln -sf $DOTS/config/gtk-2.0 $CONFIG/
[ ! -d "$CONFIG/gtk-3.0" ] && mkdir "$CONFIG/gtk-3.0"
ln -sf $DOTS/config/gtk-3.0/settings.ini $CONFIG/gtk-3.0/
[ ! -d "$CONFIG/gtk-4.0" ] && mkdir "$CONFIG/gtk-4.0"
ln -sf $DOTS/config/gtk-4.0/settings.ini $CONFIG/gtk-4.0/

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

[ ! -d "$STATE" ] && mkdir -p "$STATE"
[ ! -d "$HOME/Desktop" ] &&       mkdir "$HOME/Desktop"
[ ! -d "$HOME/Personal" ] &&      mkdir "$HOME/Personal"
[ ! -d "$HOME/Personal/Notes" ] && mkdir "$HOME/Personal/Notes"
[ ! -d "$HOME/Projects" ] &&      mkdir "$HOME/Projects"
[ ! -d "$HOME/Backgrounds" ] &&   mkdir "$HOME/Backgrounds"
[ ! -d "$HOME/Entertainment" ] && mkdir "$HOME/Entertainment"
[ ! -d "$HOME/test" ] &&          mkdir "$HOME/test"
[ ! -d "$HOME/Mount" ] &&         mkdir "$HOME/Mount"

echo "Done!"
