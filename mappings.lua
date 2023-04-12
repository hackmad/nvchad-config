local M = {}

M.custom = {
  n = {
     ["<leader>S"] = {"<cmd>lua require('spectre').open()<CR>", "Open Spectre"},
     ["<leader>sw"] = {"<cmd>lua require('spectre').open_visual({select_word=true})<CR>", "Search current word"},
     ["<leader>sp"] = {"<cmd>lua require('spectre').open_file_search({select_word=true})<CR>", "Search in current file"},
  },
  v = {
     ["<leader>sw"] = {"<esc><cmd>lua require('spectre').open_visual()<CR>", "Search current word"},
  },
}

return M
