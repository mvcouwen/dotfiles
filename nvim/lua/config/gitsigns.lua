local map = vim.keymap.set
local gitsigns = require("gitsigns")

gitsigns.setup({
    on_attach = function(bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        map("n", "]h", gitsigns.next_hunk, opts)
        map("n", "[h", gitsigns.prev_hunk, opts)
        map("n", "<leader>hs", gitsigns.stage_hunk, opts)
        map("n", "<leader>hS", gitsigns.stage_buffer, opts)
        map("n", "<leader>hr", gitsigns.reset_hunk, opts)
        map("n", "<leader>hR", gitsigns.reset_buffer, opts)
        map("n", "<leader>hu", gitsigns.undo_stage_hunk, opts)
        map("n", "<leader>hp", gitsigns.preview_hunk, opts)
        map("n", "<leader>hb", function() gitsigns.blame_line { full = true } end, opts)
        map("n", "<leader>tb", gitsigns.toggle_current_line_blame, opts)
        map("n", "<leader>hd", gitsigns.diffthis, opts)
        map("n", "<leader>hD", function() gitsigns.diffthis("~") end, opts)
        map("n", "<leader>td", gitsigns.toggle_deleted, opts)
    end
})
