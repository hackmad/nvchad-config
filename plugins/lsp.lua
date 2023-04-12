return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-debug-adapter", "bash-language-server", "clang-format", "clangd", "cmake-language-server",
        "codelldb", "cpplint", "cpptools", "flake8", "gopls", "json-lsp", "lua-language-server", "pyright",
        "rust-analyzer", "rustfmt", "shfmt", "stylua", "terraform-ls", "tflint",
      },
    },
  },
}
