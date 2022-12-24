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

    -- autopairs
    use({
        "windwp/nvim-autopairs",
        config = function() require("config/autopairs") end,
        requires = { "hrsh7th/nvim-cmp" }
    })

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
        config = function() require("config/lspconfig") end,
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/nvim-cmp",
            "williamboman/mason-lspconfig.nvim"
        }
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

    -- mason lspconfig
    use({
        "williamboman/mason-lspconfig.nvim",
        config = function() require("config/mason-lspconfig") end,
        requires = { "williamboman/mason.nvim" }
    })

    -- null-ls
    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = function() require("config/null-ls") end,
        requires = { "nvim-lua/plenary.nvim" }
    })

    -- nvim-cmp
    use({
        "hrsh7th/nvim-cmp",
        config = function() require("config/cmp") end,
        requires = {
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-nvim-lsp"
        }
    })

    -- packer can manage itself
    use({ "wbthomason/packer.nvim" })

    -- telescope
    use({
        "nvim-telescope/telescope.nvim",
        config = function() require("config/telescope") end,
        requires = { "nvim-lua/plenary.nvim" }
    })

    -- treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        config = function() require("config/treesitter") end,
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end
    })

    -- vim-tmux-navigator
    use({ "christoomey/vim-tmux-navigator" })

end)
