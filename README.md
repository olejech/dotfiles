# My dot files

## My workflow apps

- Karabiner
- Alacritty
- Aerospace
- Frontnvim
- Ripgrep
- Lazygit
- Tmux
  - Tmux plugin manager
- Fish
  - Fisher
- Vimium
- MonitorControl
- Obsidian
- Raycast

### Change language

Settings -> keyboard -> input sources -> prev language set as F18

### Nerd font

[MesloLGM Nerd Font](https://www.nerdfonts.com/font-downloads)

## Install

### Shell

`brew install fish fisher` — install shell & plugin manager

`brew install pwgen` - install password generator

`fisher install jomik/fish-gruvbox` — install theme

`fisher install FabioAntunes/fish-nvm edc/bass` — install plugin which support NVM

`which fish` — show path to fish shell

`sudo vim /etc/shells` — add fish path

`chsh -s $(which fish)` — change default shell

### Diff

`brew install difftastic` — install git diff tool

### Hazeover

`brew install hazeover` - install tool for window manager

### PastePng

`brew install pngpaste` - install tool for pasting images in notes

### Keyboard layout nvim

Switch keyboard layouts in nvim with [xkb-switch](https://github.com/ivanesmantovich/xkbswitch.nvim) and [input-source-switcher](https://github.com/vovkasm/input-source-switcher)

### Raycast

#### Change cmd + tab to Raycast search windows

`f13 -> switch windows`

### Scripts

Make `.sh` scripts executable:

`chmod 700 ~/dotfiles/scripts/*.sh`
