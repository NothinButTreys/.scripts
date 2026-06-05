##############
# clone .scripts #
##############
# Requires git, gh, and gh-auth first. Uses gh repo clone for initial clone.

source ~/.zshrc 2>/dev/null || true

SCRIPTS_GH_REPO="${SCRIPTS_GH_REPO:-NothinButTreys/.scripts}"
SCRIPTS_DIR="${SCRIPTS_DIR:-$HOME/.scripts}"

if [[ -d "$SCRIPTS_DIR" ]] && [[ -d "$SCRIPTS_DIR/.git" ]]
then
  echo "*************************"
  echo "* .scripts repo present *"
  echo "*************************"
  echo "Pulling latest..."
  (cd "$SCRIPTS_DIR" && git pull --rebase 2>/dev/null) || true
else
  echo "**************************"
  echo "* cloning .scripts repo  *"
  echo "**************************"

  if ! $(command -v gh >/dev/null)
  then
    echo "gh CLI required. Run gh setup first."
    exit 1
  fi

  if [[ -d "$SCRIPTS_DIR" ]]
  then
    echo "Removing existing $SCRIPTS_DIR (not a git repo)"
    rm -rf "$SCRIPTS_DIR"
  fi

  gh repo clone "$SCRIPTS_GH_REPO" "$SCRIPTS_DIR"
  echo ".scripts cloned to $SCRIPTS_DIR"
fi
