# Add Antigen Bundles
source ~/.antigen.zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

# Run ls on every cd
chpwd() { ls }

# Creates and opens a new directory
dir() { mkdir -p -- "$1" && cd -P -- "$1" }

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

# Aliases
alias ..='cd ..'
alias c='clear'

# Add file.io sharing
file.io() {
  URL="https://file.io"
  DEFAULT_EXPIRE="14d" # Default to 14 days

  if [ $# -eq 0 ]; then
      echo "Usage: file.io FILE [DURATION]\n"
      echo "Example: file.io path/to/my/file 1w\n"
      return 1
  fi

  FILE=$1
  EXPIRE=${2:-$DEFAULT_EXPIRE}

  if [ ! -f "$FILE" ]; then
      echo "File ${FILE} not found"
      return 1
  fi

  RESPONSE=$(curl -# -F "file=@${FILE}" "${URL}/?expires=${EXPIRE}")

  RETURN=$(echo "$RESPONSE" | php -r 'echo json_decode(fgets(STDIN))->success;')

  if [ "1" != "$RETURN" ]; then
      echo "An error occured!\nResponse: ${RESPONSE}"
      return 1
  fi

  KEY=$(echo "$RESPONSE" | php -r 'echo json_decode(fgets(STDIN))->key;')
  EXPIRY=$(echo "${RESPONSE}" | php -r 'echo json_decode(fgets(STDIN))->link;')

  echo "${URL}/${KEY}" | pbcopy # to clipboard
  echo "${URL}/${KEY}"  # to terminal
}
