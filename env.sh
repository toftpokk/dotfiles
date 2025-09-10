DOTS="$HOME/dotfiles"
CONFIG="$HOME/.config"
LOCAL="$HOME/.local"
GIT_PROJECTS="$HOME/git-projects"
STATE="$HOME/.local/state"
# Fix bug: leftover gopath in $HOME
GOPATH="$CONFIG/go"

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

