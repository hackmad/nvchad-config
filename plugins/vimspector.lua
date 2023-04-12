return {
  {
    "puremourning/vimspector",
    keys = {
      {
        "<leader>dd",
        function()
          vim.fn["vimspector#Launch"]()
        end,
        desc = "Launch",
      },
      {
        "<leader>dx",
        function()
          vim.cmd("VimspectorReset")
        end,
        desc = "Reset",
      },
      {
        "<leader>de",
        function()
          vim.cmd("VimspectorEval")
        end,
        desc = "Eval",
      },
      {
        "<leader>dw",
        function()
          vim.cmd("VimspectorWatch")
        end,
        desc = "Watch",
      },
      {
        "<leader>do",
        function()
          vim.cmd("VimspectorShowOutputlet")
        end,
        desc = "Show Outputlet",
      },
    },
  },
}
