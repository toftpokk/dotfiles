# README 
## Prerequisites
1. Archlinux
2. Installed Packages
  - nano
  - sudo
    %wheel ALL=(ALL) ALL
  - networkmanager
    started, enabled
  - grub
  - efibootmgr
3. Run with non-root user with wheel privileges
4. Connected to network
5. Cloned git repository to `~/dotfiles`

## Installing
Go to the dotfiles directory and run
```
cd ~/dotfiles
./install.sh
```
## After Install
### Neovim
1. Install vimplug https://github.com/junegunn/vim-plug
2. do `:PlugInstall`
3. Install language servers using npm, https://github.com/neovim/nvim-lspconfig
  - bash-language-server
  - typescript-language-server
4. Install pyright
  - pacman -S pyright

### dmenu
install from https://gitlab.com/toftpokk/dmenu

### pipewire
If cannot connect, this may help
```
systemctl --user status wireplumber pipewire pipewire-pulse
```

### Firefox
Set firefox settings, install extensions, add user.js

### pacman
Edit /etc/pacman.conf, line 29 add ILoveCandy, uncomment Color

### Touchpad, Escape
```
sudo cp 30-touchpad.conf /etc/X11/xorg.conf.d/
sudo cp 40-libinput.conf /etc/X11/xorg.conf.d/
sudo cp 90-keymap.conf /etc/X11/xorg.conf.d/
```

### Window swallowing
https://github.com/JopStro/bspswallow
edit line 41 `noswallow,terminals`
edit line 27 `=$(get_ppid $pid)`

### SSH
ssh-keygen -t rsa
ssh-keygen -t ed25519

## Optional Packages

### Formatting
- jq : JSON processing
- python-jsbeautifier: javascript formatting
- libxml2 : already a dependency of several packages, includes xmllint, xml/html formatting

### Emulation
- wine: Windows emulator
- winetricks: support for installing dll packages, can be downloaded separately

### Tools
- entr: run arbitrary commands when files change

## Fonts
### Thai
- THSarabun New
- THSarabunPSK
- Angsana New
- AngsanaUPC
### English
- Times new roman

## After
### Wallpaper
In lf, go to a wallpaper and `mw` to add new wallpaper

### Fstab
Add stuff to fstab like

```fstab
192.168.1.155:/mnt/Storage/media/Music		/home/toftpokk/Music/server	nfs	defaults,noauto,user	0 0
```

Need to install nfs first
`pacman -S nfs-utils`

and you can use `mount ~/Music/server` to mount and unmount
