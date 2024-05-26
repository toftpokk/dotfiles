# Dotfiles

This is my linux config files, updated as I go.

## Prerequisites

1. Install Archlinux
2. With packages: 
	- sudo with `%wheel ALL=(ALL) ALL`
	- networkmanager started, enabled
	- grub
	- efibootmgr
3. Run with non-root user with wheel privileges
4. Connected to network
5. Cloned repository
	```sh
	git clone https://github.com/toftpokk/dotfiles
	```
6. User
	```sh
	usermod -aG wheel,audio,video,optical,storage $USER
	```
## Installation
```sh
# As normal user
./install.sh
```