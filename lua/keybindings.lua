--
-- NVIM Key bindings
--

local catppuccin = require("catppuccin")
local codecompanion = require("codecompanion")
local dap = require("dap")
local dap_widgets = require("dap.ui.widgets")
local gitsigns = require("gitsigns")
local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")
local lazy = require("lazy")
local luasnip = require("luasnip")
local ntree = require("nvim-tree.api")
local session_manager = require("session_manager")
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

wk.register({
  ["<C-Del>"] = { "<cmd>Bdelete<cr>", "Delete current buffer" },
  ["<C-PageDown>"] = { "<cmd>bn<cr>", "Go to next buffer" },
  ["<C-PageUp>"] = { "<cmd>bp<cr>", "Go to previous buffer" },
  ["<C-Left>"] = { "<C-w>h", "Go to left window" },
  ["<C-Down>"] = { "<C-w>j", "Go to lower window" },
  ["<C-Up>"] = { "<C-w>k", "Go to upper window" },
  ["<C-Right>"] = { "<C-w>l", "Go to right window" },
  ["<C-s>"] = { "<cmd>wa<cr>", "Write all changed buffers" },
  ["<C-q>"] = { "<cmd>qa<cr>", "Exit Neovim" },
  ["<C-n>"] = { "<cmd>vnew<cr>", "New window" },
  ["<C-a>"] = { "ggVG", "Select all current buffer" },
  ["<M-r>"] = { "<cmd>set relativenumber!<cr>", "Toggle relative line numbers" },
  ["<M-b>"] = { "<cmd>set showtabline=2<cr>", "Show tabline" },
  ["<S-M-b>"] = { "<cmd>set showtabline=0<cr>", "Hide tabline" },
  ["<M-i>"] = { "<cmd>IBLToggle<cr>", "Toggle indentation guides" },
  ["<S-M-i>"] = { "<cmd>IBLToggleScope<cr>", "Toggle scope guides" },
  ["<leader><leader>"] = { "<cmd>WhichKey<cr>", "Show all key bindings" },
})

wk.register({
  p = { "<Plug>(YankyPutAfter)", "Put the text from register after the cursor" },
  P = { "<Plug>(YankyPutBefore)", "Put the text from register before the cursor" },
  gp = { "<Plug>(YankyGPutAfter)", "Like 'p' but leave the cursor after the new text" },
  gP = { "<Plug>(YankyGPutBefore)", "Like 'P' but leave the cursor after the new text" },
}, { mode = { "n", "x" } })

wk.register({
  ["<M-n>"] = { "<Plug>(YankyCycleForward)", "Cycle forward through the yank history" },
  ["<M-p>"] = { "<Plug>(YankyCycleBackward)", "Cycle backwards through the yank history" },
})

wk.register({
  s = { function() substitute.operator() end, "Substitute text with register" },
  ss = { function() substitute.line() end, "Substitute line with register" },
  S = { function() substitute.eol() end, "Substitute to end of line with register" },
  sx = { function() substitute_exchange.operator() end, "Exchange selected text" },
  sxx = { function() substitute_exchange.line() end, "Exchange selected lines" },
})

wk.register({
  s = { function() substitute.visual() end, "Substitute selection with register contents" },
  X = { function() substitute_exchange.visual() end, "Exchange selections" },
}, { mode = { "x" } })

wk.register({
  ["<M-m>"] = { function() harpoon_mark.add_file() end, "Mark file" },
  ["<M-h>"] = { function() harpoon_ui.toggle_quick_menu() end, "View all project marks" },
  ["<M-Right>"] = { function() harpoon_ui.nav_next() end, "Navigates to next mark" },
  ["<M-Left>"] = { function() harpoon_ui.nav_prev() end, "Navigates to previous mark" },
})

wk.register({
  o = { function() telescope.extensions.frecency.frecency() end, "Open recent files" },
  e = { function() telescope.extensions.file_browser.file_browser() end, "File browser" },
  p = { function() telescope.extensions.projects.projects({ layout_config = { height = 0.50 } }) end, "Project browser" },
  b = { function() telescope_builtin.buffers() end, "List open buffers" },
  f = { function() telescope_builtin.find_files() end, "Find files" },
  s = { function() session_manager.load_session(true) end, "List saved sessions" },
  y = { function() telescope.extensions.yank_history.yank_history() end, "Show yank history" },
  m = { function() telescope.extensions.macros.macros() end, "Show saved macros" },
  g = { function() telescope_builtin.live_grep() end, "Search string in files" },
  h = { function() telescope.extensions.harpoon.marks() end, "Show currents marks" },
  t = { function() telescope_builtin.help_tags() end, "Show help tags" },
  d = { function() ntree.tree.toggle() end, "Explore directories" },
  ["<space>"] = { function() telescope_builtin.builtin() end, "Show all pickers" },
}, { prefix = "<space>" })

wk.register({
  r = {
    name = "refactor",
    r = { function() spectre.toggle() end, "Toggle search panel" },
    w = { function() spectre.open_visual({ select_word = true }) end, "Search current word" },
    f = { function() spectre.open_file_search({ select_word = true }) end, "Search on current file" },
  },
}, { prefix = "<leader>" })

