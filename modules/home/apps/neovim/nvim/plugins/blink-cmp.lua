require("blink.cmp").setup({
    completion = {
        accept = { auto_brackets = { enabled = true } }
    },
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
