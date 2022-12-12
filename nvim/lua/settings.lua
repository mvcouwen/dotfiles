local opt = vim.opt
local g = vim.g

-- Tabs and indentation
opt.tabstop = 4 -- the amount of spaces that one tab is worth
opt.softtabstop = 4 -- determines the amount of whitespace introduced by typing <tab>
opt.smarttab = true -- whitespace at the beginning of a line introduced by <tab> is shiftwidth instead of softtabstop
opt.expandtab = true -- expand tabs to spaces
opt.shiftwidth = 4 -- the amount of spaces used for indenting, i.e. when using > and <
opt.shiftround = true -- round indent to a multiple of shiftwidth
opt.autoindent = true

-- Line breaks
opt.breakindent = true
opt.breakindentopt = "shift:2"
opt.linebreak = true

-- Appearance
opt.number = true
opt.cmdheight = 1
opt.signcolumn = "yes"
opt.termguicolors = true
opt.showmode = false
opt.showtabline = 0 -- never show tabline
opt.laststatus = 3 -- only show one statusline

-- Case sensitivity search
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- make search case insensitive except when upper case character is present

-- Netrw
g.netrw_liststyle = 3
g.netrw_banner = 0

-- completion
opt.completeopt = "menu,menuone,noinsert"

opt.mouse = "a" -- enable all mouse actions
opt.hidden = true
opt.backspace = "indent,eol,start"

