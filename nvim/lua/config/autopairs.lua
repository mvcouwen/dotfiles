require("nvim-autopairs").setup()

-- automatically insert brackets after completing a function or method
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done({
        filetypes = {
            tex = false
        }
    })
)
