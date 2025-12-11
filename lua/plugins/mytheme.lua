return {
  dir = vim.fn.stdpath("config") .. "/lua/themes",
  name = "mytheme",
  lazy = false,
  priority = 1000,
  config = function()
    require("themes.mytheme").setup()
  end,
}
