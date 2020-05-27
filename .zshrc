# Add Antigen Bundles
source /usr/local/share/antigen/antigen.zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

# Add fuck command
eval $(thefuck --alias)

# Run ls on every cd
chpwd() { ls }

# Prompt Message
autoload -U colors && colors
precmd() { prompt }
prompt() {
  PROMPT="%(?.%F{green}√.%F{red}?%?)%f %B%F{250}%1~%f%b$(git_status) %# "
}

# Add git information
git_status() {
  BRANCH=$(git rev-parse --abbrev-ref HEAD 2>&1)
  if [[ $BRANCH =~ "fatal:" ]]; then
    echo ""
  else
    echo " (%{$fg_bold[magenta]%}$BRANCH%{${reset_color}%})"
  fi
}

