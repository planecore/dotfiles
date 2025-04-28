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
alias ~='cd ~'
alias ..='cd ..'
alias c='clear'
alias intel='arch -x86_64'

# Enviroment Variables
export LANG=en_US.UTF-8
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# Go inside docker container
docker_sh() {
  if [ $# -eq 0 ]; then
      echo "Usage: docker_sh CONTAINER_ID\n"
      return 1
  fi

  docker exec -it "$1" bash
  if [ $? -eq 126 ]; then
    docker exec -it "$1" sh
  fi
}

# Function to upload a file to bashupload.com
upload() {
    if [ -z "$1" ]; then
        echo "Usage: upload <file_path>"
        return 1
    fi

    if [ ! -f "$1" ]; then
        echo "Error: File '$1' does not exist"
        return 1
    fi

    # Upload the file and get the response
    response=$(curl -s -F "json=true" -F "files=@$1" https://bashupload.com/)

    # Extract the URL from the JSON response
    url=$(echo "$response" | grep -o '"url":"[^"]*' | cut -d'"' -f4 | sed 's/\\//g')

    if [ -z "$url" ]; then
        echo "Error: Failed to upload file"
        return 1
    fi

    # Echo the URL
    echo "$url"

    # Copy to clipboard if running on macOS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo -n "$url" | pbcopy
    fi
}

# Add nvm support
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Add android studio support
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

# bun completions
[ -s "/Users/matan/.bun/_bun" ] && source "/Users/matan/.bun/_bun"

[[ "$TERM_PROGRAM" == "CodeEditApp_Terminal" ]] && . "/Applications/CodeEdit.app/Contents/Resources/codeedit_shell_integration.zsh"

# Add vscode support
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/matan/.cache/lm-studio/bin"
