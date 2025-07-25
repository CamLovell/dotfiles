# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set up the prompt

# autoload -Uz promptinit
# promptinit
# prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Powerlevel10k prompt
# source ~/powerlevel10k/powerlevel10k.zsh-theme
#
# # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Starship prompt
eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export EDITOR=nvim
export PATH=/home/cameron/.local/bin:$PATH
source "$HOME/.cargo/env"

# Commands
gip() {
  ssh 192.168.1.30 "getent hosts $1.local | awk '{print \$1}'"
}

sshl() {
  local ip=$(gip $1 2>/dev/null)
  if [[ -n "$ip" ]]; then
    ssh -X -l $1 "$ip"
  else
    echo "Error: Unable to resolve IP for $1" >&2
  fi
}

# ssht() {
#     ssh -X $1@$(tailscale status | grep $1 | awk '{print $1}')
# }


# Aliases
# alias ls='ls -AlhF --color=auto'
alias ls='eza -AlhF'
alias heidi="ssh 192.168.1.30 -X"
alias jet="ssh 192.168.1.77 -X -l cam"
alias heidifs="sshfs -o follow_symlinks -o allow_root cameron@192.168.1.30:/ ~/server"
alias win="ssh 10.0.0.95 -l GETTest"
alias imcat="wezterm imgcat"
alias tmux="tmux -u"
alias cat="batcat"
alias cd="z"
alias reset-screencast="kill $(ps aux | grep gjs | grep Screencast | grep -v 'grep' | awk '{print $2}')"



# Initialise zoxide
eval "$(zoxide init zsh)"


