local M = {}

M.treesitter = {
  ensure_installed = {
    "bash",
    "cpp",
    "dart",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "groovy",
    "html",
    "javascript",
    "json",
    "kotlin",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "regex",
    "rust",
    "scala",
    "terraform",
    "tsx",
    "typescript",
    "vim",
    "yaml",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python",
    -- },
  },
}

M.mason = {
  ensure_installed = {
    "bash-debug-adapter",
    "bash-language-server",
    "clang-format",
    "clangd",
    "cmake-language-server",
    "codelldb",
    "cpplint",
    "cpptools",
    "flake8",
    "gopls",
    "json-lsp",
    "kotlin-debug-adapter",
    "kotlin-language-server",
    "lua-language-server",
    "pyright",
    "rust-analyzer",
    "shfmt",
    "stylua",
    "terraform-ls",
    "tflint",
  },
}

M.nvimtree = {
  git = {
    enable = true,
  },
  filters = {
    dotfiles = false,
  },
  modified = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
  },
  view = {
    signcolumn = "yes",
    width = 25,
  },
  actions = {
    open_file = {
      resize_window = false,
    },
  },
  renderer = {
    highlight_git = true,
    highlight_opened_files = "icon",
    highlight_modified = "icon",
    icons = {
      webdev_colors = true,
      git_placement = "signcolumn",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
        modified = true,
      },
    },
  },
}

return M
