##############
# SHOW LOGOS #
##############
export SKIP_LOGO=1
cd ~
clear

# Bootstrap: fetch from repo (raw GitHub) so we always use latest
SCRIPTS_RAW="${SCRIPTS_RAW:-https://raw.githubusercontent.com/NothinButTreys/.scripts/main}"
curl --silent -o- "$SCRIPTS_RAW/setup/logo.sh" | bash
#######################
# START SETUP TOOLING #
#######################
curl --silent -o- "$SCRIPTS_RAW/setup/git.sh" | bash
curl --silent -o- "$SCRIPTS_RAW/setup/gh.sh" | bash
curl --silent -o- "$SCRIPTS_RAW/setup/gh-auth.sh" | bash
curl --silent -o- "$SCRIPTS_RAW/setup/clone-scripts.sh" | bash

# Run all setup scripts from repo (single source of truth, same as update)
SCRIPTS_DIR="${SCRIPTS_DIR:-$HOME/.scripts}"
bash "$SCRIPTS_DIR/setup/run-setup-scripts.sh"

zsh
source ~/.zshrc

##############
# NEXT STEPS #
##############
echo "SOME THINGS TO DO..."
echo "*******************************************************"
echo "* nvim will auto-install plugins on first launch (LazyVim) *"
echo "*******************************************************"




