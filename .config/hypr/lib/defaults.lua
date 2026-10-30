---@class Defaults
---@field term string
---@field files string

---@type Defaults
local M = {
  term = "ghostty",
  files = os.execute("which nemo") and "nemo" or "nautilus"
}

return M
