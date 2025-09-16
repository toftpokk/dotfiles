set -gx EDITOR nvim
set -gx TERMINAL foot
set -gx PAGER less
set -gx READER zathura
set -gx BROWSER firefox
set -gx LESS FRX # jj does not work well with default less
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_STATE_HOME "$HOME/.local/state"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx SUDO_ASKPASS "$HOME/.local/scripts/ask_password"

alias v="nvim"
alias vim="nvim"
alias cp="cp -i"
alias df="df -h"
alias more="less"
alias n="notes"
alias b="notes -b"
alias g="notes -g"

fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.local/scripts"
fish_add_path "$HOME/.local/scripts/notify"

set fish_greeting

if status --is-login
    if test (tty) = /dev/tty1
      exec Hyprland
    end
end
