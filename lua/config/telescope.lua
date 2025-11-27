-- Telescope keymaps
vim.keymap.set("n", "<leader>fk", ":Telescope keymaps<CR>", { silent = true, noremap = true, desc = "Telescope keymaps" })
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { silent = true, noremap = true, desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fe", ":Telescope find_files<CR>", { silent = true, noremap = true, desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { silent = true, noremap = true, desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { silent = true, noremap = true, desc = "Telescope buffers" })

-- Search - VSCode-like live search in current buffer
vim.keymap.set("n", "<C-f>", function()
  -- Create floating window
  local original_win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = 60,
    height = 1,
    row = 1,
    col = vim.o.columns / 2 - 30,
    border = "rounded",
    style = "minimal",
    title = " Search ",
    title_pos = "center",
  })
  -- Store original window
  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, "buftype", "prompt")
  vim.api.nvim_buf_set_option(buf, "filetype", "text")
  -- Live search function
  local function update_search()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local text = table.concat(lines, "")
    if text == "" then
      vim.opt.hlsearch = false
      vim.fn.setreg("/", "")
    else
      -- Escape special characters for literal search
      vim.fn.setreg("/", text)
      vim.opt.hlsearch = true
      -- Jump to first match
      --vim.cmd('normal! /' .. text .. '\n')
    end
  end
  -- Set up live search on text change
  local group = vim.api.nvim_create_augroup("LiveSearch", { clear = false })
  vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI"}, {
    buffer = buf,
    group = group,
    callback = update_search,
  })
  -- Start prompt
  vim.fn.prompt_setprompt(buf, "")
  vim.fn.prompt_setcallback(buf, function(text)
    vim.api.nvim_win_close(win, true)
  end)
  vim.api.nvim_win_set_option(win, "winhl", "Normal:Normal")
  vim.api.nvim_set_current_buf(buf)
  vim.cmd('startinsert')
  -- Helper function to clean up
  local function cleanup()
    vim.api.nvim_del_augroup_by_id(group)
    vim.api.nvim_win_close(win, true)
    vim.api.nvim_buf_delete(buf, { force = true })
    vim.api.nvim_set_current_win(original_win)
  end
  
  -- Close on Escape
  vim.keymap.set("i", "<Esc>", function()
    vim.opt.hlsearch = false
    vim.fn.setreg("/", "")
    cleanup()
  end, { buffer = buf, silent = true })
  -- Close on Ctrl+C
  vim.keymap.set("i", "<C-c>", function()
    cleanup()
  end, { buffer = buf, silent = true })
  -- Auto-close on Enter
  vim.keymap.set("i", "<CR>", function()
    cleanup()
  end, { buffer = buf, silent = true })
end, { desc = "VSCode-like live search in current buffer" })

-- Visual/Select mode: Ctrl+f to search for selected text
vim.keymap.set({"v", "s"}, "<C-f>", function()
  -- Get the currently selected text
  local save_pos = vim.fn.getpos('.')
  vim.cmd('normal! "vy') -- yank to register v
  local selected_text = vim.fn.getreg('v')
  vim.fn.setpos('.', save_pos)
  
  -- Trim whitespace and ensure we have text
  selected_text = selected_text:gsub("^%s+", ""):gsub("%s+$", "")
  if selected_text == "" then return end
  
  -- Escape special characters for literal search
  local escaped_text = vim.fn.escape(selected_text, '\\/.*[]^$()')
  
  -- Set search register and enable highlighting
  vim.fn.setreg("/", escaped_text)
  vim.opt.hlsearch = true
  
  -- Return to normal mode and jump to first match
  vim.cmd('normal! /' .. escaped_text .. '\n')
end, { desc = "Search for selected text" })

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


