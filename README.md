# My dot files

## My workflow apps

- Karabiner
- Alacritty
- Amethyst
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

`fisher install jomik/fish-gruvbox` — install theme

`fisher install FabioAntunes/fish-nvm edc/bass` — install plugin which support NVM

`which fish` — show path to fish shell

`sudo vim /etc/shells` — add fish path

`chsh -s $(which fish)` — change default shell

### Diff

`brew install difftastic` — install git diff tool

### Raycast

#### Change cmd + tab to Raycast search windows

`f13 -> switch windows`

### Scripts

Make `.sh` scripts executable:

`chmod 700 /scripts/*.sh`
