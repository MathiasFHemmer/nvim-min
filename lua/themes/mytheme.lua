-- Custom Neovim Theme: MyTheme
local M = {}

-- Define your color palette to match VSCode Night Fox (Dark) with customizations
M.palette = {
  -- Base colors (Night Fox Dark, adjusted to gray)
  bg = "#1e1e1e",        -- Default Gray background to match VSCode
  fg = "#cdcecf",        -- Light foreground
  black = "#2d3436",
  white = "#d6deeb",

  -- Accent colors (customized)
  red = "#f78c6c",       -- Error red
  green = "#1dd26f",     -- Types/classes (custom green)
  yellow = "#dcc550",    -- Functions (custom yellow)
  blue = "#569CD6",      -- Keywords (custom blue)
  magenta = "#DC8CFF",   -- Assignment operators (custom magenta)
  cyan = "#7fdbca",      -- Strings/other
  orange = "#ff963a",    -- Strings (custom orange)

  -- Additional shades
  gray = "#637777",
  light_gray = "#101010",
  dark_gray = "#2a2e3a",
  variable_gray = "#cccccc",  -- Variables (custom light gray)
  light_blue = "#bdedfc"
}

-- Define highlight groups
function M.setup()
  local p = M.palette

  -- Syntax highlighting
  vim.api.nvim_set_hl(0, "Normal", { fg = p.fg, bg = p.bg })
  vim.api.nvim_set_hl(0, "Comment", { fg = p.gray, italic = true })
  vim.api.nvim_set_hl(0, "Constant", { fg = p.variable_gray })  -- Variables
  vim.api.nvim_set_hl(0, "String", { fg = p.orange })  -- Strings
  vim.api.nvim_set_hl(0, "Character", { fg = p.orange })
  vim.api.nvim_set_hl(0, "Number", { fg = p.magenta })
  vim.api.nvim_set_hl(0, "Boolean", { fg = p.magenta })
  vim.api.nvim_set_hl(0, "Float", { fg = p.magenta })

  vim.api.nvim_set_hl(0, "Identifier", { fg = p.variable_gray })  -- Variables
  vim.api.nvim_set_hl(0, "Function", { fg = p.yellow })  -- Functions
  vim.api.nvim_set_hl(0, "Statement", { fg = p.blue })  -- Keywords
  vim.api.nvim_set_hl(0, "Conditional", { fg = p.blue })
  vim.api.nvim_set_hl(0, "Repeat", { fg = p.blue })
  vim.api.nvim_set_hl(0, "Label", { fg = p.blue })
  vim.api.nvim_set_hl(0, "Operator", { fg = p.magenta })  -- Assignment
  vim.api.nvim_set_hl(0, "Keyword", { fg = p.blue })  -- Keywords
  vim.api.nvim_set_hl(0, "Exception", { fg = p.red })

  vim.api.nvim_set_hl(0, "PreProc", { fg = p.cyan })
  vim.api.nvim_set_hl(0, "Include", { fg = p.blue })
  vim.api.nvim_set_hl(0, "Define", { fg = p.blue })
  vim.api.nvim_set_hl(0, "Macro", { fg = p.blue })
  vim.api.nvim_set_hl(0, "PreCondit", { fg = p.blue })

  vim.api.nvim_set_hl(0, "Type", { fg = p.green })  -- Types/classes
  vim.api.nvim_set_hl(0, "StorageClass", { fg = p.blue })
  vim.api.nvim_set_hl(0, "Structure", { fg = p.green })
  vim.api.nvim_set_hl(0, "Typedef", { fg = p.green })

  vim.api.nvim_set_hl(0, "Special", { fg = p.yellow })
  vim.api.nvim_set_hl(0, "SpecialChar", { fg = p.orange })  -- String punctuation
  vim.api.nvim_set_hl(0, "Tag", { fg = p.yellow })
  vim.api.nvim_set_hl(0, "Delimiter", { fg = p.fg })
  vim.api.nvim_set_hl(0, "SpecialComment", { fg = p.gray })
  vim.api.nvim_set_hl(0, "Debug", { fg = p.yellow })

  -- UI elements
  vim.api.nvim_set_hl(0, "LineNr", { fg = p.gray })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = p.yellow })
  vim.api.nvim_set_hl(0, "CursorLine", { bg = p.dark_gray })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = p.bg })
  vim.api.nvim_set_hl(0, "StatusLine", { fg = p.fg, bg = p.dark_gray })
  vim.api.nvim_set_hl(0, "StatusLineNC", { fg = p.gray, bg = p.dark_gray })

  -- Search and selection
  vim.api.nvim_set_hl(0, "Search", { fg = p.bg, bg = p.yellow })
  vim.api.nvim_set_hl(0, "IncSearch", { fg = p.bg, bg = p.blue })
  vim.api.nvim_set_hl(0, "Visual", { bg = p.light_blue })  -- Very light orange

  -- Diagnostics
  vim.api.nvim_set_hl(0, "Error", { fg = p.red })
  vim.api.nvim_set_hl(0, "Warning", { fg = p.yellow })
  vim.api.nvim_set_hl(0, "Info", { fg = p.blue })
  vim.api.nvim_set_hl(0, "Hint", { fg = p.cyan })

  vim.api.nvim_set_hl(0, "DiagnosticError", { fg = p.red })
  vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = p.yellow })
  vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = p.blue })
  vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = p.cyan })
end

return M
