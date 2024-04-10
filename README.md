# Dotfiles

This is my linux config files, updated as I go.

## 0. Prerequisites

1. Install Archlinux
2. With packages: 
	- nano
	- sudo with `%wheel ALL=(ALL) ALL`
	- networkmanager started, enabled
	- grub
	- efibootmgr
3. Run with non-root user with wheel privileges
4. Connected to network
5. Cloned git repository to `~/dotfiles`
6. User with groups: wheel, video
  ```sh
  usermod -aG wheel,video $USER
  ```

Note: Config git in $XDG_CONFIG_HOME/git/config

## 1. Installing

Go to dotfiles and run installation script

	./install.sh

## Colors:

colors: {
    'red': '#ee3632',
    'orange': '#ee9e56',
    'yellow': '#F7DE4F',
    'green':'#6ab544',
    'cyan':'#70CCAD',
    'blue':'#5066C6',
    'purple':'#bf72ad',
    'brown':'#a16946',
    'black':'#181818',
    'gray1':'#282828',
    'gray2':'#383838',
    'gray3':'#585858',
    'gray4':'#b8b8b8',
    'gray5':'#d8d8d8',
    'gray6':'#e8e8e8',
    'white':'#f8f8f8'
},

## 2. After Install

### 2.1 Neovim

1. Install vimplug, documentation: https://github.com/junegunn/vim-plug

2. Install plugins

		:PlugInstall

3. Install Language Servers, documentation: https://github.com/neovim/nvim-lspconfig
	- bash: bash-language-server
	- typescript/javascript: typescript-language-server
		- Need to install typescript: `pacman -S typescript`
	- python: pyright
		- Need to install pyright `pacman -S pyright`

### 2.2 Dmenu

Install from https://gitlab.com/toftpokk/dmenu

### 2.3 Pipewire

If cannot connect, this may help

		systemctl --user status wireplumber pipewire pipewire-pulse

### 2.4 Firefox

**Basic Settings**

1. Set firefox settings
2. Install extensions <!-- TODO: Find way to install extension automatically-->
	- Ublock Origin
	- Facebook Container
	- User-agent Switcher and Manager
	- Yomichan
	- Multi-account Container
3. Add user.js <!-- TODO: Open Source own user.js-->

**Password**

Files in `key4.db` and `logins.json` are password-related, to copy passwords, use these

**UserChrome**

1. Create directory at

		~/mozilla/firefox/<profile>/chrome

2. Add chrome colors to `chrome/userChrome.css`

	```css
	/* Example */
	toolbar {
	  appearance: none !important;
	  background-color: #6ab544;
	}
	```
3. Set option in `about:config`

		toolkit.legacyUserProfileCustomizations.stylesheet=true

### 2.5 Pacman

For eye candy

1. Edit `/etc/pacman.conf` add `ILoveCandy` to like 29 
2. Uncomment `Color` in line 34

For multilib, uncomment `[multilib]` and `Include` in line 94

### 2.6 Touchpad

	cp other/30-touchpad.conf /etc/X11/xorg.conf.d/
	cp other/40-libinput.conf /etc/X11/xorg.conf.d/
	cp other/90-keymap.conf /etc/X11/xorg.conf.d/

### 2.7 Window Swallowing

Install bspswallow from https://github.com/JopStro/bspswallow, and put in `~/.local/bin`

Then, edit line 41,
 
	noswallow,terminals

Edit line 27,

	=$(get_ppid $pid)

### 2.8 SSH

To create config file use `~/.ssh/config`, with format

    Host NAME
        HostName IP_ADDRESS
        User	USERNAME
        Port	PORT

To generate new keys,

	ssh-keygen -t rsa
	ssh-keygen -t ed25519

To copy keys to host

	ssh-copy-id <host>

### 2.9 Backlights

If backlight does not work, i.e. `super+shift+plus`, add `./other/backlight.rules` to `/etc/udev/rules.d`, modifying `KERNEL` to backlight name in `/sys/class/backlight/NAME`

### 2.10 Bluetooth

To install bluetooth

	pacman -S bluez bluez-utils

Then, enable the service

	systemctl start bluetooth.service
	systemctl enable bluetooth.service

### 2.11 VPN

Add VPN files to `$XDG_STATE_HOME/runvpn` in the form of

	#== Folder Format ==#
	runvpn
		vpn_1
			vpn_1.ovpn
			vpn_1.txt
		vpn_2
			...
	
	#== vpn_1.txt ==#
	 username
	 password

For update-resolv problems, use openresolv

	pacman -S openresolv

Then, get update-resolv-conf https://github.com/alfredopalhares/openvpn-update-resolv-conf

Then put into `/etc/openvpn`

### 2.12 Wine

To install wine

	pacman -S wine zenity winetricks

Clipboard to wine

  wl-paste -t text -w xclip -selection clipboard

### 2.13 Formatting

For json processing

	pacman -S jq

For javascript formatting

	pacman -S python-jsbeautifier

For xml

	pacman -S libxml2

Note that libxml2 is already a dependency of several packages

### 2.14 Tools

- entr: for running arbitary commands at file change

### 2.15 Fonts

**THAI**
- THSarabun New
- THSarabun PSK
- Angsana New
- Angsana UPC

**English**
- Times New Roman

**Emoji**
- noto-fonts-emoji

Do an fc-cache as well

### 2.16 Fstab

For having a dedicated mounting location for certain storage, edit `/etc/fstab` with for example,

	192.168.1.155:/mnt/Storage/media/Music		/home/toftpokk/Music/server	nfs	defaults,noauto,user	0 0

To mount

	mount ~/Music/server

### 2.17 Programming

To install vscodium

	paru -S vscodium-bin

To install vscode

	pacman -S code

### 2.18 Office suite

To install libreoffice

	pacman -S local/libreoffice-fresh

Fo dark mode, install adwaita-qt6 and adwaita-qt5 <!-- TODO Needs more testing-->

### 2.19 Image Editing

To bulk-edit images, use imagemagick

	pacman -S imagemagick

## 2.20 Network Control

To control network access in applications, use opensnitch

	pacman -S opensnitch

Then enable

	systemctl start opensnitch
	systemctl enable opensnitch

To see running applications,

	opensnitch-ui

## 2.21 Wallpaper

Install swww

## 2.22 Ripdrag

Install icon dragger

	cargo install ripdrag
