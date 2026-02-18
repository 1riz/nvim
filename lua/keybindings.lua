--
-- NVIM Key bindings
--

local codecompanion = require("codecompanion")
local dap = require("dap")
local dap_widgets = require("dap.ui.widgets")
local gitsigns = require("gitsigns")
local lazy = require("lazy")
local luasnip = require("luasnip")
local ntree = require("nvim-tree.api")
local spectre = require("spectre")
local substitute = require("substitute")
local substitute_exchange = require("substitute.exchange")
local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local trouble = require("trouble")

-- WhichKey plugin
-- https://github.com/folke/which-key.nvim
local wk = require("which-key")
wk.setup({
  notify = false,
  icons = {
    mappings = false,
  },
})
local s = "<space>"
local l = "<leader>"

-- Generic mappings
wk.add({
  { "<C-H>", "<cmd>Bdelete<cr>", desc = "Delete current buffer" },
  { "<C-PageDown>", "<cmd>bn<cr>", desc = "Go to next buffer" },
  { "<C-PageUp>", "<cmd>bp<cr>", desc = "Go to previous buffer" },
  { "<C-Left>", "<C-w>h", desc = "Go to left window" },
  { "<C-Down>", "<C-w>j", desc = "Go to lower window" },
  { "<C-Up>", "<C-w>k", desc = "Go to upper window" },
  { "<C-Right>", "<C-w>l", desc = "Go to right window" },
  { "<C-s>", "<cmd>wa<cr>", desc = "Write all changed buffers" },
  { "<C-q>", "<cmd>qa<cr>", desc = "Exit Neovim" },
  { "<C-M-q>", "<cmd>q<cr>", desc = "Quit current window" },
  { "<C-n>", "<cmd>new<cr>", desc = "New horizontal window" },
  { "<C-l>", "<cmd>vnew<cr>", desc = "New vertical window" },
  { "<M-Enter>", "<cmd>terminal<cr>", desc = "New terminal" },
  { "<C-a>", "ggVG", desc = "Select all current buffer" },
  { "<M-r>", "<cmd>set relativenumber!<cr>", desc = "Toggle relative line numbers" },
  { "<M-b>", "<cmd>set showtabline=2<cr>", desc = "Show tabline" },
  { "<S-M-b>", "<cmd>set showtabline=0<cr>", desc = "Hide tabline" },
  { l .. l, "<cmd>WhichKey<cr>", desc = "Show all key bindings" },
})

-- Generic mappings using <space>
wk.add({
  { s .. "o", function() telescope.extensions.frecency.frecency() end, desc = "Open recent files" },
  { s .. "p", function() telescope.extensions.projects.projects({ layout_config = { height = 0.50 } }) end, desc = "Project browser" },
  { s .. "b", function() telescope_builtin.buffers() end, desc = "List open buffers" },
  { s .. "f", function() telescope_builtin.find_files() end, desc = "Find files" },
  { s .. "y", function() telescope.extensions.yank_history.yank_history() end, desc = "Show yank history" },
  { s .. "g", function() telescope_builtin.live_grep() end, desc = "Search string in files" },
  { s .. "t", function() telescope_builtin.help_tags() end, desc = "Show help tags" },
  { s .. "d", function() ntree.tree.toggle() end, desc = "Explore directories" },
  { s .. s, function() telescope_builtin.builtin() end, desc = "Show all pickers" },
})

-- Coding mappings
wk.add({
  { l .. "c", group = "coding" },
  { l .. "cc", function() vim.lsp.buf.code_action() end, desc = "Execute code actions" },
  { l .. "ch", function() vim.lsp.buf.hover() end, desc = "Display symbol information" },
  { l .. "cf", function() vim.lsp.buf.format() end, desc = "Format current buffer" },
  { l .. "cr", function() vim.lsp.buf.references() end, desc = "List symbol references" },
  { l .. "ci", function() vim.lsp.buf.implementation() end, desc = "List symbol implementations" },
  { l .. "cd", function() vim.lsp.buf.definition() end, desc = "Jump to the definition of the symbol" },
  { l .. "ct", function() vim.lsp.buf.type_definition() end, desc = "Jump to the definition of the type of the symbol" },
  { l .. "cn", function() vim.lsp.buf.rename() end, desc = "Rename symbol in current buffer" },
  { l .. "cs", function() telescope_builtin.treesitter() end, desc = "Search syntax tree symbols" },
})

wk.add({
  { "<M-h>", function() vim.lsp.buf.hover() end, desc = "Display symbol information" },
})

wk.add({
  { l .. "x", group = "diagnostics" },
  { l .. "xx", function() trouble.toggle("diagnostics") end, desc = "Toggle diagnostics list" },
  { l .. "xs", function() trouble.toggle("symbols") end, desc = "Toggle symbols list" },
  { l .. "xd", function() trouble.toggle("lsp") end, desc = "Toggle definitions list" },
  { l .. "xq", function() trouble.toggle("quickfix") end, desc = "Toggle errors list" },
  { l .. "xl", function() trouble.toggle("loclist") end, desc = "Toggle window location list" },
})

