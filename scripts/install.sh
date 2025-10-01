#!/bin/sh

printf "\n\e[32m==> %s...\e[0m\n\n" "Installing new Neovim config..."

echo "Backup your existing NVIM configuration..."
mv ~/.config/nvim ~/.config/nvim_BAK

echo "Installing new configuration..."
git clone https://github.com/1riz/nvim.git ~/.config/nvim

echo "Installing Lazy plugin manager..."
mkdir -p ~/.local/share/nvim/lazy
git -c advice.detachedHead=false clone -q --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable ~/.local/share/nvim/lazy/lazy.nvim

echo "Run 'nvim' to finish the installation"
