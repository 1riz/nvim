--
-- NVIM Plugins
--

-- Lazy plugin manager
-- https://github.com/folke/lazy.nvim
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

require("lazy").setup({
  spec = {
    { "projekt0n/github-nvim-theme", priority = 1000 },
    "nvim-tree/nvim-web-devicons",
    "nvim-tree/nvim-tree.lua",
    "nvim-lua/plenary.nvim",
    "nvim-lualine/lualine.nvim",
    { "akinsho/bufferline.nvim", version = "*" },
    "folke/which-key.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-frecency.nvim",
    { "nvim-telescope/telescope.nvim", branch = "0.1.x" },
    "neovim/nvim-lspconfig",
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    "nvim-treesitter/nvim-treesitter-textobjects",
    "rafamadriz/friendly-snippets",
    { "L3MON4D3/LuaSnip", version = "v2.*" },
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
    "numToStr/Comment.nvim",
    "windwp/nvim-autopairs",
    "kylechui/nvim-surround",
    "mfussenegger/nvim-dap",
    "theHamsta/nvim-dap-virtual-text",
    "nvimtools/none-ls.nvim",
    "folke/trouble.nvim",
    "olimorris/codecompanion.nvim",
    "lewis6991/gitsigns.nvim",
    "famiu/bufdelete.nvim",
    "nvimdev/hlsearch.nvim",
    "ahmedkhalf/project.nvim",
    "goolord/alpha-nvim",
    "gbprod/yanky.nvim",
    "gbprod/substitute.nvim",
    "nvim-pack/nvim-spectre",
    "MeanderingProgrammer/render-markdown.nvim",
  },
  rocks = {
    enabled = false,
  },
})

-- GitHub theme
-- https://github.com/projekt0n/github-nvim-theme
require("github-theme").setup({
  options = {
    transparent = true,
    terminal_colors = true,
  },
})
vim.cmd.colorscheme("github_dark_default")

-- Nvim-web-devicons plugin
-- https://github.com/nvim-tree/nvim-web-devicons
require("nvim-web-devicons").setup()

-- Nvim-tree plugin
-- https://github.com/nvim-tree/nvim-tree.lua
require("nvim-tree").setup({
  hijack_cursor = true,
  hijack_netrw = false,
  sync_root_with_cwd = true,
  select_prompts = true,
  view = {
    width = 35,
  },
  renderer = {
    root_folder_label = false,
  },
  git = {
    enable = false,
  },
  filters = {
    git_ignored = false,
    dotfiles = false,
    custom = { "^.git$" },
  },
})

-- Lualine plugin
-- https://github.com/nvim-lualine/lualine.nvim
local lualine = require("lualine")
local lualine_codecompanion = { sections = { lualine_a = { function() return [[OpenAI]] end } }, filetypes = { "codecompanion" } }
local lualine_trouble = { sections = { lualine_a = { function() return [[Diagnostics]] end } }, filetypes = { "trouble" } }
lualine.setup({
  options = {
    theme = "auto",
    component_separators = { left = "", right = "|" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { {
      "mode",
      fmt = function(s) return string.sub(s, 1, 3) end,
    } },
    lualine_x = {
      { function() return string.gsub(vim.fn.getcwd(), "^(.+)/(.+)$", "%2") end },
      "encoding",
      { "fileformat", icons_enabled = false },
      "filetype",
    },
  },
  extensions = { "nvim-tree", lualine_trouble, lualine_codecompanion },
})

-- Bufferline plugin
-- https://github.com/akinsho/bufferline.nvim
local bufferline = require("bufferline")
bufferline.setup({
  options = {
    style_preset = bufferline.style_preset.no_italic,
    always_show_bufferline = false,
    close_command = "Bdelete! %d",
    right_mouse_command = "Bdelete! %d",
    show_buffer_close_icons = false,
    show_close_icon = false,
    indicator = {
      style = "none",
    },
    offsets = {
      {
        filetype = "NvimTree",
        text = function() return string.gsub(vim.fn.getcwd(), "^(.+)/(.+)$", "%2") end,
        text_align = "left",
        highlight = "Directory",
      },
    },
  },
})

-- Project plugin
-- https://github.com/ahmedkhalf/project.nvim
require("project_nvim").setup({
  detection_methods = { "pattern" },
  patterns = { ".git" },
})

-- Yanky plugin
-- https://github.com/gbprod/yanky.nvim
require("yanky").setup({
  ring = {
    history_length = 250,
  },
  highlight = {
    on_put = false,
    on_yank = false,
  },
})

-- Substitute plugin
-- https://github.com/gbprod/substitute.nvim
require("substitute").setup({
  on_substitute = require("yanky.integration").substitute(),
  highlight_substituted_text = {
    enabled = false,
  },
})

-- Telescope plugin
-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope-ui-select.nvim
-- https://github.com/nvim-telescope/telescope-frecency.nvim
local telescope = require("telescope")
telescope.setup({
  defaults = {
    layout_strategy = "horizontal",
    layout_config = {
      height = 0.8,
      width = 0.9,
      horizontal = { preview_width = 0.6 },
    },
    dynamic_preview_title = true,
    results_title = false,
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob",
      "!**/.git/*",
    },
  },
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
    registers = {
      layout_strategy = "center",
      layout_config = { height = 0.25, width = 0.75 },
    },
  },
})
telescope.load_extension("ui-select")
telescope.load_extension("frecency")
telescope.load_extension("projects")
telescope.load_extension("yank_history")

