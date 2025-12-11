local config = function()
  local p = require("themes.mytheme").palette

  local theme = {
    normal = {
      a = { fg = p.bg, bg = p.blue, gui = "bold" },
      b = { fg = p.fg, bg = p.light_gray },
      c = { fg = p.fg, bg = p.light_gray },
    },
    insert = {
      a = { fg = p.bg, bg = p.orange, gui = "bold" },
      b = { fg = p.fg, bg = p.light_gray },
      c = { fg = p.fg, bg = p.light_gray },
    },
    visual = {
      a = { fg = p.bg, bg = p.magenta, gui = "bold" },
      b = { fg = p.fg, bg = p.bg },
      c = { fg = p.fg, bg = p.bg },
    },
    replace = {
      a = { fg = p.bg, bg = p.red, gui = "bold" },
      b = { fg = p.fg, bg = p.bg },
      c = { fg = p.fg, bg = p.bg },
    },
    command = {
      a = { fg = p.bg, bg = p.yellow, gui = "bold" },
      b = { fg = p.fg, bg = p.bg },
      c = { fg = p.fg, bg = p.bg },
    },
    inactive = {
      a = { fg = p.gray, bg = p.bg, gui = "bold" },
      b = { fg = p.gray, bg = p.bg },
      c = { fg = p.gray, bg = nil },
    },
  }

  require("lualine").setup({
    options = {
      theme = theme,
      icons_enabled = true,
      always_show_tabline = true,
      globalstatus = true,
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename' },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { "lsp_status", "searchcount", 'progress' },
      lualine_z = { 'location' }
    },
    tabline = {},
  })
end

return { {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  config = config,
} }
