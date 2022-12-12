local cmp = require("cmp")

cmp.setup({
    sources = cmp.config.sources({
        { name = "nvim_lsp" }
    }),
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<tab>"] = cmp.mapping.confirm({ select = true }),
    }),
    completion = {
        completeopt = "menu,menuone,noinsert"
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    }
})
