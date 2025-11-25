local config = function()
	local theme = require("lualine.themes.gruvbox")

  --set bg transparency in all modes
  theme.normal.c.bg = nil
	theme.insert.c.bg = nil
	theme.visual.c.bg = nil
	theme.replace.c.bg = nil
  theme.command.c.bg = nil

	require("lualine").setup({
		options = {
      theme = theme,
      icons_enabled = true,
      always_show_tabline = true,
      globalstatus = true,
		},		
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {"lsp_status","searchcount", 'progress'},
      lualine_z = {'location'}
		},
	  tabline = {},
	})
end

return {{
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = config,
}}
