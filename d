warning: in the working copy of 'lazy-lock.json', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'lua/config/init.lua', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'lua/config/keymaps.lua', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'lua/config/telescope.lua', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'lua/plugins/opencode.lua', LF will be replaced by CRLF the next time Git touches it
[1mdiff --git a/lazy-lock.json b/lazy-lock.json[m
[1mindex e850ead..1112f89 100644[m
[1m--- a/lazy-lock.json[m
[1m+++ b/lazy-lock.json[m
[36m@@ -1,5 +1,7 @@[m
 {[m
[32m+[m[32m  "barbar.nvim": { "branch": "master", "commit": "53b5a2f34b68875898f0531032fbf090e3952ad7" },[m
   "easy-dotnet.nvim": { "branch": "main", "commit": "31d51597989d0bbf5699f8eef974ed3d1c1615af" },[m
[32m+[m[32m  "gitsigns.nvim": { "branch": "main", "commit": "cdafc320f03f2572c40ab93a4eecb733d4016d07" },[m
   "goto-preview": { "branch": "main", "commit": "cf561d10b4b104db20375c48b86cf36af9f96e00" },[m
   "lazy.nvim": { "branch": "main", "commit": "85c7ff3711b730b4030d03144f6db6375044ae82" },[m
   "logger.nvim": { "branch": "main", "commit": "63dd10c9b9a159fd6cfe08435d9606384ff103c5" },[m
[36m@@ -11,6 +13,7 @@[m
   "nvim-dap-ui": { "branch": "master", "commit": "cf91d5e2d07c72903d052f5207511bf7ecdb7122" },[m
   "nvim-nio": { "branch": "master", "commit": "21f5324bfac14e22ba26553caf69ec76ae8a7662" },[m
   "nvim-treesitter": { "branch": "master", "commit": "42fc28ba918343ebfd5565147a42a26580579482" },[m
[32m+[m[32m  "nvim-web-devicons": { "branch": "master", "commit": "8dcb311b0c92d460fac00eac706abd43d94d68af" },[m
   "oil.nvim": { "branch": "master", "commit": "01cb3a8ad7d5e8707041edc775af83dbf33838f4" },[m
   "opencode.nvim": { "branch": "main", "commit": "fda7eedb597155257817a9f4c9ec17308164657d" },[m
   "plenary.nvim": { "branch": "master", "commit": "b9fd5226c2f76c951fc8ed5923d85e4de065e509" },[m
[1mdiff --git a/lsp/lua_ls.lua b/lsp/lua_ls.lua[m
[1mindex f65cdc0..ed4699b 100644[m
[1m--- a/lsp/lua_ls.lua[m
[1m+++ b/lsp/lua_ls.lua[m
[36m@@ -1,27 +1,13 @@[m
 return {[m
[31m-  -- Command and arguments to start the server.[m
   cmd = { 'lua-language-server' },[m
[31m-[m
[31m-  -- Filetypes to automatically attach to.[m
   filetypes = { 'lua' },[m
[31m-[m
[31m-  -- Sets the "root directory" to the parent directory of the file in the[m
[31m-  -- current buffer that contains either a ".luarc.json" or a[m
[31m-  -- ".luarc.jsonc" file. Files that share a root directory will reuse[m
[31m-  -- the connection to the same LSP server.[m
[31m-  -- Nested lists indicate equal priority, see |vim.lsp.Config|.[m
   root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },[m
[31m-[m
[31m-  -- Specific settings to send to the server. The schema for this is[m
[31m-  -- defined by the server. For example the schema for lua-language-server[m
[31m-  -- can be found here https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json[m
   settings = {[m
     Lua = {[m
       runtime = {[m
         version = 'LuaJIT',[m
       },[m
       diagnostics = {[m
[31m-        -- Get the language server to recognize the `vim` global[m
         globals = { 'vim' },[m
       },[m
     }[m
[1mdiff --git a/lua/config/init.lua b/lua/config/init.lua[m
[1mindex d3b6f20..623bd3f 100644[m
[1m--- a/lua/config/init.lua[m
[1m+++ b/lua/config/init.lua[m
[36m@@ -20,7 +20,7 @@[m [mopt.cmdheight = 1[m
 opt.scrolloff = 10[m
 opt.whichwrap = "b,s,<,>,[,],h,l"[m
 opt.completeopt = "menuone,noinsert,noselect"[m
[31m-[m
[32m+[m[32mvim.o.tabline = "%t"[m
 opt.winborder = 'rounded'[m
 opt.inccommand = 'split'[m
 [m
[36m@@ -30,4 +30,3 @@[m [mrequire("config.dap")[m
 require("config.dap-ui")[m
 require("config.keymaps")[m
 require("config.telescope")[m
[31m-[m
[1mdiff --git a/lua/config/keymaps.lua b/lua/config/keymaps.lua[m
[1mindex f35efc6..7a6ae51 100644[m
[1m--- a/lua/config/keymaps.lua[m
[1m+++ b/lua/config/keymaps.lua[m
[36m@@ -1,7 +1,5 @@[m
 local opts = { silent = true, noremap = true }[m
 [m
[31m--- Make 'a' behave like 'i'[m
[31m-vim.keymap.set("n", "a", "i", { desc = "Enter insert mode at cursor position" })[m
 -- Word navigation with Ctrl+arrows[m
 vim.keymap.set({ "n", "v" }, "<C-Left>", "b", { desc = "Move to previous word" })[m
 vim.keymap.set({ "n", "v" }, "<C-Right>", "e", { desc = "Move to next word end" })[m
[36m@@ -12,7 +10,6 @@[m [mvim.keymap.set("n", "<C-w><Left>", "<C-w>h", opts)[m
 vim.keymap.set("n", "<C-w><Down>", "<C-w>j", opts)[m
 vim.keymap.set("n", "<C-w><Up>", "<C-w>k", opts)[m
 vim.keymap.set("n", "<C-w><Right>", "<C-w>l", opts)[m
[31m-[m
 -- Window resizing with Space + Arrow Keys[m
 vim.keymap.set("n", "<Space><Up>", "<C-w>+", { desc = "Increase window height" })[m
 vim.keymap.set("n", "<Space><Down>", "<C-w>-", { desc = "Decrease window height" })[m
[36m@@ -54,6 +51,7 @@[m [mvim.keymap.set("n", "<C-M-Right>", "<C-w>v<C-w>l", { desc = "Split vertical and[m
 vim.keymap.set("n", "<C-M-Up>", "<C-w>s<C-w>k", { desc = "Split horizontal and move up" })[m
 vim.keymap.set("n", "<C-M-Down>", "<C-w>s<C-w>j", { desc = "Split horizontal and move down" })[m
 [m
[32m+[m
 -- Close window with Ctrl+q and discard buffer if not visible elsewhere[m
 local function close_window_and_discard_buffer()[m
   local current_buf = vim.api.nvim_get_current_buf()[m
[36m@@ -74,7 +72,10 @@[m [mlocal function close_window_and_discard_buffer()[m
   end[m
 end[m
 [m
[31m-vim.keymap.set({"n", "t"}, "<C-q>", close_window_and_discard_buffer, { desc = "Close window and discard buffer if unique" })[m
[32m+[m[32mvim.keymap.set({ "n", "t" }, "<C-q>", '<Cmd>BufferClose<CR>', { desc = "Close window and discard buffer if unique" })[m
[32m+[m[32mvim.keymap.set({ "n", "t" }, "<M-Left>", '<Cmd>BufferPrevious<CR>',[m
[32m+[m[32m  { desc = "Close window and discard buffer if unique" })[m
[32m+[m[32mvim.keymap.set({ "n", "t" }, "<M-Right>", '<Cmd>BufferNext<CR>', { desc = "Close window and discard buffer if unique" })[m
 [m
 -- Open terminal in 5-line window below current window[m
 vim.keymap.set("n", "<C-t>", function()[m
[1mdiff --git a/lua/config/lazy.lua b/lua/config/lazy.lua[m
[1mindex d0de16b..51ccf64 100644[m
[1m--- a/lua/config/lazy.lua[m
[1m+++ b/lua/config/lazy.lua[m
[36m@@ -6,7 +6,7 @@[m [mif not (vim.uv or vim.loop).fs_stat(lazypath) then[m
   if vim.v.shell_error ~= 0 then[m
     vim.api.nvim_echo({[m
       { "Failed to clone lazy.nvim:\n", "ErrorMsg" },[m
[31m-      { out, "WarningMsg" },[m
[32m+[m[32m      { out,                            "WarningMsg" },[m
       { "\nPress any key to exit..." },[m
     }, true, {})[m
     vim.fn.getchar()[m
[1mdiff --git a/lua/config/lsp.lua b/lua/config/lsp.lua[m
[1mindex 3c65e0d..41a18e4 100644[m
[1m--- a/lua/config/lsp.lua[m
[1m+++ b/lua/config/lsp.lua[m
[36m@@ -1,26 +1,30 @@[m
[31m--- lsp[m
[31m---------------------------------------------------------------------------------[m
[31m--- See https://gpanders.com/blog/whats-new-in-neovim-0-11/ for a nice overview[m
[31m--- of how the lsp setup works in neovim 0.11+.[m
[31m-[m
[31m--- This actually just enables the lsp servers.[m
[31m--- The configuration is found in the lsp folder inside the nvim config folder,[m
[31m--- so in ~.config/lsp/lua_ls.lua for lua_ls, for example.[m
 vim.lsp.enable('lua_ls')[m
 [m
 vim.api.nvim_create_autocmd('LspAttach', {[m
   callback = function(ev)[m
     local client = vim.lsp.get_client_by_id(ev.data.client_id)[m
[32m+[m[32m    if client:supports_method('textDocument/implementation') then[m
[32m+[m[32m      -- Create a keymap for vim.lsp.buf.implementation ...[m
[32m+[m[32m    end[m
     if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then[m
[31m-      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }[m
[32m+[m[32m      --vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }[m
       vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })[m
       vim.keymap.set('i', '<C-Space>', function()[m
         vim.lsp.completion.get()[m
       end)[m
     end[m
[32m+[m[32m    if not client:supports_method('textDocument/willSaveWaitUntil')[m
[32m+[m[32m        and client:supports_method('textDocument/formatting') then[m
[32m+[m[32m      vim.api.nvim_create_autocmd('BufWritePre', {[m
[32m+[m[32m        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),[m
[32m+[m[32m        buffer = ev.buf,[m
[32m+[m[32m        callback = function()[m
[32m+[m[32m          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })[m
[32m+[m[32m        end,[m
[32m+[m[32m      })[m
[32m+[m[32m    end[m
   end,[m
 })[m
[31m-[m
 vim.lsp.handlers['textDocument/references'] = function(err, result, ctx, config)[m
   config = config or {}[m
   config.title = 'References'[m
[1mdiff --git a/lua/config/telescope.lua b/lua/config/telescope.lua[m
[1mindex e9689ce..974c804 100644[m
[1m--- a/lua/config/telescope.lua[m
[1m+++ b/lua/config/telescope.lua[m
[36m@@ -136,17 +136,3 @@[m [mend, { desc = "Clear search pattern" })[m
 [m
 -- Change next search match (like cgn)[m
 vim.keymap.set("n", "<C-e>e", "cgn", { desc = "Change next search match" })[m
[31m-[m
[31m--- Repeat last command on previous result[m
[31m-vim.keymap.set("n", "<M-Left>", function()[m
[31m-  if vim.fn.getreg("/") ~= "" then[m
[31m-    vim.cmd('normal! N.')[m
[31m-  end[m
[31m-end, { desc = "Repeat last command on previous result" })[m
[31m-[m
[31m--- Repeat last command on next result[m
[31m-vim.keymap.set("n", "<M-Right>", function()[m
[31m-  if vim.fn.getreg("/") ~= "" then[m
[31m-    vim.cmd('normal! n.')[m
[31m-  end[m
[31m-end, { desc = "Repeat last command on next result" })[m
[1mdiff --git a/lua/plugins/dap.lua b/lua/plugins/dap.lua[m
[1mindex 9c46ac8..da2fb98 100644[m
[1m--- a/lua/plugins/dap.lua[m
[1m+++ b/lua/plugins/dap.lua[m
[36m@@ -5,4 +5,3 @@[m [mreturn {[m
   },[m
   event = "VeryLazy",[m
 }[m
[31m-[m
[1mdiff --git a/lua/plugins/lualine.lua b/lua/plugins/lualine.lua[m
[1mindex 6585563..7f9e69b 100644[m
[1m--- a/lua/plugins/lualine.lua[m
[1m+++ b/lua/plugins/lualine.lua[m
[36m@@ -1,34 +1,34 @@[m
 local config = function()[m
[31m-	local theme = require("lualine.themes.gruvbox")[m
[32m+[m[32m  local theme = require("lualine.themes.gruvbox")[m
 [m
   --set bg transparency in all modes[m
   theme.normal.c.bg = nil[m
[31m-	theme.insert.c.bg = nil[m
[31m-	theme.visual.c.bg = nil[m
[31m-	theme.replace.c.bg = nil[m
[32m+[m[32m  theme.insert.c.bg = nil[m
[32m+[m[32m  theme.visual.c.bg = nil[m
[32m+[m[32m  theme.replace.c.bg = nil[m
   theme.command.c.bg = nil[m
 [m
[31m-	require("lualine").setup({[m
[31m-		options = {[m
[32m+[m[32m  require("lualine").setup({[m
[32m+[m[32m    options = {[m
       theme = theme,[m
       icons_enabled = true,[m
       always_show_tabline = true,[m
       globalstatus = true,[m
[31m-		},		[m
[32m+[m[32m    },[m
     sections = {[m
[31m-      lualine_a = {'mode'},[m
[31m-      lualine_b = {'branch', 'diff', 'diagnostics'},[m
[31m-      lualine_c = {'filename'},[m
[31m-      lualine_x = {'encoding', 'fileformat', 'filetype'},[m
[31m-      lualine_y = {"lsp_status","searchcount", 'progress'},[m
[31m-      lualine_z = {'location'}[m
[31m-		},[m
[31m-	  tabline = {},[m
[31m-	})[m
[32m+[m[32m      lualine_a = { 'mode' },[m
[32m+[m[32m      lualine_b = { 'branch', 'diff', 'diagnostics' },[m
[32m+[m[32m      lualine_c = { 'filename' },[m
[32m+[m[32m      lualine_x = { 'encoding', 'fileformat', 'filetype' },[m
[32m+[m[32m      lualine_y = { "lsp_status", "searchcount", 'progress' },[m
[32m+[m[32m      lualine_z = { 'location' }[m
[32m+[m[32m    },[m
[32m+[m[32m    tabline = {},[m
[32m+[m[32m  })[m
 end[m
 [m
[31m-return {{[m
[31m-	"nvim-lualine/lualine.nvim",[m
[31m-	lazy = false,[m
[31m-	config = config,[m
[31m-}}[m
[32m+[m[32mreturn { {[m
[32m+[m[32m  "nvim-lualine/lualine.nvim",[m
[32m+[m[32m  lazy = false,[m
[32m+[m[32m  config = config,[m
[32m+[m[32m} }[m
[1mdiff --git a/lua/plugins/opencode.lua b/lua/plugins/opencode.lua[m
[1mindex edf071d..e2b8f86 100644[m
[1m--- a/lua/plugins/opencode.lua[m
[1m+++ b/lua/plugins/opencode.lua[m
[36m@@ -31,8 +31,8 @@[m [mreturn {[m
     -- Recommended/example keymaps.[m
     vim.keymap.set({ "n", "x" }, "<leader>a", function() require("opencode").ask("", { submit = true }) end,[m
       { desc = "Ask opencode" })[m
[31m---    vim.keymap.set({ "n", "x" }, "<leader>a", function() require("opencode").toggle() end,[m
[31m---      { desc = "Ask opencode" })[m
[32m+[m[32m    --    vim.keymap.set({ "n", "x" }, "<leader>a", function() require("opencode").toggle() end,[m
[32m+[m[32m    --      { desc = "Ask opencode" })[m
     vim.keymap.set({ "n", "x" }, "<C-a>x", function() require("opencode").select() end,[m
       { desc = "Execute opencode action" })[m
     vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment', noremap = true })[m
