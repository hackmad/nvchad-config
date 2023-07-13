local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local servers = {
  cssls = { on_attach = on_attach, capabilities = capabilities },
  clangd = { on_attach = on_attach, capabilities = capabilities },
  dartls = { on_attach = on_attach, capabilities = capabilities },
  html = { on_attach = on_attach, capabilities = capabilities },
  gopls = { on_attach = on_attach, capabilities = capabilities },
  kotlin_language_server = { on_attach = on_attach, capabilities = capabilities },
  pyright = { on_attach = on_attach, capabilities = capabilities },
  rust_analyzer = { on_attach = on_attach, capabilities = capabilities },
  terraformls = {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {
      "terraform",
      --"terraform-vars",
    },
  },
}

for lsp, cfg in pairs(servers) do
  lspconfig[lsp].setup(cfg)
end
