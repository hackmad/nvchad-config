---@type ChadrcConfig 
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = 'ayu_dark',
  hl_override = {
    Comment = { fg = "#40e060" },
    LineNr = { fg = "#a0ffa0" },
    CursorLineNr = { fg = "#ff8080" },
    ColorColumn = { bg = "#303030" },
  },
}

M.plugins = "custom.plugins"

M.mappings = require "custom.mappings"

return M
