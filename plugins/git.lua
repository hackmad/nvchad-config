return {
  -- Git plugin
  {
    "tpope/vim-fugitive",
    cmd = "Git",
  },

  -- Load defaults for gitsigns and nvim-tree
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup()
    end,
  },
}
