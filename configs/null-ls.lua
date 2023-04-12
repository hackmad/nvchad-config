local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local completion = null_ls.builtins.completion

local sources = {
  formatting.prettier,
  formatting.rustfmt,
  formatting.scalafmt,
  formatting.stylua,

  lint.shellcheck,

  code_actions.gitsigns,
  code_actions.gomodifytags,
  code_actions.impl,

  completion.luasnip,
  completion.spell,
}

null_ls.setup {
   debug = true,
   sources = sources,
}
