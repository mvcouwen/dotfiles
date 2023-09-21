-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local lspconfig = require("lspconfig")

-- bashls
lspconfig.bashls.setup({
    capabilities = capabilities
})

lspconfig.html.setup({
    capabilities = capabilities
})

-- jsonls
lspconfig.jsonls.setup({
    capabilities = capabilities
})


-- vimls
lspconfig.vimls.setup({
    capabilities = capabilities
})

-- sumneko_lua
lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            },
            semantic = {
                -- leave syntax highlighting to treesitter
                enable = false
            }
        }
    }
})

-- yamlls
lspconfig.yamlls.setup({
    capabilities = capabilities
})
