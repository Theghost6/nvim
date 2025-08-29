# Installation
## Backup your config
```bash
mv ~/.config/nvim ~/.config/nvim.bak
```
## Remove cache setup
```bash
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
```
## Install Nvim
```bash
git clone https://github.com/Theghost6/nvim.git ~/.config/nvim --depth 1 && nvim
```
## All In One
```bash
mv ~/.config/nvim ~/.config/nvim.bak && rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim && git clone https://github.com/Theghost6/nvim.git ~/.config/nvim --depth 1 && nvim
```
