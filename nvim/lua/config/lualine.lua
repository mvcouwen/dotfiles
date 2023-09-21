local colors = require("gruvbox/palette").colors

local theme = {
  normal = {
    a = { bg = colors.bright_green, fg = colors.dark0, gui = "bold" },
    b = { bg = colors.dark2, fg = colors.light1 },
    c = { bg = colors.dark1, fg = colors.light4 },
  },
  insert = {
    a = { bg = colors.bright_blue, fg = colors.dark0, gui = "bold" }
  },
  visual = {
    a = { bg = colors.bright_yellow, fg = colors.dark0, gui = "bold" },
  },
  replace = {
    a = { bg = colors.bright_orange, fg = colors.dark0, gui = "bold" },
  },
  command = {
    a = { bg = colors.bright_red, fg = colors.dark0, gui = "bold" },
  },
  inactive = {
    a = { bg = colors.dark1, fg = colors.light4, gui = "bold" },
    b = { bg = colors.dark1, fg = colors.light4 },
    c = { bg = colors.dark1, fg = colors.light4 },
  },
}

require("lualine").setup({
    options = {
        icons_enabled = false,
        theme = theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" }
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "filename" },
        lualine_c = { "branch", "diff", "diagnostics" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" }
    }
})
