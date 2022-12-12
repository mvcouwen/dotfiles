require("telescope").setup({
    pickers = {
        buffers = {
            sort_lastused = true,
        }
    }
})

-- mappings
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local telescope = require("telescope/builtin")
map('n', '<leader>ff', telescope.find_files, opts)
map('n', '<leader>fg', telescope.live_grep, opts)
map('n', '<leader>fb', telescope.buffers, opts)
map('n', '<leader><tab>', telescope.buffers, opts)
map('n', '<leader>fh', telescope.help_tags, opts)
