return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash", "cpp", "dart", "go", "html", "javascript", "json", "lua", "markdown", "markdown_inline",
        "python", "query", "regex", "rust", "scala", "terraform", "tsx", "typescript", "vim", "yaml",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      enable = true,
      max_lines = 0,
      trim_scope = "outer",
      min_window_height = 0,
      patterns = {
        default = { "class", "function", "method", "for", "while", "if", "switch", "case" },
        rust = { "impl_item", "struct", "enum", "function", "method", "loop", "for", "while", "if", "match" },
        markdown = { "section" },
        json = { "pair" },
        yaml = { "block_mapping_pair" },
      },
      zindex = 20, -- The Z-index of the context window
      mode = "cursor", -- Line used to calculate context. Choices: "cursor", "topline"
      separator = nil,
    },
  },
}
