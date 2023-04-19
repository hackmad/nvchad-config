-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  Comment = { fg = "#00d060" },
  ColorColumn = { bg = "#303030" },

  CursorLineNr = { fg = "cyan" },
  LineNr = { fg = "#d0d0d0" },

  St_gitIcons = { fg = "#80ff80" },

  TbLineBufOn = { fg = "white" },
  TbLineBufOff = { fg = "#b0b0b0" },

  Visual = { bg = "grey", fg = "#ffe5b4" },

  NvimTreeOpenedFolderIcon = { fg = "green", bold = true },
  NvimTreeOpenedFolderName = { fg = "green", bold = true },
}

---@type HLTable
M.add = {
  FidgetTitle = { fg = "#e0a0a0" },
  FidgetTask = { fg = "#e0e0a0" },
}

return M