wk.add({
  { l .. "d", group = "debug" },
  { l .. "dd", function() dap.step_over() end, desc = "Step into a function if possible" },
  { l .. "dq", function() dap.step_out() end, desc = "Step out of a function if possible" },
  { l .. "dr", function() dap.continue() end, desc = "Launch or resume debug session" },
  { l .. "db", function() dap.toggle_breakpoint() end, desc = "Toggle breakpoint" },
  { l .. "di", function() dap.repl.open() end, desc = "Inspect the state" },
  { l .. "dh", function() dap_widgets.hover() end, desc = "View the value for the expression" },
  { l .. "df", function() dap_widgets.centered_float(dap_widgets.frames) end, desc = "View the current frames" },
  { l .. "ds", function() dap_widgets.centered_float(dap_widgets.scopes) end, desc = "View the current scopes" },
})

-- Control version mappings
wk.add({
  { l .. "g", group = "git" },
  { l .. "gg", function() gitsigns.toggle_signs() end, desc = "Toggle signs column" },
  { l .. "gd", function() gitsigns.diffthis() end, desc = "Show differences" },
  { l .. "gl", function() gitsigns.toggle_current_line_blame() end, desc = "Toggle current line blame" },
  { l .. "gr", function() gitsigns.reset_hunk() end, desc = "Reset hunk" },
  { l .. "gR", function() gitsigns.reset_buffer() end, desc = "Reset buffer" },
  { l .. "gc", function() telescope_builtin.git_commits() end, desc = "List commits" },
  { l .. "gb", function() telescope_builtin.git_branches() end, desc = "List branches" },
  { l .. "gs", function() telescope_builtin.git_status() end, desc = "List current changes" },
  { l .. "gt", function() telescope_builtin.git_stash() end, desc = "List stash items" },
})

-- Search and replace mappings
wk.add({
  {
    mode = { "n", "x" },
    { "p", "<Plug>(YankyPutAfter)", desc = "Put the text from register after the cursor" },
    { "P", "<Plug>(YankyPutBefore)", desc = "Put the text from register before the cursor" },
    { "gp", "<Plug>(YankyGPutAfter)", desc = "Like 'p' but leave the cursor after the new text" },
    { "gP", "<Plug>(YankyGPutBefore)", desc = "Like 'P' but leave the cursor after the new text" },
  },
})

wk.add({
  { "<M-n>", "<Plug>(YankyCycleForward)", desc = "Cycle forward through the yank history" },
  { "<M-p>", "<Plug>(YankyCycleBackward)", desc = "Cycle backwards through the yank history" },
  { "s", function() substitute.operator() end, desc = "Substitute text with register" },
  { "ss", function() substitute.line() end, desc = "Substitute line with register" },
  { "S", function() substitute.eol() end, desc = "Substitute to end of line with register" },
  { "sx", function() substitute_exchange.operator() end, desc = "Exchange selected text" },
  { "sxx", function() substitute_exchange.line() end, desc = "Exchange selected lines" },
})

wk.add({
  {
    mode = { "x" },
    { "s", function() substitute.visual() end, desc = "Substitute selection with register contents" },
    { "X", function() substitute_exchange.visual() end, desc = "Exchange selections" },
  },
})

wk.add({
  { l .. "r", group = "refactor" },
  { l .. "rr", function() spectre.toggle() end, desc = "Toggle search panel" },
  { l .. "rw", function() spectre.open_visual({ select_word = true }) end, desc = "Search current word" },
  { l .. "rf", function() spectre.open_file_search({ select_word = true }) end, desc = "Search on current file" },
})

-- Snippets mappings
wk.add({
  {
    mode = { "i", "s" },
    { "<C-k>", function() luasnip.expand() end, desc = "Expand snippet" },
    { "<C-l>", function() luasnip.jump(1) end, desc = "Jump forward" },
    { "<C-j>", function() luasnip.jump(-1) end, desc = "Jump backward" },
    {
      "<C-e>",
      function()
        if luasnip.choice_active() then luasnip.change_choice(1) end
      end,
      desc = "Change the active choice",
    },
  },
})

-- AI assistant mappings
wk.add({
  { l .. "z", group = "copilot" },
  {
    mode = { "n", "v" },
    { l .. "zz", "<cmd>CodeCompanionChat Toggle<CR>", desc = "Toggle chat" },
    { l .. "ze", function() codecompanion.prompt("explain") end, desc = "Explain code" },
    { l .. "zd", function() codecompanion.prompt("lsp") end, desc = "Explain diagnostics" },
    { l .. "zf", function() codecompanion.prompt("fix") end, desc = "Fix code" },
    { l .. "zt", function() codecompanion.prompt("tests") end, desc = "Generate tests" },
    { l .. "zc", function() codecompanion.prompt("commit") end, desc = "Generate commit message" },
    { l .. "za", "<cmd>CodeCompanionActions<CR>", desc = "Open actions menu" },
  },
})

-- Plugins manager mappings
wk.add({
  { l .. "l", group = "plugins" },
  { l .. "ll", function() lazy.home() end, desc = "Got to plugins list" },
  { l .. "lu", function() lazy.update() end, desc = "Update plugins" },
})
