--
-- NVIM Plugins
--

-- Lazy plugin manager
-- https://github.com/folke/lazy.nvim
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

require("lazy").setup({
  "EdenEast/nightfox.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-lualine/lualine.nvim",
  "folke/which-key.nvim",
  "nvim-telescope/telescope-ui-select.nvim",
  "nvim-telescope/telescope-file-browser.nvim",
  "nvim-telescope/telescope-frecency.nvim",
  "1riz/telescope-macros.nvim",
  { "nvim-telescope/telescope.nvim", branch = "0.1.x" },
  "neovim/nvim-lspconfig",
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "nvim-treesitter/nvim-treesitter-textobjects",
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
  "lewis6991/gitsigns.nvim",
  { "lukas-reineke/indent-blankline.nvim", main = "ibl" },
  "sitiom/nvim-numbertoggle",
  "nvimdev/hlsearch.nvim",
  "Shatur/neovim-session-manager",
  "ahmedkhalf/project.nvim",
  "goolord/alpha-nvim",
  "gbprod/yanky.nvim",
  "gbprod/substitute.nvim",
  "nvim-pack/nvim-spectre",
  "ThePrimeagen/harpoon",
})

-- Nightfox theme
-- https://github.com/EdenEast/nightfox.nvim
vim.cmd("colorscheme nightfox")

-- Lualine plugin
-- https://github.com/nvim-lualine/lualine.nvim
require("lualine").setup({
  options = {
    icons_enabled = false,
    theme = "nightfox",
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
      "fileformat",
      "filetype",
    },
  },
  tabline = {
    lualine_a = {
      {
        "buffers",
        show_modified_status = false,
        symbols = { alternate_file = "" },
        filetype_names = {
          TelescopePrompt = "",
          spectre_panel = "",
        },
      },
    },
  },
})
vim.opt.showtabline = 0

-- SessionManager plugin
-- https://github.com/Shatur/neovim-session-manager
local session_manager_config = require("session_manager.config")
require("session_manager").setup({
  autoload_mode = session_manager_config.AutoloadMode.Disabled,
  autosave_last_session = false,
})

-- Project plugin
-- https://github.com/ahmedkhalf/project.nvim
require("project_nvim").setup({
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

-- Harpoon plugin
-- https://github.com/ThePrimeagen/harpoon
require("harpoon").setup({
  global_settings = {
    save_on_toggle = true,
  },
})

-- Telescope plugin
-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope-ui-select.nvim
-- https://github.com/nvim-telescope/telescope-file-browser.nvim
-- https://github.com/nvim-telescope/telescope-frecency.nvim
local telescope = require("telescope")
telescope.setup({
  defaults = {
    layout_strategy = "horizontal",
    layout_config = {
      height = 0.87,
      width = 0.87,
      horizontal = { preview_width = 0.5 },
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
  extensions = {
    ["file_browser"] = {
      theme = "ivy",
      hijack_netrw = true,
    },
    ["frecency"] = {
      disable_devicons = true,
      show_scores = true,
    },
  },
})
telescope.load_extension("ui-select")
telescope.load_extension("file_browser")
telescope.load_extension("frecency")
telescope.load_extension("projects")
telescope.load_extension("yank_history")
telescope.load_extension("harpoon")
telescope.load_extension("macros")

-- Treesitter plugin
-- https://github.com/nvim-treesitter/nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust", "php", "bash" },
  sync_install = false,
  auto_install = false,
  highlight = { enable = false },
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

-- Lspconfig plugin
-- https://github.com/neovim/nvim-lspconfig
local lspconfig = require("lspconfig")

-- LuaSnip plugin
-- https://github.com/L3MON4D3/LuaSnip
-- https://github.com/honza/vim-snippets
require("luasnip.loaders.from_snipmate").load({ paths = "./snippets" })
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
local capabilities = require("cmp_nvim_lsp").default_capabilities()
lspconfig.bashls.setup({ capabilities = capabilities })
lspconfig.lua_ls.setup({ capabilities = capabilities })
lspconfig.clangd.setup({ capabilities = capabilities })
lspconfig.rust_analyzer.setup({ capabilities = capabilities })
lspconfig.intelephense.setup({ capabilities = capabilities })

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
dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "-i", "dap" },
}
dap.configurations.c = {
  {
    name = "GDB Local session",
    type = "gdb",
    request = "launch",
    program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = true,
  },
}

-- Nvim-dap-virtual-text plugin
-- https://github.com/theHamsta/nvim-dap-virtual-text
require("nvim-dap-virtual-text").setup({
  commented = true,
  all_frames = true,
})

-- None-ls plugin
-- https://github.com/nvimtools/none-ls.nvim
local null_ls = require("null-ls")
local clang_format_args = "--style=file:" .. vim.fn.stdpath("config") .. "/.clang-format"
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.shfmt.with({ extra_args = { "-i", "2", "-ci", "-sr" } }),
    null_ls.builtins.formatting.clang_format.with({ extra_args = { clang_format_args } }),
    null_ls.builtins.formatting.rustfmt.with({ extra_args = { "--edition", "2021" } }),
    null_ls.builtins.formatting.phpcsfixer.with({ extra_args = { "--rules=@PSR12" } }),
    null_ls.builtins.diagnostics.phpcs.with({ extra_args = { "--standard=PSR12" } }),
  },
})

-- Trouble plugin
-- https://github.com/folke/trouble.nvim
require("trouble").setup({
  icons = false,
  fold_open = "v",
  fold_closed = ">",
  indent_lines = false,
  signs = {
    error = "error",
    warning = "warn",
    hint = "hint",
    information = "info",
  },
  use_diagnostic_signs = false,
})

-- Gitsigns plugin
-- https://github.com/lewis6991/gitsigns.nvim
require("gitsigns").setup()

-- IndentBlankline plugin
-- https://github.com/lukas-reineke/indent-blankline.nvim
require("ibl").setup({
  enabled = false,
  scope = { show_start = false, show_end = false },
})

-- Numbertoggle plugin
-- https://github.com/sitiom/nvim-numbertoggle

-- Hlsearch plugin
-- https://github.com/nvimdev/hlsearch.nvim
require("hlsearch").setup()

-- Spectre plugin
-- https://github.com/nvim-pack/nvim-spectre
require("spectre").setup({
  color_devicons = false,
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

-- Alpha plugin
-- https://github.com/goolord/alpha-nvim
local alpha = require("alpha")
local alpha_theme = require("alpha.themes.startify")
alpha_theme.nvim_web_devicons.enabled = false
alpha_theme.section.header.val = require("logo")
alpha_theme.section.top_buttons.val = {
  alpha_theme.button("n", ">  New file", "<cmd>enew<cr>"),
  alpha_theme.button("f", ">  Find files", "<cmd>Telescope find_files<cr>"),
  alpha_theme.button("p", ">  Open project", "<cmd>Telescope projects<cr>"),
  alpha_theme.button("s", ">  Load saved session", "<cmd>SessionManager! load_session<cr>"),
}
alpha_theme.section.bottom_buttons.val = {
  alpha_theme.button("q", ">  Exit", "<cmd>qa<cr>"),
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
