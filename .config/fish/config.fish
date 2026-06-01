# Do nothing if not in interactive mode
status --is-interactive; or return

# Apply theme
# theme_gruvbox

# Use neovim as editor
set -gx EDITOR nvim
set -gx VISUAL nvim

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

set distro (grep '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"')
if test "$distro" = "arch"
    alias cat="bat -p"
else
    alias cat="batcat -p"
end

#========== Aliases ==================#
# General
alias ls='eza -AlhF --icons'
alias tmux="tmux -u"
alias cd="z"
alias grep="rg"

# Ansible
alias ansible-deploy="ansible-playbook infrastructure/ansible/deploy.yml -e @infrastructure/config.yaml"
alias ansible-teardown="ansible-playbook infrastructure/ansible/teardown.yml -e @infrastructure/config.yaml"

# Python dev
alias py-dev="source ~/dev/env/python-dev/bin/activate.fish"

# K8s
alias decode="jq '.data | map_values(@base64d)'"

function get-deployed-versions -a namespace
    kubectl -n $namespace get pods -o yaml | awk -F'[/:]' '/image: rocketboots/ {print $(NF-1) " -> " $NF}' | sort -u
end


function ssht -a name
    ssh -X $name@$(tailscale status | grep $name | awk '{print $1}')
end

function clone -a repo
    git clone "https://cameronlovell1@bitbucket.org/rocketboots/$repo.git" ~/dev/src/$repo
    cd ~/dev/src/$repo
end
# NVM
nvm use latest &> /dev/null

fish_add_path $HOME/.local/bin $HOME/.krew/bin

if type -q op
    op completion fish | source
end
