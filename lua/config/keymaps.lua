local opts = { silent = true, noremap = true }

-- Word navigation with Ctrl+arrows
vim.keymap.set({ "n", "v" }, "<C-Left>", "b", { desc = "Move to previous word" })
vim.keymap.set({ "n", "v" }, "<C-Right>", "e", { desc = "Move to next word end" })
-- Configure word characters to treat . _ - as separators
vim.opt.iskeyword = "@,48-57,192-255"
-- Normal mode: Ctrl+w + Arrow Keys
vim.keymap.set("n", "<C-w><Left>", "<C-w>h", opts)
vim.keymap.set("n", "<C-w><Down>", "<C-w>j", opts)
vim.keymap.set("n", "<C-w><Up>", "<C-w>k", opts)
vim.keymap.set("n", "<C-w><Right>", "<C-w>l", opts)
-- Window resizing with Space + Arrow Keys
vim.keymap.set("n", "<Space><Up>", "<C-w>+", { desc = "Increase window height" })
vim.keymap.set("n", "<Space><Down>", "<C-w>-", { desc = "Decrease window height" })
vim.keymap.set("n", "<Space><Left>", "<C-w><", { desc = "Decrease window width" })
vim.keymap.set("n", "<Space><Right>", "<C-w>>", { desc = "Increase window width" })

-- Terminal mode
local tnav = [[<C-\><C-n>]]

vim.keymap.set("t", "<C-w><Left>", tnav .. "<C-w>h", opts)
vim.keymap.set("t", "<C-w><Down>", tnav .. "<C-w>j", opts)
vim.keymap.set("t", "<C-w><Up>", tnav .. "<C-w>k", opts)
vim.keymap.set("t", "<C-w><Right>", tnav .. "<C-w>l", opts)

-- Exit terminal mode with Esc and Ctrl+Space
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-Space>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Select mode
vim.keymap.set("n", "s", "gh", { desc = "Enter select mode" })

-- Save
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<CMD>w<CR>", { desc = "Save buffer" })

-- Undo
vim.keymap.set({ "n", "i", "v" }, "<C-z>", "<CMD>undo<CR>", { desc = "Undo last change" })

-- Copy/Cut/Paste
vim.keymap.set({ "v" }, "<C-c>", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<C-x>", '"+d', { desc = "Cut to system clipboard" })
vim.keymap.set({ "n", "i" }, "<C-v>", '"+p', { desc = "Paste from system clipboard" })

-- Split buffer with Ctrl+Alt+arrows and switch to new split
vim.keymap.set("n", "<C-M-Left>", "<C-w>v<C-w>h", { desc = "Split vertical and move left" })
vim.keymap.set("n", "<C-M-Right>", "<C-w>v<C-w>l", { desc = "Split vertical and move right" })
vim.keymap.set("n", "<C-M-Up>", "<C-w>s<C-w>k", { desc = "Split horizontal and move up" })
vim.keymap.set("n", "<C-M-Down>", "<C-w>s<C-w>j", { desc = "Split horizontal and move down" })


-- Close window with Ctrl+q and discard buffer if not visible elsewhere
local function close_window_and_discard_buffer()
  local current_buf = vim.api.nvim_get_current_buf()
  local current_win = vim.api.nvim_get_current_win()
  -- Check if buffer is visible in other windows
  local buf_is_visible_elsewhere = false
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if win ~= current_win and vim.api.nvim_win_get_buf(win) == current_buf then
      buf_is_visible_elsewhere = true
      break
    end
  end
  -- Close current window
  vim.cmd("close")
  -- If buffer is not visible elsewhere, delete it without saving
  if not buf_is_visible_elsewhere and vim.api.nvim_buf_is_valid(current_buf) then
    vim.api.nvim_buf_delete(current_buf, { force = true })
  end
end

vim.keymap.set({ "n" }, "<C-q>", close_window_and_discard_buffer,
  { desc = "Close window and discard buffer if unique" })

vim.keymap.set({ "t" }, "<C-q>", function()
  require('snacks').terminal.toggle()
end, { desc = "Close window and discard buffer if unique" })

-- Open terminal in 5-line window below current window
vim.keymap.set({"n", "t"}, "<C-t>", function()
  require("snacks").terminal.toggle(nil, {
    win = {
      relative = "win",
      position = "bottom",
      height = 0.3,
    }
  })
end, { desc = "Open terminal relative to current window" })

-- Move lines up/down with Alt+arrows
vim.keymap.set("n", "<M-Up>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("n", "<M-Down>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("v", "<M-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("v", "<M-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

-- Indent selected region with Tab in visual/select mode
vim.keymap.set({ "v", "s" }, "<Tab>", ">gv", { desc = "Indent selected region" })
vim.keymap.set({ "v", "s" }, "<S-Tab>", "<gv", { desc = "Unindent selected region" })

-- Tab navigation with Alt+arrows
vim.keymap.set("n", "<M-Left>", "<CMD>tabprev<CR>", { desc = "Go to previous tab" })
vim.keymap.set("n", "<M-Right>", "<CMD>tabnext<CR>", { desc = "Go to next tab" })

-- Word deletion in insert mode
vim.keymap.set("i", "<C-Delete>", "<C-o>de", { desc = "Delete word under cursor" })

-- Goto preview keymaps
vim.keymap.set("n", "gpd", function()
  require('goto-preview').goto_preview_definition()
end, { desc = "Go to preview definition" })

vim.keymap.set("n", "gpt", function()
  require('goto-preview').goto_preview_type_definition()
end, { desc = "Go to preview type definition" })

vim.keymap.set("n", "gpi", function()
  require('goto-preview').goto_preview_implementation()
end, { desc = "Go to preview implementation" })

vim.keymap.set("n", "gpD", function()
  require('goto-preview').goto_preview_declaration()
end, { desc = "Go to preview declaration" })

vim.keymap.set("n", "gP", function()
  require('goto-preview').close_all_win()
end, { desc = "Close all goto-preview windows" })

vim.keymap.set("n", "gpr", function()
  require('goto-preview').goto_preview_references()
end, { desc = "Go to preview references" })
