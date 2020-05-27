#!/bin/zsh

cd ~
git add .gitignore

# Move README.md file
mv ~/utils/README.md ~/README.md

# Backup zsh config
git add .zshrc
git add .antigen.zsh

# Backup scripts
git add utils

# Backup README.md
git add README.md

# Push changes to GitHub
git commit -m "Updated dotfiles from utils/backup.zsh"
git push origin master

# Move README.md file back
mv ~/README.md ~/utils/README.md