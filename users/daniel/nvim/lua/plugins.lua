require("lazy").setup({
  { "webhooked/kanso.nvim", lazy = false, priority = 1000 },
  { "L3MON4D3/LuaSnip" },
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason-lspconfig.nvim" },
  { "williamboman/mason.nvim" },
  { "saghen/blink.cmp" },
  { "echasnovski/mini.pick" },
  { "nvim-tree/nvim-web-devicons" },
  { "nvimdev/dashboard-nvim" },
  { "nvim-tree/nvim-tree.lua" },
  { "catgoose/nvim-colorizer.lua" },
  { "lervag/vimtex" },
  { "iurimateus/luasnip-latex-snippets.nvim" },
}, {
  checker = { enabled = false },
})

-- Plugin setup
require("kanso").setup({ theme = "pearl" })
require("blink.cmp").setup({
  snippets = {
    expand = function(snippet)
      require('luasnip.loaders.from_vscode').lazy_load()
      require('luasnip.loaders.from_vscode').lazy_load({
        paths = '~/.config/nvim/snippets',
      })
      require('luasnip').lsp_expand(snippet)
    end
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  fuzzy = { implementation = "lua" }
})
require("luasnip-latex-snippets").setup()
require("luasnip").config.setup({ enable_autosnippets = true })
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "cssls",
    "html",
    "clangd",
    "pyright"
  },
  handlers = {
    function(server)
      require("lspconfig")[server].setup {
        capabilities = require("blink.cmp").get_lsp_capabilities()
      }
    end
  }
})
require("dashboard").setup({
  theme = 'doom',
  config = {
    header = {
      '',
      '   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣭⣿⣶⣿⣦⣼⣆         ',
      '    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ',
      '          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷⠄⠄⠄⠄⠻⠿⢿⣿⣧⣄     ',
      '           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ',
      '          ⢠⣿⣿⣿⠈  ⠡⠌⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ',
      '   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘⠄ ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ',
      '  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ',
      ' ⣠⣿⠿⠛⠄⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ',
      ' ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇⠄⠛⠻⢷⣄ ',
      '      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ', '       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ',
      '',
    },
    center = {
      {
        desc = 'New File',
        group = 'Label',
        action = 'enew',
        key = 'n',
      },
      {
        desc = 'Update',
        group = 'Label',
        action = 'Lazy update',
        key = 'u',
      },
    },
    footer = {
      "The one true text editor."
    }
  }
})
require("nvim-tree").setup({
  renderer = {
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "",
          unmerged = "",
          renamed = "󰛿",
          untracked = "",
          deleted = "",
          ignored = "󱥸",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      info = "",
      warning = "",
      error = "󰅙",
    },
  }
})
require("mini.pick").setup()
require("colorizer").setup()
vim.g.vimtex_view_method = "zathura"
vim.g.tex_conceal = "abdmgs"
vim.o.conceallevel = 1

vim.cmd("colorscheme kanso-zen")
