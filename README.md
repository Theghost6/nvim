# NTS Neovim Config

## 1. Install OS Prerequisites
```bash
sudo apt update && sudo apt install -y nodejs python3 python3-pip python3-venv gcc rustc cargo ripgrep fd-find
```

## All-in-One Installation
```bash
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null; rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim && git clone https://github.com/Theghost6/nvim.git ~/.config/nvim --depth 1 && nvim
```
