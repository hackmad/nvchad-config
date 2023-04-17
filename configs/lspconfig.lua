local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local servers = {
  "cssls",
  "clangd",
  "dartls",
  "html",
  "gopls",
  "pyright",
  "rust_analyzer",
  "terraformls",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

require("noice").setup {
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = true, -- add a border to hover docs and signature help
  },
  routes = {
    -- hide messages that are just visual noise
    {
      filter = {
        any = {
          { event = "msg_show", kind = "", find = "written" },
          { event = "msg_show", kind = "", find = "Scratch" },
          { event = "msg_show", kind = "", find = "NvimTree" },
          { event = "msg_show", kind = "", find = "Modified" },
          { event = "msg_show", kind = "", find = "[0-9]+L, [0-9]+B" },
          { event = "msg_show", kind = "", find = "line [0-9]+ of [0-9]+" },
          { event = "msg_show", kind = "", find = "Scratch" },
          { event = "msg_show", kind = "", find = "No lines in buffer" },
        },
      },
      opts = { skip = true },
    },
  },
}
