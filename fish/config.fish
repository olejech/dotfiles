set fish_greeting ""
set PATH /usr/local/bin $PATH

theme_gruvbox dark hard

# Enable vi-mode
fish_vi_key_bindings

source ~/dotfiles/fish/config.local.fish

alias lazygit="lazygit --use-config-file=$LAZY_GIT_LOCAL_CONFIG_PATH"
