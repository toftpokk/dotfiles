#!/bin/sh
# inspired by https://github.com/PoSayDone/.dotfiles_new
set -euo pipefail

echo 'Install script in its current form is untested'
exit 1

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

##### Helpers #####

log() {
	FRED='\033[0;31m'
	FBLU='\033[0;34m'
	FNON='\033[0m' # No Color
	echo -e "$FRED>>>>>> [$1]$FNON $2"
}
pacinstall() {
	sudo pacman -Syu --noconfirm --needed "$@"
}

##### Functions #####

# Localdir
localdir() {
	log Localdir "Started"
	mkdir -p "$STATE"
	mkdir -p "$HOME/Desktop"
	mkdir -p "$HOME/Personal"
	mkdir -p "$HOME/Personal/Notes"
	mkdir -p "$HOME/Projects"
	mkdir -p "$HOME/Backgrounds"
	mkdir -p "$HOME/Entertainment"
	mkdir -p "$HOME/test"
	mkdir -p "$HOME/Mount"
}

# Pacman
pacman() {
    newpacman="$DOTS/root/etc/pacman.conf"
    if cmp -s "/etc/pacman.conf" "$newpacman"; then
		log Pacman "Config up to date"
		return
	fi
	log Pacman "Installing Config"
	sudo mv "/etc/pacman.conf" "/etc/pacman.conf.bak"
	sudo cp "$newpacman" "/etc/pacman.conf"
	sudo chmod 644 "/etc/pacman.conf"
	sudo chown root:root "/etc/pacman.conf"
}

# Dependencies
dependencies() {
	log Pacinstall "Installing dependencies"
	## Desktop Agnostic
	pacinstall "xdg-utils"

	# for makepkg
	pacinstall "debugedit"

	# Fonts
	pacinstall 'noto-fonts' 'noto-fonts-cjk' 'noto-fonts-emoji' 'ttf-liberation' 'ttf-hack-nerd'
	## Meta
	pacinstall 'man-db' 'pacman-contrib'
	## Compression
	pacinstall 'zip' 'unzip' 'p7zip' 'unrar'
	## Documents
	pacinstall 'libreoffice-fresh' 'zathura' 'zathura-cb' 'tesseract-data-eng' 'zathura-pdf-mupdf'
	## Audio/Visual
	pacinstall 'pipewire' 'pipewire-jack' 'pipewire-pulse' 'wireplumber' 'pavucontrol' 'pamixer' 'mpv'
	## System Utilities
	pacinstall 'usbutils' 'acpilight' 'fontconfig'
	## Image Capture & Editing
	pacinstall 'imagemagick' 'ghostscript' 'nsxiv'
	## File Sharing & Access
	pacinstall 'udisks2' 'nfs-utils' 'fuse2' 'deluge-gtk' 'rsync'
  ## Web & Network (ldns for drill)
	pacinstall 'wget' 'firefox' 'ldns'
	## Directory & Search
	pacinstall 'lf' 'highlight' 'fzf' 'dua-cli' 'ripgrep' 'borg'
	## Terminal
	pacinstall 'fish'
	## Desktop Linux Utilities
	pacinstall 'niri' 'swayidle' 'wl-clipboard' \
		'htop' 'trash-cli' 'libsixel' 'chafa' \
		'waybar' 'mako' 'libnotify' 'playerctl' 'libcanberra' 'fuzzel' 'swww'
	## Language

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

# Symlinks
symlink() {
	log Symlink "Started"
	[ ! -d "$CONFIG" ] && mkdir "$CONFIG"
	[ ! -d "$CONFIG/cmus" ] && mkdir "$CONFIG/cmus"
	ln -sf $DOTS/config/cmus/* $CONFIG/cmus/
	## Fcitx
	[ ! -d "$CONFIG/fcitx5" ] && mkdir "$CONFIG/fcitx5"
	ln -sf $DOTS/config/fcitx5/config $CONFIG/fcitx5/config
	ln -sf $DOTS/config/fcitx5/profile $CONFIG/fcitx5/profile
	[ ! -d "$CONFIG/fcitx5/conf" ] && mkdir "$CONFIG/fcitx5/conf"
	ln -sf $DOTS/config/fcitx5/classicui.conf $CONFIG/fcitx5/conf/classicui.conf
	[ ! -d "$LOCAL/share/fcitx5" ] && mkdir "$LOCAL/share/fcitx5"
	[ ! -d "$LOCAL/share/fcitx5/themes" ] && mkdir "$LOCAL/share/fcitx5/themes"
	ln -sf $DOTS/config/fcitx5/thaumura $LOCAL/share/fcitx5/themes/thaumura

	## GTK
	ln -sf $DOTS/config/gtk-2.0 $CONFIG/
	[ ! -d "$CONFIG/gtk-3.0" ] && mkdir "$CONFIG/gtk-3.0"
	ln -sf $DOTS/config/gtk-3.0/settings.ini $CONFIG/gtk-3.0/
	[ ! -d "$CONFIG/gtk-4.0" ] && mkdir "$CONFIG/gtk-4.0"
	ln -sf $DOTS/config/gtk-4.0/settings.ini $CONFIG/gtk-4.0/

	ln -sf $DOTS/config/dunst $CONFIG/
	ln -sf $DOTS/config/highlight $CONFIG/
	ln -sf $DOTS/config/lf $CONFIG/
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
	log Symlink "Firefox"
	ffconfig="$HOME/.mozilla/firefox"
	firefox --headless -CreateProfile default
	profile="$(ls "$ffconfig" | grep "[^.]\+\.default")"
	cp "$DOTS/config/mozilla/user.js" "$ffconfig/$profile/user.js"

	# ZSH
	log Symlink "ZSH"
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
	# Systemd files
	[ ! -d "$LOCAL/share/systemd" ] && mkdir "$LOCAL/share/systemd"
	[ ! -d "$LOCAL/share/systemd/user" ] && mkdir "$LOCAL/share/systemd/user"
	ln -sf "$DOTS/systemd/automount.service" "$LOCAL/share/systemd/user/automount.service"
	systemctl start --user automount.service
	systemctl enable --user automount.service

	[ ! -d "$LOCAL/bin" ] && mkdir "$LOCAL/bin"
	# Autostart is just a suggestion
	cp $DOTS/other/autostart $LOCAL/bin/autostart
}

##### Main ######
log Install "Start"
localdir
pacman
dependencies
symlink
log Install "Done!"
log TODO "Next Steps:
1. AUR only packages
'fonts-tlwg' 'swaylock-effects' 'wl-gammarelay' 'safeeyes' 'ripdrag-git' \
'hunspell-th' 'vscodium-bin'

2. Install Neovim
"
