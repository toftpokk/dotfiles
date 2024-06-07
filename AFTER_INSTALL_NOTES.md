## Mirrors

Updating mirrors makes pacman a LOT faster

Mirrors: https://wiki.archlinux.org/title/Mirrors
```sh
# /etc/pacman.d/mirrorlist
# Thailand
Server = https://mirror.cyberbits.asia/archlinux/$repo/os/$arch
Server = http://mirror.kku.ac.th/archlinux/$repo/os/$arch
Server = https://mirror.kku.ac.th/archlinux/$repo/os/$arch
Server = http://mirror2.totbb.net/archlinux/$repo/os/$arch
```

## Git

Config git in `$XDG_CONFIG_HOME/git/config`

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

Install Language Servers, documentation: https://github.com/neovim/nvim-lspconfig
	- bash: bash-language-server
	- typescript/javascript: typescript-language-server
		- Need to install typescript: `pacman -S typescript`
	- python: pyright
		- Need to install pyright `pacman -S pyright`

### 2.3 Pipewire

If cannot connect, this may help

		systemctl --user status wireplumber pipewire pipewire-pulse


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

### 2.6 Touchpad

	cp other/30-touchpad.conf /etc/X11/xorg.conf.d/
	cp other/40-libinput.conf /etc/X11/xorg.conf.d/
	cp other/90-keymap.conf /etc/X11/xorg.conf.d/

### 2.10 Bluetooth

To install bluetooth
```sh
pacman -S bluez bluez-utils
```

Then, enable the service
```sh
sudo systemctl start bluetooth.service
# Optionally
sudo systemctl enable bluetooth.service
```

Find devices
```sh-session
$ bluetoothctl
# scan on
# devices
# pair MAC:ADDRESS
# connect MAC:ADDRESS
```
Note: devices need to have names, otherwise it's not supposed to be connected
(Example: headphones which shows up on iphones have names next to mac addresses,
router does not)

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

### 2.18 Office suite

To install libreoffice

	pacman -S local/libreoffice-fresh

Fo dark mode, install adwaita-qt6 and adwaita-qt5 <!-- TODO Needs more testing-->

## 2.20 Network Control

To control network access in applications, use opensnitch

	pacman -S opensnitch

Then enable

	systemctl start opensnitch
	systemctl enable opensnitch

To see running applications,

	opensnitch-ui

## Docker

```sh
usermod -aG docker $USER
```
