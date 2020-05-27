#!/bin/zsh

# Download files from repo
cd ~
git init
git remote add origin https://github.com/planecore/dotfiles.git
git fetch
git checkout origin/master -ft

# Make utils scripts excecutable
chmod u+x ~/utils/*.zsh

# Move README.md file back
mv ~/README.md ~/utils/README.md

# Install Homebrew if needed
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Restore Homebrew
brew bundle --global

# Source .zshrc
source ~/.zshrc

echo "Done! Create a new Terminal session to apply changes."