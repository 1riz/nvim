#!/usr/bin/env lua

local function progress(msg)
  print("\27[97m" .. msg .. "\27[0m")
end

if #arg == 0 then
  print("Error")
  os.exit(1)
end

progress("Installing snippets...")
for _, s in ipairs(arg) do
  local f = s .. ".snippets"
  os.execute(
    "curl -sSL"
      .. " https://raw.githubusercontent.com/honza/vim-snippets/master/snippets/" .. f
      .. " -o ~/.config/nvim/snippets/" .. f
  )
end
progress("Done")
