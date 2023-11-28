#!/usr/bin/env lua

local function progress(msg)
  print("\27[97m" .. msg .. "\27[0m")
end

local files = {
  "~/.cache/nvim",
  "~/.local/share/nvim",
  "~/.local/state/nvim",
  "~/.config/nvim"
}

progress("Removing NVIM config and plugins...")
for _, f in ipairs(files) do
  os.execute("rm -rf " .. f)
end
progress("Done")
