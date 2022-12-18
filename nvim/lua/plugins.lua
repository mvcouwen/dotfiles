local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd("packadd packer.nvim")
        return true
    end
    return false
end

ensure_packer()

require("packer").startup(function(use)

    -- packer can manage itself
    use({ "wbthomason/packer.nvim" })

    -- gitsigns
    use({
        "lewis6991/gitsigns.nvim",
        config = function() require("config/gitsigns") end
    })

    -- gruvbox color scheme
    use({
        "ellisonleao/gruvbox.nvim",
        config = function() require("config/gruvbox") end
    })

    -- LSP config
    use({
        "neovim/nvim-lspconfig",
        config = function() require("config/nvim-lspconfig") end,
    })

    -- lualine
    use({
        "nvim-lualine/lualine.nvim",
        config = function() require("config/lualine") end
    })

    -- luasnip
    use({ "L3MON4D3/LuaSnip" })

    -- mason
    use({
        "williamboman/mason.nvim",
        config = function() require("config/mason") end
    })

    -- null-ls
    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function() require("config/null-ls") end
    })

    -- nvim-cmp
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-nvim-lsp"
        },
        config = function() require("config/nvim-cmp") end
    })

    -- telescope
    use({
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function() require("config/telescope") end
    })

    -- vim-tmux-navigator
    use({ "christoomey/vim-tmux-navigator" })

end)
