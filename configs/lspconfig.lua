local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local handlers = {
  ["metals/status"] = function(_, status, ctx)
    -- https://github.com/scalameta/nvim-metals/blob/main/lua/metals/status.lua#L36-L50
    local val = {}
    if status.hide then
      val = { kind = "end" }
    elseif status.show then
      val = { kind = "begin", message = status.text }
    elseif status.text then
      val = { kind = "report", message = status.text }
    else
      return
    end
    local info = { client_id = ctx.client_id }
    local msg = { token = "metals", value = val }
    -- call fidget progress handler
    vim.lsp.handlers["$/progress"](nil, msg, info)
  end,
}

local servers = {
  cssls = { on_attach = on_attach, capabilities = capabilities },
  clangd = { on_attach = on_attach, capabilities = capabilities },
  dartls = { on_attach = on_attach, capabilities = capabilities },
  html = { on_attach = on_attach, capabilities = capabilities },
  gopls = { on_attach = on_attach, capabilities = capabilities },
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
  metals = {
    init_options = {
      statusBarProvider = "on",
    },
    handlers = handlers,
  },
}

for lsp, cfg in pairs(servers) do
  lspconfig[lsp].setup(cfg)
end