-- Treesitter plugin
-- https://github.com/nvim-treesitter/nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "yaml", "php", "bash" },
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<M-v>",
      node_incremental = "<S-M-Up>",
      scope_incremental = false,
      node_decremental = "<S-M-Down>",
    },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = { query = "@function.outer", desc = "Select outer part of a function region" },
        ["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
      },
    },
    move = {
      enable = true,
      goto_next_start = {
        ["<M-Down>"] = { query = "@function.outer", desc = "Go to next function start" },
      },
      goto_previous_start = {
        ["<M-Up>"] = { query = "@function.outer", desc = "Go to previous function start" },
      },
    },
  },
})
vim.opt.foldenable = false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- LuaSnip plugin
-- https://github.com/L3MON4D3/LuaSnip
-- https://github.com/rafamadriz/friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()
local luasnip = require("luasnip")

-- Cmp plugin
-- https://github.com/hrsh7th/nvim-cmp
-- https://github.com/saadparwaiz1/cmp_luasnip
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-o>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({ { name = "nvim_lsp" }, { name = "luasnip" } }),
})
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Lspconfig plugin
-- https://github.com/neovim/nvim-lspconfig
local lspconfig = require("lspconfig")
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
vim.lsp.enable({ "bashls", "lua_ls", "clangd", "intelephense" })
vim.lsp.config("bashls", { capabilities = cmp_capabilities })
vim.lsp.config("lua_ls", { capabilities = cmp_capabilities })
vim.lsp.config("clangd", { capabilities = cmp_capabilities })
vim.lsp.config("intelephense", {
  capabilities = cmp_capabilities,
  root_dir = function(bufnr, on_dir) return on_dir(vim.fn.getcwd()) end,
  init_options = { globalStoragePath = "/tmp/intelephense", licenseKey = os.getenv("INTELEPHENSE_KEY") },
  settings = { intelephense = { files = { maxSize = 10000000 } } },
})

-- Autopairs plugin
-- https://github.com/windwp/nvim-autopairs
require("nvim-autopairs").setup({
  enable_check_bracket_line = false,
  check_ts = true,
})
cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

-- Surround plugin
-- https://github.com/kylechui/nvim-surround
require("nvim-surround").setup()

-- Comment plugin
-- https://github.com/numToStr/Comment.nvim
require("Comment").setup()

