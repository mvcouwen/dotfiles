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
    use({ "ellisonleao/gruvbox.nvim" })

    -- LSP config
    use({ "neovim/nvim-lspconfig" })

    -- Lualine
    use({ "nvim-lualine/lualine.nvim" })

    -- Luasnip
    use({ "L3MON4D3/LuaSnip" })

    -- nvim-cmp
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-nvim-lsp"
        }
    })

    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim"
        }
    })

    -- Vim-tmux-navigator
    use({ "christoomey/vim-tmux-navigator" })

end)

require("config/nvim-lspconfig")
require("config/lualine")
require("config/telescope")
require("config/nvim-cmp")
