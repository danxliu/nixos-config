-- OPTIONS
vim.o.mouse = "a"
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 10
vim.o.sidescrolloff = 8
vim.o.wrap = false
vim.o.signcolumn = "yes"
vim.o.showmode = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.g.mapleader = " "
vim.g.vimtex_view_method = "zathura"
vim.g.tex_conceal = "abdmgs"
vim.o.conceallevel = 1
vim.opt.fillchars = { eob = " " }

-- Keybindings
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>")

vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")

vim.keymap.set("n", "<leader>v", ":vsplit<CR>")
vim.keymap.set("n", "<leader>h", ":split<CR>")

vim.keymap.set("n", "<leader>q", ":quit<CR>")
vim.keymap.set("n", "<leader>w", ":write<CR>")

vim.keymap.set("n", "<leader>b", ":Pick buffers<CR>")
vim.keymap.set("n", "<leader>f", ":Pick files<CR>")
vim.keymap.set("n", "<leader>g", ":Pick grep_live<CR>")

vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>fm", function()
	require("conform").format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	})
end)

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

require("base16-colorscheme").setup({
	base00 = "@base00@",
	base01 = "@base01@",
	base02 = "@base02@",
	base03 = "@base03@",
	base04 = "@base04@",
	base05 = "@base05@",
	base06 = "@base06@",
	base07 = "@base07@",
	base08 = "@base08@",
	base09 = "@base09@",
	base0A = "@base0A@",
	base0B = "@base0B@",
	base0C = "@base0C@",
	base0D = "@base0D@",
	base0E = "@base0E@",
	base0F = "@base0F@",
})

require("luasnip").config.setup({ enable_autosnippets = true })

require("blink.cmp").setup({
	completion = {
		accept = { auto_brackets = { enabled = true } },
	},
	snippets = {
		expand = function(snippet)
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_vscode").lazy_load({
				paths = "~/.config/nvim/snippets",
			})
			require("luasnip").lsp_expand(snippet)
		end,
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = { implementation = "lua" },
})

require("conform").setup({
	formatters_by_ft = {
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescriptreact = { "prettierd" },
		css = { "prettierd" },
		html = { "prettierd" },
		json = { "prettierd" },
		markdown = { "prettierd" },
		lua = { "stylua" },
		sh = { "shfmt" },
		python = { "ruff_fix", "ruff_format", "black" },
	},
})

require("mini.pick").setup()

require("nvim-web-devicons").setup()

require("dashboard").setup({
	theme = "doom",
	config = {
		header = {
			"",
			"   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣭⣿⣶⣿⣦⣼⣆         ",
			"    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
			"          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷⠄⠄⠄⠄⠻⠿⢿⣿⣧⣄     ",
			"           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
			"          ⢠⣿⣿⣿⠈  ⠡⠌⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
			"   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘⠄ ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
			"  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
			" ⣠⣿⠿⠛⠄⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
			" ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇⠄⠛⠻⢷⣄ ",
			"      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
			"       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
			"",
		},
		center = {
			{
				desc = "New File",
				group = "Label",
				action = "enew",
				key = "n",
			},
		},
		footer = {
			"The one true text editor.",
		},
	},
})

require("colorizer").setup()

require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				text_align = "center",
				separator = true,
			},
		},
		hover = {
			enabled = true,
			delay = 200,
			reveal = { "close" },
		},
	},
})

require("lualine").setup({
	options = {
		theme = "base16",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "NvimTree" },
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diagnostics" },
			lualine_c = { "filename" },
			lualine_x = { "encoding" },
			lualine_y = { "filetype" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
	},
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
	},
})

require("ibl").setup({
	exclude = {
		filetypes = {
			"NvimTree",
			"dashboard",
		},
	},
})

require("gitsigns").setup()

require("nvim-autopairs").setup()

require("nvim-ts-autotag").setup()

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		if vim.bo.buftype ~= "" then
			return
		end
		pcall(vim.treesitter.start)
	end,
})

local capabilities = require("blink.cmp").get_lsp_capabilities()
local servers = {
	"clangd",
	"pyright",
	"jdtls",
	"ts_ls",
	"html",
	"cssls",
	"rust_analyzer",
	"nixd",
	"marksman",
	"texlab",
	"lua_ls",
	"bashls",
	"yamlls",
	"svelte",
	"tailwindcss",
	"harper_ls",
	"emmet_language_server",
}
for _, lsp in ipairs(servers) do
	vim.lsp.config(lsp, {
		capabilities = capabilities,
		autostart = true,
	})
	vim.lsp.enable(lsp)
end
