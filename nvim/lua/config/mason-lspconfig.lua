require("mason-lspconfig").setup()

local lspconfig = require("lspconfig")

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

