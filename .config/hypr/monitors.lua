-- Set scale of external monitors
local scale = 1.0
local offset = 510 / scale

-- Helper functions
local function lid_closed()
  local file = io.open("/proc/acpi/button/lid/LID0/state", "r")

  if not file then
    return false
  end

  local content = file:read("*a")
  file:close()

  return content:match("closed") ~= nil
end

-- Get external monitors sorted by output id
local function setup_monitors()
  local monitors = hl.get_monitors()

  ---@type HL.Monitor[]
  local external_monitors = {}

  for _, monitor in ipairs(monitors) do
    if monitor.name ~= "eDP-1" then
      table.insert(external_monitors, monitor)
    end
  end

  table.sort(external_monitors, function(a, b)
    return a.id < b.id
  end)

  -- Actually configure monitors
  if #external_monitors == 2 then
    local horrizontal = external_monitors[1]
    local vertical = external_monitors[2]
    hl.monitor({
      output = vertical.name,
      mode = "preferred",
      position = "0x0",
      transform = 1,
      scale = tostring(scale),
    })

    hl.monitor({
      output = horrizontal.name,
      mode = "preferred",
      position = string.format("%dx%d", vertical.height / scale, offset),
      scale = tostring(scale)
    })
    hl.monitor({
      output = "eDP-1",
      mode = "preferred",
      position = string.format("%dx%d", vertical.height / scale, vertical.height / scale + offset),
      scale = "2",
      disabled = lid_closed(),
    })
  else
    hl.monitor({
      output = "eDP-1",
      mode = "preferred",
      position = "0x0",
      scale = "2",
    })
  end
end


hl.on("monitor.added", setup_monitors)
hl.on("monitor.removed", setup_monitors)
lib.hypr.bind("switch:Lid Switch", setup_monitors, { locked = true })
