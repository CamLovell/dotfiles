-- Monitor layout handler for the dock/lid state machine.
--
-- Behaviour matrix:
--   >=2 externals + lid open   : vertical (rotated) + horizontal + eDP-1 below
--   >=2 externals + lid closed : vertical (rotated) + horizontal, eDP-1 off
--    1 external   + lid open   : external at Hyprland default + eDP-1 at 0x0
--    1 external   + lid closed : external at Hyprland default + eDP-1 off
--    0 externals  + lid open   : eDP-1 only, scale 2 at 0x0
--    0 externals  + lid closed : eDP-1 off and `systemctl suspend`
--                                (hypridle's before_sleep_cmd locks first)
--
-- Workspace pinning (>=2 externals only):
--   * Workspace 1 (slack)   -> vertical external
--   * Workspace 2 (browser) -> horizontal external
--
-- External monitors are sorted by Hyprland's monitor id so vertical/horizontal
-- track the physical port rather than the output name. Hyprland names like
-- DP-7 have been seen to change on this machine; the id ordering has not.

local SCALE = 1.0
local OFFSET = 510 / SCALE
local DEBOUNCE_MS = 100
local INTERNAL_OUTPUT = "eDP-1"

-- True when the laptop lid is closed. Globs /proc/acpi/button/lid/*/state so
-- it works regardless of the ACPI device name (LID0, LID, LID1, ...).
local function lid_closed()
  local handle = io.popen("ls /proc/acpi/button/lid/*/state 2>/dev/null")
  if handle == nil then
    return false
  end

  for path in handle:lines() do
    local file = io.open(path, "r")
    if file then
      local content = file:read("*a")
      file:close()
      if content:match("closed") then
        handle:close()
        return true
      end
    end
  end

  handle:close()
  return false
end

-- External monitors (everything except eDP-1) sorted by Hyprland monitor id.
local function external_monitors()
  local externals = {}
  for _, monitor in ipairs(hl.get_monitors()) do
    if monitor.name ~= INTERNAL_OUTPUT then
      table.insert(externals, monitor)
    end
  end
  table.sort(externals, function(a, b) return a.id < b.id end)
  return externals
end

-- Pin workspaces 1 and 2 to their home externals and snap existing instances
-- back onto those monitors. Previous rules are disabled first so repeated
-- apply() calls don't accumulate stale pins.
local workspace_rules = {}

local function pin_workspaces(vertical, horizontal)
  for _, rule in ipairs(workspace_rules) do
    rule:set_enabled(false)
  end
  workspace_rules = {
    hl.workspace_rule({
      workspace = "1",
      monitor = vertical.name,
      persistent = true,
    }),
    hl.workspace_rule({
      workspace = "2",
      monitor = horizontal.name,
      persistent = true,
    }),
  }
  vertical:set_workspace(1)
  horizontal:set_workspace(2)
end

local function configure_dual_externals(externals, lid)
  local horizontal = externals[1]
  local vertical = externals[2]

  -- Vertical panel is rotated 90 degrees. Its logical width after rotation
  -- equals the shorter of its native dimensions.
  local rotated_width = math.min(vertical.width, vertical.height) / SCALE

  hl.monitor({
    output = vertical.name,
    mode = "preferred",
    position = "0x0",
    transform = 1,
    scale = SCALE,
  })
  hl.monitor({
    output = horizontal.name,
    mode = "preferred",
    position = string.format("%dx%d", rotated_width, OFFSET),
    scale = SCALE,
  })
  hl.monitor({
    output = INTERNAL_OUTPUT,
    mode = "preferred",
    position = string.format("%dx%d", rotated_width, rotated_width + OFFSET),
    scale = 2,
    disabled = lid,
  })

  pin_workspaces(vertical, horizontal)
end

local function configure_single_external(lid)
  -- No special layout for the single-external case: leave the external at
  -- whatever Hyprland auto-placement decided and just track lid state on
  -- eDP-1.
  hl.monitor({
    output = INTERNAL_OUTPUT,
    mode = "preferred",
    position = "0x0",
    scale = 2,
    disabled = lid,
  })
end

local function configure_no_externals(lid)
  if lid then
    hl.monitor({ output = INTERNAL_OUTPUT, disabled = true })
    -- hypridle's before_sleep_cmd=loginctl lock-session locks before sleep.
    hl.exec_cmd("systemctl suspend")
  else
    hl.monitor({
      output = INTERNAL_OUTPUT,
      mode = "preferred",
      position = "0x0",
      scale = 2,
    })
  end
end

local function apply()
  local externals = external_monitors()
  local lid = lid_closed()

  if #externals >= 2 then
    configure_dual_externals(externals, lid)
  elseif #externals == 1 then
    configure_single_external(lid)
  else
    configure_no_externals(lid)
  end
end

-- Debounce rapid monitor.added/monitor.removed bursts so a dock plug (which
-- fires monitor.added twice in quick succession) only runs apply() once.
local pending_timer

local function setup_monitors()
  if pending_timer then
    pending_timer:set_enabled(false)
    pending_timer = nil
  end
  pending_timer = hl.timer(function()
    pending_timer = nil
    apply()
  end, { timeout = DEBOUNCE_MS, type = "oneshot" })
end

hl.on("monitor.added", setup_monitors)
hl.on("monitor.removed", setup_monitors)
lib.hypr.bind("switch:Lid Switch", setup_monitors, { locked = true })

-- Apply once at load so a `touch hyprland.lua` reload (which doesn't re-fire
-- monitor.added) still runs the layout. On a fresh startup the debounce
-- coalesces this with the per-monitor added events.
setup_monitors()