wk.register({
  ["<C-h>"] = { function() vim.lsp.buf.hover() end, "Display symbol information" },
})

wk.register({
  c = {
    name = "coding",
    c = { function() vim.lsp.buf.code_action() end, "Execute code actions" },
    h = { function() vim.lsp.buf.hover() end, "Display symbol information" },
    f = { function() vim.lsp.buf.format() end, "Format current buffer" },
    r = { function() vim.lsp.buf.references() end, "List symbol references" },
    i = { function() vim.lsp.buf.implementation() end, "List symbol implementations" },
    d = { function() vim.lsp.buf.definition() end, "Jump to the definition of the symbol" },
    t = { function() vim.lsp.buf.type_definition() end, "Jump to the definition of the type of the symbol" },
    n = { function() vim.lsp.buf.rename() end, "Rename symbol in current buffer" },
    s = { function() telescope_builtin.treesitter() end, "Search syntax tree symbols" },
  },
}, { prefix = "<leader>" })

wk.register({
  name = "snippets",
  ["<C-k>"] = { function() luasnip.expand() end, "Expand snippet" },
  ["<C-l>"] = { function() luasnip.jump(1) end, "Jump forward" },
  ["<C-j>"] = { function() luasnip.jump(-1) end, "Jump backward" },
  ["<C-e>"] = {
    function()
      if luasnip.choice_active() then luasnip.change_choice(1) end
    end,
    "Change the active choice",
  },
}, { mode = { "i", "s" } })

wk.register({
  x = {
    name = "diagnostics",
    x = { function() trouble.toggle("diagnostics") end, "Toggle diagnostics list" },
    s = { function() trouble.toggle("symbols") end, "Toggle symbols list" },
    d = { function() trouble.toggle("lsp") end, "Toggle definitions list" },
    q = { function() trouble.toggle("quickfix") end, "Toggle errors list" },
    l = { function() trouble.toggle("loclist") end, "Toggle window location list" },
  },
}, { prefix = "<leader>" })

wk.register({
  z = {
    name = "copilot",
    z = { "<cmd>CodeCompanionChat Toggle<CR>", "Toggle chat" },
    e = { function() codecompanion.prompt("explain") end, "Explain code" },
    d = { function() codecompanion.prompt("lsp") end, "Explain diagnostics" },
    f = { function() codecompanion.prompt("fix") end, "Fix code" },
    t = { function() codecompanion.prompt("tests") end, "Generate tests" },
    c = { function() codecompanion.prompt("commit") end, "Generate commit message" },
    a = { "<cmd>CodeCompanionActions<CR>", "Open actions menu" },
  },
}, { mode = { "n", "v" }, prefix = "<leader>" })

wk.register({
  d = {
    name = "debug",
    d = { function() dap.step_over() end, "Step into a function if possible" },
    q = { function() dap.step_out() end, "Step out of a function if possible" },
    r = { function() dap.continue() end, "Launch or resume debug session" },
    b = { function() dap.toggle_breakpoint() end, "Toggle breakpoint" },
    i = { function() dap.repl.open() end, "Inspect the state" },
    h = { function() dap_widgets.hover() end, "View the value for the expression" },
    f = { function() dap_widgets.centered_float(dap_widgets.frames) end, "View the current frames" },
    s = { function() dap_widgets.centered_float(dap_widgets.scopes) end, "View the current scopes" },
  },
}, { prefix = "<leader>" })

wk.register({
  g = {
    name = "git",
    g = { function() gitsigns.toggle_signs() end, "Toggle signs column" },
    d = { function() gitsigns.diffthis() end, "Show differences" },
    l = { function() gitsigns.toggle_current_line_blame() end, "Toggle current line blame" },
    r = { function() gitsigns.reset_hunk() end, "Reset hunk" },
    R = { function() gitsigns.reset_buffer() end, "Reset buffer" },
    c = { function() telescope_builtin.git_commits() end, "List commits" },
    b = { function() telescope_builtin.git_branches() end, "List branches" },
    s = { function() telescope_builtin.git_status() end, "List current changes" },
    t = { function() telescope_builtin.git_stash() end, "List stash items" },
  },
}, { prefix = "<leader>" })

wk.register({
  s = {
    name = "session",
    o = { function() session_manager.load_session(true) end, "Select and load session" },
    s = { function() session_manager.save_current_session() end, "Save session for the current directory" },
    l = { function() session_manager.load_current_dir_session(true) end, "Load session for the current directory" },
    d = { function() session_manager.delete_session() end, "Select and delete session" },
  },
}, { prefix = "<leader>" })

wk.register({
  l = {
    name = "plugins",
    l = { function() lazy.home() end, "Got to plugins list" },
    u = { function() lazy.update() end, "Update plugins" },
  },
}, { prefix = "<leader>" })

wk.register({
  t = {
    name = "themes",
    t = {
      function()
        catppuccin.options.transparent_background = not catppuccin.options.transparent_background
        catppuccin.compile()
        vim.cmd.colorscheme(vim.g.colors_name)
      end,
      "Toggle between transparent background",
    },
  },
}, { prefix = "<leader>" })
