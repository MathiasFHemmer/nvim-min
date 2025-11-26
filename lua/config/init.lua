local opt = vim.opt

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.wrap = false

opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

opt.number = true
opt.relativenumber = false
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.scrolloff = 10
opt.whichwrap = "b,s,<,>,[,],h,l"
opt.completeopt = "menuone,noinsert,noselect"

opt.winborder = 'rounded'
opt.inccommand = 'split'

require("config.lazy")
require("config.lsp")
require("config.dap")
require("config.dap-ui")
require("config.keymaps")
require("config.telescope")

