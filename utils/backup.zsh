#!/bin/zsh

cd ~
git add .gitignore

# Move README.md file
mv ~/utils/README.md ~/README.md

# Backup Homebrew
brew bundle dump --global --force
git add .Brewfile

# Backup zsh config
git add .zshrc

# Backup scripts
git add utils

# Backup README.md
git add README.md

# Push changes to GitHub
git commit -m "Updated dotfiles from utils/backup.zsh"
git push origin master

# Move README.md file back
mv ~/README.md ~/utils/README.md