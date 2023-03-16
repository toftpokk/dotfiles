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
  - os-prober
3. Run with non-root user with wheel privileges
4. Connected to network
5. Cloned git repository to `~/dotfiles`

## Installing
Go to the dotfiles directory and run
```
cd ~/dotfiles
./install.sh
```

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

and you can use `mount ~/Music/server` to mount and unmount