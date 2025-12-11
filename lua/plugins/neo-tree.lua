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
        },
        source_selector = {
        winbar = true,
        content_layout = "center",
        sources = {
          { source = "filesystem", display_name = " 󰉓 Files " },
          { source = "buffers", display_name = " 󰈚 Buffers " },
          { source = "git_status", display_name = " 󰊢 Git " },
        },
      },
      window = {
        position = "left",
        width = 30,
        mapping_options = { noremap = true, nowait = true },
        mappings = {
          ["<M-Left>"] = "prev_source",
          ["<M-Right>"] = "next_source",
        },
      },
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      buffers = {
        follow_current_file = { enabled = true },
      },
    },
    lazy = false, -- neo-tree will lazily load itself
  }
}
