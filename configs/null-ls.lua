local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local sources = {
  null_ls.builtins.formatting.prettier,
  null_ls.builtins.formatting.rustfmt,
  null_ls.builtins.formatting.scalafmt,
  null_ls.builtins.formatting.stylua,

  null_ls.builtins.code_actions.gitsigns,
}

null_ls.setup {
   debug = true,
   sources = sources,
}
