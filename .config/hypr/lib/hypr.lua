---@class HyprCommands
---@field reload string Command to reload hyprland
local M = {
  reload = "touch " .. lib.path.home .. "/.config/hypr/hyprland.lua",
  refresh = lib.path.home .. "/.config/hypr/scripts/Refresh.sh",
  power = lib.path.home .. "/.config/hypr/scripts/Wlogout.sh"
}


---@param keys string|string[]
---@param action string|string[]|function|HL.Dispatcher
---@param opts? HL.BindOptions
function M.bind(keys, action, opts)
  local action_type = type(action)
  if action_type == "string" then
    action = hl.dsp.exec_cmd(action)
  elseif action_type == "table" then
    action = hl.dsp.exec_cmd(table.concat(action, " && "))
  end

  local keys_type = type(keys)
  local key_string
  if keys_type == "table" then
    key_string = table.concat(keys, " + ")
  else
    key_string = keys
  end

  hl.bind(key_string, action, opts)
end

return M
