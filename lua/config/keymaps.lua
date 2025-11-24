local opts = { silent = true, noremap = true }

-- Make 'a' behave like 'i'
vim.keymap.set("n", "a", "i", { desc = "Enter insert mode at cursor position" })

-- Word navigation with Ctrl+arrows
vim.keymap.set({ "n", "i", "v" }, "<C-Left>", "b", { desc = "Move to previous word" })
vim.keymap.set({ "n", "i", "v" }, "<C-Right>", "e", { desc = "Move to next word end" })

-- Configure word characters to treat . _ - as separators
vim.opt.iskeyword = "@,48-57,192-255"

-- Normal mode: Ctrl+w + Arrow Keys
vim.keymap.set("n", "<C-w><Left>",  "<C-w>h", opts)
vim.keymap.set("n", "<C-w><Down>",  "<C-w>j", opts)
vim.keymap.set("n", "<C-w><Up>",    "<C-w>k", opts)
vim.keymap.set("n", "<C-w><Right>", "<C-w>l", opts)

-- Terminal mode
local tnav = [[<C-\><C-n>]]

vim.keymap.set("t", "<C-w><Left>",  tnav .. "<C-w>h", opts)
vim.keymap.set("t", "<C-w><Down>",  tnav .. "<C-w>j", opts)
vim.keymap.set("t", "<C-w><Up>",    tnav .. "<C-w>k", opts)
vim.keymap.set("t", "<C-w><Right>", tnav .. "<C-w>l", opts)

-- Search
vim.keymap.set("n", "<C-f>", "<CMD>Telescope current_buffer_fuzzy_find<CR>", { desc = "Search in current buffer"})

-- Select mode
vim.keymap.set("n", "s", "gh", { desc = "Enter select mode"})

-- Oil
vim.keymap.set("n", "<Tab>", "<CMD>Oil<CR>", { desc = "Open parent directory"})

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

vim.keymap.set("n", "<C-q>", close_window_and_discard_buffer, { desc = "Close window and discard buffer if unique" })
