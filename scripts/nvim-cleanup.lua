#!/usr/bin/env lua

local function progress(msg)
  print("\27[97m" .. msg .. "\27[0m")
end

local files = {
  "~/.cache/nvim",
  "~/.local/share/nvim/sessions",
  "~/.local/share/nvim/project_nvim",
  "~/.local/share/nvim/file_frecency.bin",
  "~/.local/share/nvim/harpoon.json",
  "~/.local/share/nvim/telescope_history",
  "~/.local/state/nvim/log",
  "~/.local/state/nvim/luasnip.log",
  "~/.local/state/nvim/shada/main.shada"
}

progress("Removing NVIM temporary data...")
for _, f in ipairs(files) do
  os.execute("rm -rf " .. f)
end
progress("Done")
