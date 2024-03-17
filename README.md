#Installation
##Backup your config
1.mv ~/.config/nvim ~/.config/nvim.bak
##Remove cache setup
2.rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
####Install Nvim
3.git clone https://github.com/Theghost6/nvim.git ~/.config/nvim --depth 1 && nvim
