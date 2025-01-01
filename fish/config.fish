set fish_greeting ""
set PATH /usr/local/bin $PATH

# Enable vi-mode
fish_vi_key_bindings

source ~/dotfiles/fish/config.local.fish

alias lazygit="lazygit --use-config-file=$HOME/dotfiles/lazygit/config.yml,$LAZY_GIT_LOCAL_CONFIG_PATH"
alias zk="nvim $ZETTELKASTEN_PATH"
alias backup="~/dotfiles/scripts/backup.sh"

zoxide init fish | source
