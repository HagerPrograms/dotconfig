export NVM_DIR="$HOME/.nvm"
export ZSHRC_DIR=$HOME/.config/zsh/.zshrc
export MANPAGER="nvim +Man!"
export PATH="/Users/sethhager/Library/Python/3.9/bin:$PATH"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# place this after nvm initialization!
autoload -U add-zsh-hook

#aliases
alias ls='ls -ahogp --color=auto'
alias ll='ls -ahogp --color=auto'
alias zshrc="nvim $HOME/.config/zsh/.zshrc"
alias vi="nvim"
alias vim="nvim"
alias nvimconfig="cd $HOME/.config"
alias repos="cd $HOME/Repos"
alias tree="tree -L 2"
alias dotconfig="cd $HOME/.config"

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
		fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

lg()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc
