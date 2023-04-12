local M = {}

M.spectre = {
  n = {
     ["<leader>S"] = {"<cmd>lua require('spectre').open()<CR>", "open spectre"},
     ["<leader>sw"] = {"<cmd>lua require('spectre').open_visual({select_word=true})<CR>", "search current word"},
     ["<leader>sp"] = {"<cmd>lua require('spectre').open_file_search({select_word=true})<CR>", "search in current file"},
  },
  v = {
     ["<leader>sw"] = {"<esc><cmd>lua require('spectre').open_visual()<CR>", "search current word"},
  },
}

M.lazy = {
  n = {
     ["<leader>l"] = {":Lazy<CR>", "open lazy"},
  }
}

M.flutter = {
  n = {
    ["<leader>ft"] = {":Telescope flutter commands<CR>", "flutter commands"},
  }
}

return M
