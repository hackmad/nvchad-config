---@type ChadrcConfig 
local M = {}

M.plugins = "custom.plugins"

M.ui = {
  theme = 'ayu_dark',
  hl_override = {
    Comment = { fg = "#40e060" },
    LineNr = { fg = "#a0ffa0" },
    CursorLineNr = { fg = "#ff8080" },
    ColorColumn = { bg = "#303030" },
  },
}

M.mappings = require "custom.mappings"

return M
