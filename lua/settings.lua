--
-- NVIM Settings
--

-- General
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.grepprg = "rg -uuu --glob '!**/.git/*' --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.shada = "!,'100,<50,s10,h"

-- UI
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.titlestring = "Neovim"
vim.opt.cursorline = true
vim.opt.showtabline = 0
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.number = true
vim.opt.list = true
vim.opt.listchars = "tab:▸ ,trail:▫"
vim.opt.scrolloff = 1
vim.opt.pumheight = 30
vim.opt.wildoptions = "fuzzy,pum,tagfile"
vim.opt.whichwrap = "b,s,<,>"
vim.opt.timeoutlen = 500
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.clipboard = "unnamedplus"
vim.opt.sessionoptions = "buffers,curdir"
vim.opt.mousemodel = "extend"

-- GUI
if vim.g.neovide then
  vim.g.neovide_refresh_rate = 75
  vim.opt.linespace = 4
  vim.o.winblend = 10
  vim.o.pumblend = 10
  vim.g.neovide_text_gamma = 0.8
  vim.g.neovide_text_contrast = 0.5
  vim.g.neovide_hide_mouse_when_typing = true

  vim.keymap.set("n", "<C-S-v>", '"+P')
  vim.keymap.set("c", "<C-S-v>", "<C-R>+")
  vim.keymap.set("i", "<C-S-v>", "<C-R>+")
  -- vim.keymap.set("n", "<C-D>", '"+P')
  -- vim.keymap.set("c", "<C-D>", "<C-R>+")
  -- vim.keymap.set("i", "<C-D>", "<C-R>+")
end

-- Formatting
vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.api.nvim_create_autocmd({ "DirChanged" }, {
  pattern = { "*" },
  callback = function() vim.opt.titlestring = string.gsub(vim.fn.getcwd(), "^(.+)/(.+)$", "%2") .. " - Neovim" end,
})
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.c", "*.h" },
  callback = function()
    vim.opt.filetype = "c"
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
  end,
})
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.s", "*.asm" },
  callback = function()
    vim.opt.filetype = "asm"
    vim.opt.tabstop = 8
    vim.opt.shiftwidth = 8
  end,
})
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.php" },
  callback = function()
    vim.opt.filetype = "php"
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
  end,
})

-- Key Mappings
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
