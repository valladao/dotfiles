# Set up PATH
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# Path to your Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="miloshadzic"

# Plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions)

source $ZSH/oh-my-zsh.sh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Load NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Load secret environment variables (e.g., API keys)
if [ -f "$HOME/.secrets" ]; then
  source "$HOME/.secrets"
fi

# Restore the last working directory when opening a new terminal
if [ -f ~/.last_dir ]; then
  cd "$(cat ~/.last_dir)"
fi

# Save the current directory every time the prompt updates
precmd() {
  pwd > ~/.last_dir
}

# AI autocomplete function using OpenAI's Chat API (requires $OPENAI_API_KEY in ~/.secrets)
# Usage:
#   ai_complete <your prompt>
# Example:
#   ai_complete explain this bash command: "find . -type f -name '*.sh'"
function ai_complete() {
  local prompt="${(j: :)@}"
  local response=$(curl -s -X POST "https://api.openai.com/v1/chat/completions" \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{
      "model": "gpt-3.5-turbo",
      "messages": [{"role": "user", "content": "'"$prompt"'"}],
      "max_tokens": 200
    }' | jq -r '.choices[0].message.content')
  echo "$response"
}

# Add scripts in scripts folder to path 
export PATH="$HOME/scripts:$PATH"

# Use neovim as file editor
export EDITOR=nvim

