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
vim.opt.title = true
vim.opt.cursorline = true
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
vim.opt.termguicolors = true

-- Formatting
vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.c", "*.php" },
  callback = function()
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
  end,
})

-- Key Mappings
vim.g.mapleader = ","
