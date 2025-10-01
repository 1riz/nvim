#!/bin/sh

printf "\n\e[32m==> %s...\e[0m\n\n" "Removing NVIM config and plugins..."
rm -rf ~/.cache/nvim ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim

echo "Done"
