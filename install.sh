#!/bin/sh
# inspired by https://github.com/PoSayDone/.dotfiles_new
set -euo pipefail

# Init ---------------------------------------------------------
if [ "$(whoami)" = "root" ]; then
  echo "Please run script as user"
  exit
fi

script_full_path=$(dirname "$0")
source "$script_full_path/env.sh"

# Helpers ---------------------------------------------------------
FRED='\033[0;31m'
FGRE='\033[0;32m'
FBLU='\033[0;34m'
FNON='\033[0m'
log() {
  echo -e "$FRED>>>>>> [$1]$FNON $2"
}

debug() {
  if [ ! -z "${DEBUG:-}" ]; then
    echo -e "$FGRE>>>>>> [DEBUG]$FNON $1"
  fi
}

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

# Main ---------------------------------------------------------
log Install "Starting..."
debug "$(cat <<EOF
ENVS:
  HOME=$HOME
  DOTS=$DOTS
  CONFIG=$CONFIG
  LOCAL=$LOCAL
  GIT_PROJECTS=$GIT_PROJECTS
  STATE=$STATE
EOF
)"

log Install "Pacman"
# pacman

log Install "Dependencies"
$script_full_path/dependencies.sh

log Install "Done!"

log TODO "Next Steps:
1. AUR only packages
'fonts-tlwg' 'swaylock-effects' 'wl-gammarelay' 'safeeyes' 'ripdrag-git' \
  'hunspell-th' 'vscodium-bin'

2. Install Neovim
"
