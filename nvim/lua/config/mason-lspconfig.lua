require("mason-lspconfig").setup({
    automatic_installation = true
})

local lspconfig = require("lspconfig")

-- lsp servers must be setup after setting up mason
lspconfig.bashls.setup({})
lspconfig.jsonls.setup({})
lspconfig.vimls.setup({})
lspconfig.sumneko_lua.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
})

