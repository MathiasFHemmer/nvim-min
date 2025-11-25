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

-- Exit terminal mode with Ctrl+Space
vim.keymap.set("t", "<C-Space>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Search
vim.keymap.set("n", "<C-f>", "<CMD>Telescope live_grep<CR>", { desc = "Search across files"})

-- Select mode: Ctrl+f to search for selected text
vim.keymap.set({"v", "s"}, "<C-f>", function()
  local selected_text = vim.fn.getreg('"')
  vim.cmd("Telescope live_grep default_text=" .. selected_text)
end, { desc = "Search for selected text across files" })

-- Visual/Select mode: Ctrl+n to select next occurrence
vim.keymap.set("v", "<C-n>", function()
  local selected_text = vim.fn.getreg('"')
  if selected_text ~= "" then
    vim.cmd('normal! /' .. vim.fn.escape(selected_text, '\\/.*[]^$') .. '<CR>')
    vim.cmd('normal! v')
  end
end, { desc = "Select next occurrence of selected text" })

vim.keymap.set("s", "<C-n>", function()
  local selected_text = vim.fn.getreg('"')
  if selected_text ~= "" then
    vim.cmd('normal! /' .. vim.fn.escape(selected_text, '\\/.*[]^$') .. '<CR>')
    vim.cmd('normal! gh')
  end
end, { desc = "Select next occurrence of selected text" })

-- Select mode
vim.keymap.set("n", "s", "gh", { desc = "Enter select mode"})

-- Oil
vim.keymap.set("n", "<Space><Tab>", "<CMD>Oil --float<CR>", { desc = "Open parent directory in floating window"})

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

-- Open terminal in 5-line window below current window
vim.keymap.set("n", "<C-t>", function()
  vim.cmd("below split | terminal")
  vim.cmd("resize 5")
end, { desc = "Open terminal in 5-line window below" })


-- Move lines up/down with Alt+arrows
vim.keymap.set("n", "<M-Up>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("n", "<M-Down>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("v", "<M-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("v", "<M-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
