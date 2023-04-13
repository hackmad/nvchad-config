local M = {}

M.spectre = {
  n = {
     ["<leader>S"] = {"<cmd>lua require('spectre').open()<cr>", "open spectre"},
     ["<leader>sw"] = {"<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "search current word"},
     ["<leader>sp"] = {"<cmd>lua require('spectre').open_file_search({select_word=true})<cr>", "search in current file"},
  },
  v = {
     ["<leader>sw"] = {"<esc><cmd>lua require('spectre').open_visual()<cr>", "search current word"},
  },
}

M.lazy = {
  n = {
     ["<leader>l"] = {":Lazy<cr>", "open lazy"},
  },
}

M.flutter = {
  n = {
    ["<leader>ft"] = {":Telescope flutter commands<cr>", "flutter commands"},
  },
}

M.trouble = {
  n = {
    ["<leader>xx"] = {"<cmd>TroubleToggle<cr>", "toggle trouble"},
    ["<leader>xw"] = {"<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace diagnostics"},
    ["<leader>xd"] = {"<cmd>TroubleToggle document_diagnostics<cr>", "document diagnostics"},
    ["<leader>xl"] = {"<cmd>TroubleToggle loclist<cr>", "loclist"},
    ["<leader>xq"] = {"<cmd>TroubleToggle quickfix<cr>", "quickfix"},
  },
}

M.buffer = {
  n = {
    ["<leader>X"] = {
      function()
        require("nvchad_ui.tabufline").close_buffer()
      end,
      "close buffer",
    },
  },
}

return M
