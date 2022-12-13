local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- netrw
map("n", "<leader>nh", "<cmd>Hexplore<CR>", opts)
map("n", "<leader>nv", "<cmd>Vexplore!<CR>", opts)
map("n", "<leader>nn", "<cmd>Explore<CR>", opts)

-- lsp mapping as suggested by neovim/nvim-lspconfig
map("n", "<space>e", vim.diagnostic.open_float, opts)
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)
map("n", "<space>q", vim.diagnostic.setloclist, opts)
map("n", "gD", vim.lsp.buf.declaration, opts)
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "K", vim.lsp.buf.hover, opts)
map("n", "gi", vim.lsp.buf.implementation, opts)
map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
map("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts)
map("n", "<space>D", vim.lsp.buf.type_definition, opts)
map("n", "<space>rn", vim.lsp.buf.rename, opts)
map("n", "<space>ca", vim.lsp.buf.code_action, opts)
map("n", "gr", vim.lsp.buf.references, opts)
map("n", "<space>l", function() vim.lsp.buf.format { async = true } end, opts)
