# Do nothing if not in interactive mode
status --is-interactive; or return

# Apply theme
# theme_gruvbox

# vi key bindings
# fish_vi_key_bindings
fish_default_key_bindings


# Use neovim as editor
set -Ux EDITOR nvim
set -Ux VISUAL nvim

# Starship prompt stuff
# function starship_transient_rprompt_func
#   starship module time
# end

set -g fish_greeting

function starship_transient_prompt_func
  starship module character
end

starship init fish | source
# enable_transience

# Init zoxide
zoxide init fish | source


# Aliases
alias ls='eza -AlhF'
alias heidi="ssh 192.168.1.30 -X"
alias jet="ssh 192.168.1.77 -X -l cam"
alias heidifs="sshfs -o follow_symlinks -o allow_root cameron@192.168.1.30:/ ~/server"
alias win="ssh 10.0.0.95 -l GETTest"
alias imcat="wezterm imgcat"
alias tmux="tmux -u"
alias cat="batcat"
alias cd="z"
alias grep="rg"
alias reset-screencast="kill $(ps aux | grep gjs | grep Screencast | grep -v 'grep' | awk '{print $2}')"

# NVM
nvm use latest &> /dev/null
