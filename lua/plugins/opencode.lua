return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    -- Required for `snacks` provider.
    ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    vim.g.opencode_default_agent = "plan"
    ---@type opencode.Opts
    vim.g.opencode_opts = {
	port = 15997,
	ask = {
	    snack = {
            win = {
		        relative = "editor",
		        row = "50%",
		        col = "50%",
		        width = 80,
		        height = 10,
		        anchor = "NW",
	    	},
	    },
	},
      -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    -- Recommended/example keymaps.
    vim.keymap.set({ "n", "x" }, "<C-a>a", function() require("opencode").ask("", { submit = true }) end, { desc = "Ask opencode" })
    vim.keymap.set({ "n", "x" }, "<C-a>x", function() require("opencode").select() end, { desc = "Execute opencode action" })
    vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment', noremap = true })
    vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement', noremap = true })
  end,
}
