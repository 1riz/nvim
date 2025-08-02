--
-- NVIM Settings
--

-- General
vim.opt.grepprg = "rg -uuu --glob '!**/.git/*' --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.shada = "!,'100,<50,s10,h"

-- UI
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.showtabline = 0
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.list = true
vim.opt.listchars = "tab:▸ ,trail:▫"
vim.opt.scrolloff = 1
vim.opt.pumheight = 30
vim.opt.wildoptions = "fuzzy,pum,tagfile"
vim.opt.whichwrap = "b,s,<,>"
vim.opt.timeoutlen = 500
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.sessionoptions = "buffers,curdir"
vim.opt.mousemodel = "extend"

-- Formatting
vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Key Mappings
vim.keymap.set("n", "<C-Del>", "<cmd>bd<cr>")
vim.keymap.set("n", "<C-PageDown>", "<cmd>bn<cr>")
vim.keymap.set("n", "<C-PageUp>", "<cmd>bp<cr>")
vim.keymap.set("n", "<C-Left>", "<C-w>h")
vim.keymap.set("n", "<C-Down>", "<C-w>j")
vim.keymap.set("n", "<C-Up>", "<C-w>k")
vim.keymap.set("n", "<C-Right>", "<C-w>l")
vim.keymap.set("n", "<C-s>", "<cmd>wa<cr>")
vim.keymap.set("n", "<C-q>",  "<cmd>qa<cr>")
vim.keymap.set("n", "<C-n>",  "<cmd>new<cr>")
vim.keymap.set("n", "<C-l>",  "<cmd>vnew<cr>")
vim.keymap.set("n", "<C-Enter>",  "<cmd><cr>")
vim.keymap.set("n", "<C-a>",  "ggVG")
vim.keymap.set("n", "<M-r>",  "<cmd>set relativenumber!<cr>")
vim.keymap.set("n", "<M-b>",  "<cmd>set showtabline=2<cr>")
vim.keymap.set("n", "<S-M-b>",  "<cmd>set showtabline=0<cr>")

-- Colors
vim.cmd("colorscheme habamax")