-- Nvim-dap plugin
-- https://github.com/mfussenegger/nvim-dap
local dap = require("dap")
dap.adapters.lldb = {
  type = "executable",
  command = "lldb-dap-19",
  name = "lldb",
}
dap.configurations.c = {
  {
    name = "LLDB Local session",
    type = "lldb",
    request = "launch",
    program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = true,
  },
}
local sign = vim.fn.sign_define
sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
sign("DapBreakpointRejected", { text = "x", texthl = "DapBreakpoint", linehl = "", numhl = "" })
sign("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" })
sign("DapStopped", { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" })

-- Nvim-dap-virtual-text plugin
-- https://github.com/theHamsta/nvim-dap-virtual-text
require("nvim-dap-virtual-text").setup({
  commented = true,
  all_frames = true,
})

-- None-ls plugin
-- https://github.com/nvimtools/none-ls.nvim
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.shfmt.with({ extra_args = { "-i", "2", "-ci", "-sr" } }),
    null_ls.builtins.formatting.clang_format.with({
      extra_args = { "--style=file:" .. vim.fn.stdpath("config") .. "/.clang-format" },
      filetypes = { "c" },
    }),
    null_ls.builtins.formatting.phpcbf.with({ extra_args = { "--standard=PSR12" } }),
    null_ls.builtins.diagnostics.phpcs.with({ extra_args = { "--standard=PSR12" } }),
  },
})

-- Trouble plugin
-- https://github.com/folke/trouble.nvim
require("trouble").setup({
  modes = {
    symbols = {
      win = { position = "right", size = { width = 40 } },
    },
  },
})

-- Codecompanion plugin
-- https://github.com/olimorris/codecompanion.nvim
require("codecompanion").setup({
  strategies = {
    chat = { adapter = "openai" },
    inline = { adapter = "openai" },
  },
  adapters = {
    http = {
      openai = function()
        return require("codecompanion.adapters").extend("openai", {
          env = { api_key = os.getenv("OPENAI_API_KEY") },
          schema = { model = { default = "gpt-4.1" } },
        })
      end,
    },
  },
  display = {
    chat = {
      show_token_count = false,
      render_headers = false,
      start_in_insert_mode = true,
    },
  },
})

-- Gitsigns plugin
-- https://github.com/lewis6991/gitsigns.nvim
require("gitsigns").setup()

-- Bufdelete plugin
-- https://github.com/famiu/bufdelete.nvim

-- Hlsearch plugin
-- https://github.com/nvimdev/hlsearch.nvim
require("hlsearch").setup()

-- Spectre plugin
-- https://github.com/nvim-pack/nvim-spectre
require("spectre").setup({
  open_cmd = "bo 25new",
  highlight = { headers = "EndOfBuffer" },
  mapping = {
    ["run_current_replace"] = {
      map = "<leader>r",
      cmd = "<cmd>lua require('spectre.actions').run_current_replace()<cr>",
      desc = "replace current line",
    },
  },
  default = {
    find = { cmd = "rg", options = {} },
  },
})

-- Render-markdown plugin
-- https://github.com/MeanderingProgrammer/render-markdown.nvim
require("render-markdown").setup({
  file_types = { "markdown", "codecompanion" },
  latex = { enabled = false },
  html = { enabled = false },
})

-- Alpha plugin
-- https://github.com/goolord/alpha-nvim
local alpha = require("alpha")
local alpha_theme = require("alpha.themes.startify")
alpha_theme.section.header.val = require("logo")
alpha_theme.section.top_buttons.val = {
  alpha_theme.button("n", "  New file", "<cmd>enew<cr>"),
  alpha_theme.button("f", "󰈞  Find files", "<cmd>Telescope find_files<cr>"),
  alpha_theme.button("p", "  Open project", "<cmd>Telescope projects<cr>"),
}
alpha_theme.section.bottom_buttons.val = {
  alpha_theme.button("q", "󰿅  Exit", "<cmd>qa<cr>"),
}
local version = vim.version()
local nvim_version = "NVIM v" .. version.major .. "." .. version.minor .. "." .. version.patch
alpha_theme.section.footer.val = {
  {
    type = "group",
    val = {
      { type = "padding", val = 2 },
      { type = "text", val = nvim_version, opts = { hl = "Type" } },
    },
  },
}
alpha.setup(alpha_theme.config)
