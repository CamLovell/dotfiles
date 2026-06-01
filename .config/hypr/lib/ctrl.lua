local M = {}

---@class VolumeOpts
---@field sound boolean
---@alias VolumeFn fun(opts?: VolumeOpts) : string

---@param cmd string
---@return VolumeFn
local function maybe_with_sound(cmd)
  return function(opts)
    if opts ~= nil and opts.sound then
      return cmd .. " && " .. "pw-play /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga"
    else
      return cmd
    end
  end
end

M.volume = {
  raise = maybe_with_sound("swayosd-client --output-volume raise"),
  lower = maybe_with_sound("swayosd-client --output-volume lower"),
  toggle_mute = maybe_with_sound("swayosd-client --output-volume mute-toggle"),
}

M.mic = {
  raise = function() return "swayosd-client --input-volume raise" end,
  lower = function() return "swayosd-client --input-volume lower" end,
  toggle_mute = function() return "swayosd-client --input-volume mute-toggle" end,
}

M.brightness = {
  raise = function() return "swayosd-client --brightness raise --device intel_backlight" end,
  lower = function() return "swayosd-client --brightness lower --device intel_backlight" end,
}

M.media = {
  toggle_play = function() return "swayosd-client --playerctl play-pause" end,
  play = function() return "swayosd-client --playerctl play" end,
  pause = function() return "swayosd-client --playerctl pause" end,
  stop = function() return "swayosd-client --playerctl stop" end,
  next = function() return "swayosd-client --playerctl next" end,
  previous = function() return "swayosd-client --playerctl prev" end,
  shuffle = function() return "swayosd-client --playerctl shuffle" end,
}


-- TODO: Modify this to actually be configurable rather than hard coded

---@param mode "now" | "area" | "win" | "active" | "in5" | "in10"
---@return string
function M.screenshot(mode)
  return lib.path.home .. "/.config/hypr/scripts/ScreenShot.sh --" .. mode
end

return M
