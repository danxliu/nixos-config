-- OPTIONS
vim.o.mouse = 'a'
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
vim.keymap.set("n", "<Tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>")

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
vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format)

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

local capabilities = require('blink.cmp').get_lsp_capabilities()
local servers = {
    'clangd',
    'pyright',
    'jdtls',
    'ts_ls',
    'html',
    'cssls',
    'rust_analyzer',
    'nil_ls',
    'marksman',
    'texlab'
}
for _, lsp in ipairs(servers) do
    vim.lsp.config(lsp, {
        capabilities = capabilities,
        autostart = true,
    })
    vim.lsp.enable(lsp)
end
