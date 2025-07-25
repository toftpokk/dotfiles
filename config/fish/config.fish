set -gx EDITOR nvim
set -gx TERMINAL ghostty
set -gx PAGER less
set -gx READER zathura
set -gx BROWSER firefox
set -gx LESS FRX # jj does not work well with default less
set -gx XDG_CONFIG_HOME "$HOME/.config"	# XDG_CONFIG_HOME
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_STATE_HOME "$HOME/.local/state"
set -gx XDG_DATA_HOME "$HOME/.local/share"

alias v="nvim"
alias vim="nvim"
alias cp="cp -i"
alias df="df -h"
alias more="less"
alias n="notes"
alias b="blog"

fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.local/scripts"
fish_add_path "$HOME/.local/scripts/notify"

set fish_greeting

if status --is-login
    if test (tty) = /dev/tty1
        exec dbus-run-session niri --session
    end
end
