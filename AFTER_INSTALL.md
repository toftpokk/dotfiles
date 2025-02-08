# After Install
1. Restart
```sh
sudo systemctl reboot
```

2. copy secrets

./copy-secrets DESTINATION

3. Install localsend https://localsend.org/download
```sh
mv ~/Download/LocalSend* ~/.local/bin/
```

4. Configure firefox
- ublock origin
- bitwarden
- both incognito enabled (`about:addons`)
- user-agent switcher
- default browser duckduckgo

6. Install ssh configs
```sh
# download/generate id_rsa, id_ed25519, config
mkdir .ssh
mv id_* ~/.ssh/
mv config ~/.ssh/
chmod 0600 id_*
```

Alternatively,
```sh
ssh-keygen -t rsa
ssh-keygen -t ed25519
```
```config
Host NAME
    HostName IP_ADDRESS
    User	USERNAME
    Port	PORT
```

6. Configure git
```sh
git config --global user.name "USERNAME"
git config --global user.email "EMAIL"
```

7. Re-download dotfiles
```sh
mv dotfiles _dotfiles
git clone git@github.com:toftpokk/dotfiles.git
```

9. Fix backlight
```sh
sudo cp ./other/backlight.rules /etc/udev/rules.d
sudo chmod 644 /etc/udev/rules.d/backlight.rules
```

10. Install Thai Fonts
```sh
wget -O "THSarabunNew.zip" "https://www.f0nt.com/?dl_name=sipafonts/THSarabunNew.zip"
wget -O "07-TH-Sarabun-PSK.zip" "https://www.f0nt.com/?dl_name=sipafonts/07-TH-Sarabun-PSK.zip"
unzip THSarabunNew.zip
unzip 07-TH-Sarabun-PSK.zip
mv *.ttf ~/.local/share/fonts
```

11. Configure Firefox
- Extensions
    - Ublock Origin, Bitwarden, User-agent switcher, yomichan
- Default Browser Duckduckgo

12. Configure fstab mounts
```sh
# /etc/fstab
192.168.1.XXX:/path	/home/.../Mount/path		nfs defaults,noauto,user 0 0
```
```sh
sudo systemctl daemon-reload
```

13. Put wallpapers in `~/Backgrounds`
14. Install LINE
https://line.me/en/

15. Add private environmental variables
```sh
cp private_env.example ~/.config/private_env
vim ~/.config/private_env
```
