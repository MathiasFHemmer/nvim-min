return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    config = {
        sources = {
            "filesystem",
            "buffers",
            "git_status",
            "document_symbols",
        }
    },
    lazy = false, -- neo-tree will lazily load itself
  }
}