vim.wo.relativenumber = true -- relative line numbering
vim.opt_global.shortmess:remove "F" -- See `:h nvim-metals`
vim.opt.colorcolumn = "120" -- nice wide 120 columns

vim.o.diffopt = "vertical" -- vertical layout for merge

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format { async = false }
  end,
})
