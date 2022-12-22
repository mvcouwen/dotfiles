require("nvim-treesitter.configs").setup({
    ensure_installed = {"json", "lua", "yaml"},
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    }
})
