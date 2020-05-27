# Add Antigen Bundles
source ~/.antigen.zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

# Run ls on every cd
chpwd() { ls }

# Make tab completion case insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Prompt Message
autoload -U colors && colors
precmd() { prompt }
prompt() {
  PROMPT="%(?.%F{green}√.%F{red}?%?)%f %B%F{250}%1~%f%b$(git_status) %# "
}

# Add git information
git_status() {
  BRANCH=$(git rev-parse --abbrev-ref HEAD 2>&1)
  if [[ $BRANCH =~ "fatal:" ]] || [[ "$(git rev-parse --show-toplevel)" == "$HOME" ]]; then
    echo ""
  else
    echo " (%{$fg_bold[magenta]%}$BRANCH%{${reset_color}%})"
  fi
}
