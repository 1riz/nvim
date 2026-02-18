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
vim.opt.relativenumber = false
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
    vim.opt.expandtab = false
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
  end,
})
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.s", "*.asm" },
  callback = function()
    vim.opt.filetype = "asm"
    vim.opt.expandtab = false
    vim.opt.tabstop = 8
    vim.opt.shiftwidth = 8
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
