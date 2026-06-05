if [ -d ~/.oh-my-zsh ]; then
  # Oh My Zsh is installed — check if .zshrc already sources .myzshrc
  if grep -q "source ~/.scripts/zsh/.myzshrc" ~/.zshrc 2>/dev/null; then
    echo "*********************"
    echo "* ohmyzsh installed *"
    echo "*********************"
  else
    # Adopted machine: Oh My Zsh exists but .zshrc doesn't reference our config.
    # Back up existing files and reinstall fresh.
    echo "**********************************************"
    echo "* ohmyzsh exists but .myzshrc not sourced    *"
    echo "* backing up and reinstalling fresh           *"
    echo "**********************************************"
    BACKUP_SUFFIX="pre-scripts-backup.$(date +%Y%m%d%H%M%S)"
    mv ~/.zshrc ~/.zshrc.$BACKUP_SUFFIX
    echo "Backed up ~/.zshrc to ~/.zshrc.$BACKUP_SUFFIX"
    mv ~/.oh-my-zsh ~/.oh-my-zsh.$BACKUP_SUFFIX
    echo "Backed up ~/.oh-my-zsh to ~/.oh-my-zsh.$BACKUP_SUFFIX"
    echo ""
    echo "To see what was removed:"
    echo "  diff ~/.zshrc ~/.zshrc.$BACKUP_SUFFIX"
    echo ""

    # Fall through to fresh install
    if $(command -v zsh >/dev/null) && $(command -v git >/dev/null); then
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
      echo "# INCLUDE CUSTOM RC" >> ~/.zshrc
      echo "if [ -f ~/.scripts/zsh/.myzshrc ]; then" >> ~/.zshrc
      echo "    source ~/.scripts/zsh/.myzshrc" >> ~/.zshrc
      echo "else" >> ~/.zshrc
      echo "    print \"404: ~/.scripts/zsh/.myzshrc not found.\"" >> ~/.zshrc
      echo "    print \"*************************************************************\"" >> ~/.zshrc
      echo "    print \"* cd ~ && git clone https://github.com/NothinButTreys/.scripts.git *\"" >> ~/.zshrc
      echo "    print \"*************************************************************\"" >> ~/.zshrc
      echo "fi" >> ~/.zshrc
      echo "# END INCLUDE CUSTOM RC" >> ~/.zshrc
    else
      echo "*************************"
      echo "* prereqs not installed *"
      echo "*************************"
      exit 1
    fi
  fi
else
  if $(command -v zsh >/dev/null) && $(command -v git >/dev/null); then
    echo "*********************"
    echo "* prereqs installed *"
    echo "*********************"

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "# INCLUDE CUSTOM RC" >> ~/.zshrc
    echo "if [ -f ~/.scripts/zsh/.myzshrc ]; then" >> ~/.zshrc
    echo "    source ~/.scripts/zsh/.myzshrc" >> ~/.zshrc
    echo "else" >> ~/.zshrc
    echo "    print \"404: ~/.scripts/zsh/.myzshrc not found.\"" >> ~/.zshrc
    echo "    print \"*************************************************************\"" >> ~/.zshrc
    echo "    print \"* cd ~ && git clone https://github.com/NothinButTreys/.scripts.git *\"" >> ~/.zshrc
    echo "    print \"*************************************************************\"" >> ~/.zshrc
    echo "fi" >> ~/.zshrc
    echo "# END INCLUDE CUSTOM RC" >> ~/.zshrc
  else
    echo "*************************"
    echo "* prereqs not installed *"
    echo "*************************"
    exit 1
  fi
fi
