local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local servers = {
  cssls = {},
  clangd = {},
  dartls = {},
  html = {},
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  terraformls = {
    filetypes = {
      "terraform",
      --"terraform-vars",
    },
  },
}

for lsp, cfg in pairs(servers) do
  cfg.on_attach = on_attach
  cfg.capabilities = capabilities
  lspconfig[lsp].setup(cfg)
end
