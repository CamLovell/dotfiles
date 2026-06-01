---@param path string
---@return string
local function prepend_slash(path)
  if path:find('/', 1, true) == nil then
    path = "/" .. path
  end
  return path
end

local M = {}

M.home = os.getenv("HOME")

---@param path string
---@return string
function M.hypr_script(path)
  return M.home .. "/.config/hypr/scripts" .. prepend_slash(path)
end

---@param path string
---@return string
function M.user_script(path)
  return M.home .. "/.config/hypr/UserScripts" .. prepend_slash(path)
end

return M
