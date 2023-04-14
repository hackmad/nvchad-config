vim.wo.relativenumber = true
vim.opt_global.shortmess:remove "F" -- See `:h nvim-metals`
vim.opt.colorcolumn = "120"

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  buffer = buffer,
  callback = function()
    vim.lsp.buf.format { async = false }
  end,
})
