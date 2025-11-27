return -- lazy.nvim
{
  "GustavEikaas/easy-dotnet.nvim",
  dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope.nvim', },
  config = function()
    require("easy-dotnet").setup({
      debugger = {
        bin_path = vim.fs.joinpath(vim.fn.stdpath("data"), "mason/bin/netcoredbg.cmd")
      },
    })
  end
}
