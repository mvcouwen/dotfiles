-- override some treesitter highlight groups
require("gruvbox").setup({
    overrides = {
        Function = { link = "GruvboxGreen" },
        -- Operator = { link = "GruvboxFg1" },
        Type = { link = "GruvboxYellow" },
        ["@function.call"] = { link = "GruvboxFg1" },
        ["@method.call"] = { link = "GruvboxFg1" },
        ["@parameter"] = { link = "GruvboxFg1" },
        ["@type.qualifier"] = { link = "Keyword" },
        ["@variable.builtin"] = { link = "Keyword" }
    }
})

vim.opt.background = "dark"
vim.cmd("colorscheme gruvbox")
