-- Search
vim.keymap.set("n", "<C-f>", function()
  require('telescope.builtin').live_grep({
    fuzzy_sorter = true,
  })
end, { desc = "Search across files"})

-- Visual/Select mode: Ctrl+f to search for selected text
vim.keymap.set({"v", "s"}, "<C-f>", function()
  -- Get the currently selected text using visual mode selection
  local mode = vim.fn.mode()
  local selected_text = ""
  
  if mode == "v" or mode == "V" or mode == "" then
    -- Visual mode: get the visually selected text
    -- Save current position and selection
    local save_pos = vim.fn.getpos('.')
    vim.cmd('normal! "vy') -- yank to register v
    selected_text = vim.fn.getreg('v')
    vim.fn.setpos('.', save_pos)
  elseif mode == "s" or mode == "S" or mode == "" then
    -- Select mode: get the selected text
    local save_pos = vim.fn.getpos('.')
    vim.cmd('normal! "vy') -- yank to register v
    selected_text = vim.fn.getreg('v')
    vim.fn.setpos('.', save_pos)
  end
  
  -- Trim whitespace and ensure we have text
  selected_text = selected_text:gsub("^%s+", ""):gsub("%s+$", "")
  if selected_text == "" then return end
  
-- Escape special characters for telescope
  local escaped_text = vim.fn.escape(selected_text, '\\/.*[]^$()')
  require('telescope.builtin').live_grep({
    default_text = escaped_text,
    fuzzy_sorter = true,
  })
end, { desc = "Search for selected text across files" })

vim.keymap.set("v", "<C-e>r", function()
  -- copy selection
  vim.cmd('normal! y')

  -- escape for literal search
  local text = vim.fn.escape(vim.fn.getreg('"'), '\\/.*$^~[]')

  -- set search register
  vim.fn.setreg("/", "\\V" .. text)
  
  -- enable highlighting
  vim.opt.hlsearch = true
end, { silent = true })

-- Navigate to previous/next search result
vim.keymap.set("n", "<C-Up>", function()
  if vim.fn.getreg("/") ~= "" then
    vim.cmd('normal! N')
  end
end, { desc = "Previous search result" })

vim.keymap.set("n", "<C-Down>", function()
  if vim.fn.getreg("/") ~= "" then
    vim.cmd('normal! n')
  end
end, { desc = "Next search result" })

-- Clear search pattern
vim.keymap.set("n", "<C-e>c", function()
  vim.cmd('nohlsearch')
  vim.fn.setreg("/", "")
end, { desc = "Clear search pattern" })

-- Change next search match (like cgn)
vim.keymap.set("n", "<C-e>e", "cgn", { desc = "Change next search match" })

-- Repeat last command on previous result
vim.keymap.set("n", "<M-Left>", function()
  if vim.fn.getreg("/") ~= "" then
    vim.cmd('normal! N.')
  end
end, { desc = "Repeat last command on previous result" })

-- Repeat last command on next result
vim.keymap.set("n", "<M-Right>", function()
  if vim.fn.getreg("/") ~= "" then
    vim.cmd('normal! n.')
  end
end, { desc = "Repeat last command on next result" })


