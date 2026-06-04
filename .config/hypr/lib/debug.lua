local M = {}

local KEY_PATTERN = "^[%a_][%w_]*$"

---@param value any
---@param indent integer
---@param seen table<table, boolean>
---@return string
local function format(value, indent, seen)
  local t = type(value)

  if t == "string" then
    return string.format("%q", value)
  elseif t == "number" or t == "boolean" or t == "nil" then
    return tostring(value)
  elseif t ~= "table" then
    return string.format("%q", tostring(value))
  end

  if seen[value] then
    return "<cycle>"
  end
  seen[value] = true

  local pad = string.rep("  ", indent)
  local inner_pad = string.rep("  ", indent + 1)

  local keys = {}
  for k in pairs(value) do
    keys[#keys + 1] = k
  end
  if #keys == 0 then
    seen[value] = nil
    return "{}"
  end
  table.sort(keys, function(a, b)
    return tostring(a) < tostring(b)
  end)

  local lines = { "{" }
  for _, k in ipairs(keys) do
    local key_str
    if type(k) == "string" and k:match(KEY_PATTERN) then
      key_str = k
    else
      key_str = "[" .. format(k, indent + 1, seen) .. "]"
    end
    lines[#lines + 1] = inner_pad .. key_str .. " = " .. format(value[k], indent + 1, seen) .. ","
  end
  lines[#lines + 1] = pad .. "}"
  seen[value] = nil
  return table.concat(lines, "\n")
end

---@param tbl table
---@return string
function M.format(tbl)
  return format(tbl, 0, {})
end

---@param tbl table The table to pretty print
---@param path string File path to write to
---@param append? boolean File path to write to
function M.dump(tbl, path, append)
  local mode = append and "a+" or "w"
  local file, err = io.open(path, mode)
  if not file then
    error("could not open file " .. path .. ": " .. (err or "unknown error"))
  end
  file:write(M.format(tbl))
  file:write("\n")
  file:close()
end

return M
