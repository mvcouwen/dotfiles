local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.cmd("packadd packer.nvim")
    return true
  end
  return false
end

ensure_packer()

require("packer").startup(function(use)

    -- Packer can manage itself
    use({ "wbthomason/packer.nvim" })

    -- Gruvbox color scheme
    use({
        "ellisonleao/gruvbox.nvim",
        config = function() require("config/gruvbox") end
    })

    -- LSP config
    use({
        "neovim/nvim-lspconfig",
        config = function() require("config/nvim-lspconfig") end
    })

    -- Lualine
    use({
        "nvim-lualine/lualine.nvim",
        config = function() require("config/lualine") end
    })

    -- Luasnip
    use({ "L3MON4D3/LuaSnip" })

    -- nvim-cmp
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-nvim-lsp"
        },
        config = function() require("config/nvim-cmp") end
    })

    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim"
        },
        config = function() require("config/telescope") end
    })

    -- Vim-tmux-navigator
    use({ "christoomey/vim-tmux-navigator" })

end)
