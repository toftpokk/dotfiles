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
pacman() {
  newpacman="$DOTS/root/etc/pacman.conf"
  if cmp -s "/etc/pacman.conf" "$newpacman"; then
    log Pacman "Skipped. Pacman configuration up to date"
    return
  fi
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

log Install "Installing Pacman Configuration"

pacman

log Install "Installing Dependencies (dependencies.sh)"

$script_full_path/dependencies.sh

log Install "Installing Git Dependencies (git-dependencies.sh)"

$script_full_path/git-dependencies.sh

log Install "Installation Done!"
