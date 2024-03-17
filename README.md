#Installation
#Backup your config
mv ~/.config/nvim ~/.config/nvim.bak
Remove cache setup
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
#Install Nvim
git clone https://github.com/Theghost6/nvim.git ~/.config/nvim --depth 1 && nvim
