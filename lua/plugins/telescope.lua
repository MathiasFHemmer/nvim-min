return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.4",
  lazy = false,
  dependencies = {
    { "nvim-lua/plenary.nvim"},
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = "^1.0.0",
    },
    { "nvim-tree/nvim-web-devicons", opts = {}}
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    
    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-q>"] = actions.close,
          },
          n = {
            ["<C-q>"] = actions.close,
          },
        },
      },
    })
  end,
}
