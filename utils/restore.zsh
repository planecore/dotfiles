#!/bin/zsh

# Download files from repo
cd ~
rm -rf .git
git init
git remote add origin https://github.com/planecore/dotfiles.git
git fetch
git checkout origin/master -ft

# Make utils scripts excecutable
chmod u+x ~/utils/*.zsh

# Move README.md file back
mv ~/README.md ~/utils/README.md

# Source .zshrc
source ~/.zshrc

echo "Done! Create a new Terminal session to apply changes."