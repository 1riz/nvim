#!/usr/bin/env lua

local function progress(msg)
  print("\27[97m" .. msg .. "\27[0m")
end

local function warning(msg)
  print("\27[33m" .. msg .. "\27[0m")
end

progress("Backup your existing NVIM configuration...")
os.rename(os.getenv("HOME") .. "/.config/nvim", os.getenv("HOME") .. "/.config/nvim_BAK")

progress("Installing new configuration...")
os.execute("git clone https://github.com/1riz/nvim.git ~/.config/nvim")

progress("Installing Lazy plugin manager...")
os.execute("mkdir -p ~/.local/share/nvim/lazy")
os.execute(
  "git -c advice.detachedHead=false clone -q --filter=blob:none"
    .. " https://github.com/folke/lazy.nvim.git --branch=stable"
    .. " ~/.local/share/nvim/lazy/lazy.nvim"
)

warning("Run 'nvim' to finish the installation")
