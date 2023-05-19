local M = {}

M.buffer = {
  n = {
    -- remap escape key from ":noh<cr>" to use lua to stop the highlighting for the 'hlsearch' option.
    -- this way noice cmdline stops popping up which is annoying.
    ["<esc>"] = {
      function()
        vim.api.nvim_command "nohlsearch"
      end,
      "clear search highlight",
    },
    -- cycle buffers.
    ["<S-h>"] = {
      function()
        require("nvchad_ui.tabufline").tabuflinePrev()
      end,
      "goto prev buffer",
    },
    ["<S-l>"] = {
      function()
        require("nvchad_ui.tabufline").tabuflineNext()
      end,
      "goto next buffer",
    },
    -- create/close buffers
    ["<leader>bn"] = { "<cmd>enew<cr>", "new buffer" },
    ["<leader>bx"] = {
      function()
        require("nvchad_ui.tabufline").close_buffer()
      end,
      "close current buffers",
    },
    ["<leader>bX"] = { "<cmd>bufdo bwipeout<cr>", "close all buffers" },
  },
}

M.spectre = {
  n = {
    ["<leader>S"] = { "<cmd>lua require('spectre').open()<cr>", "open spectre" },
    ["<leader>sw"] = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "search current word" },
    ["<leader>sp"] = {
      "<cmd>lua require('spectre').open_file_search({select_word=true})<cr>",
      "search in current file",
    },
  },
  v = {
    ["<leader>sw"] = { "<esc><cmd>lua require('spectre').open_visual()<cr>", "search current word" },
  },
}

M.lazy = {
  n = {
    ["<leader>l"] = { ":Lazy<cr>", "open lazy" },
  },
}

M.flutter = {
  n = {
    ["<leader>ft"] = { ":Telescope flutter commands<cr>", "flutter commands" },
  },
}

M.trouble = {
  n = {
    ["<leader>xx"] = { "<cmd>TroubleToggle<cr>", "toggle trouble" },
    ["<leader>xw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace diagnostics" },
    ["<leader>xd"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "document diagnostics" },
    ["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
    ["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
  },
}

M.telescope = {
  n = {
    ["<leader>fr"] = { "<cmd>Telescope resume<cr>", "resume last picker" },
    ["<leader>fp"] = { "<cmd>Telescope pickers<cr>", "previous pickers" },
  },
}

M.debugger = {
  n = {
    ["<F5>"] = {
      function()
        require("dap").continue()
      end,
      "continue",
    },
    ["<F10>"] = {
      function()
        require("dap").step_over()
      end,
      "step over",
    },
    ["<F11>"] = {
      function()
        require("dap").step_into()
      end,
      "step into",
    },
    ["<F12>"] = {
      function()
        require("dap").step_out()
      end,
      "step out",
    },
    ["<leader>db"] = {
      function()
        require("dap").toggle_breakpoint()
      end,
      "toggle breakpoint",
    },
  },
}

M.disabled = {
  n = {
    -- core/mappings.lua overrides <tab> to cycle buffers which automatically maps <C-i> as well.
    -- which breaks jumplist navigation. So disable <tab>/<S-tab> and map something else in `M.buffers`.
    ["<tab>"] = "",
    ["<S-tab>"] = "",
    -- remapped buffer shortcuts
    ["<leader>b"] = "",
    ["<leader>x"] = "",
  },
}

return M
