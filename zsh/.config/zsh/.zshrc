# Lines configured by zsh-newuser-install
HISTFILE="${XDG_STATE_HOME}/zsh/.histfile"
HISTSIZE=1000000
SAVEHIST=1000000
setopt autocd
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "${XDG_CONFIG_HOME}/zsh/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Zsh Configs
zstyle ":completion:*" menu select
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"

# Plugins
[[ -f "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[[ -f "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

# ASDF VM
[[ -f "/opt/asdf-vm/asdf.sh" ]] && source "/opt/asdf-vm/asdf.sh"

# Aliases
alias wget="wget --hsts-file=${XDG_DATA_HOME}/wget-hsts"

export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

eval "$(zoxide init zsh)"
