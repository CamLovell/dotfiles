-- Direction Mapkey
local window_movement_keys = {
  l = { "H", "left" },
  r = { "L", "right" },
  u = { "K", "up" },
  d = { "J", "down" },
}

-- Programs
lib.hypr.bind({ "SUPER", "T" }, lib.defaults.term)
lib.hypr.bind({ "SUPER", "F" }, lib.defaults.files)
lib.hypr.bind({ "SUPER", "B" }, "xdg-open https://")
lib.hypr.bind({ "SUPER", "O" }, "obsidian")

-- Operations
lib.hypr.bind({ "CTRL", "ALT", "L" }, "loginctl lock-session")
lib.hypr.bind({ "CTRL", "ALT", "P" }, lib.hypr.power)
-- hl.bind(keys( SHIFT, N, exec, swaync-client -t -sw # swayNC notification panel
-- bind = $mainMod SHIFT, E, exec, $scriptsDir/Kool_Quick_Settings.sh # Settings Menu KooL Hyprland Settings

-- Rofi
lib.hypr.bind({ "SUPER", "space" }, "pkill rofi || true && rofi -show drun -modi drun,filebrowser,run,window")


-- Window Management
lib.hypr.bind({ "SUPER", "Q" }, hl.dsp.window.close("activewindow"))
lib.hypr.bind({ "SUPER", "G" }, hl.dsp.window.float({ action = "toggle" }))
lib.hypr.bind({ "SUPER", "M" }, hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

for dir, maps in pairs(window_movement_keys) do
  for _, key in ipairs(maps) do
    lib.hypr.bind({ "SUPER", key }, hl.dsp.focus({ direction = dir }))
    lib.hypr.bind({ "SUPER", "SHIFT", key }, hl.dsp.window.move({ direction = dir }))
    lib.hypr.bind({ "SUPER", "CTRL", key }, hl.dsp.window.move({ direction = dir, follow = false }))
    lib.hypr.bind({ "SUPER", "ALT", key }, hl.dsp.workspace.move({ monitor = dir }))
    -- lib.hypr.bind({"SUPER", "ALT", key}, hl.dsp.window.swap({ direction = dir }))
  end
end

for i = 1, 10 do
  lib.hypr.bind({ "SUPER", string.format("code:%d", i + 9) }, hl.dsp.focus({ workspace = i }))
  lib.hypr.bind({ "SUPER", "SHIFT", string.format("code:%d", i + 9) }, hl.dsp.window.move({ workspace = i }))
  lib.hypr.bind({ "SUPER", "CTRL", string.format("code:%d", i + 9) },
    hl.dsp.window.move({ workspace = i, follow = false }))
end

lib.hypr.bind({ "SUPER", "U" }, hl.dsp.workspace.toggle_special("scratchpad"))
lib.hypr.bind({ "SUPER", "SHIFT", "U" }, hl.dsp.window.move({ workspace = "special:scratchpad" }))
lib.hypr.bind({ "SUPER", "CTRL", "U" }, hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))

lib.hypr.bind({ "SUPER", "comma" }, hl.dsp.focus({ workspace = "-1" }))
lib.hypr.bind({ "SUPER", "period" }, hl.dsp.focus({ workspace = "+1" }))
lib.hypr.bind({ "SUPER", "SHIFT", "comma" }, hl.dsp.window.move({ workspace = "-1" }))
lib.hypr.bind({ "SUPER", "SHIFT", "period" }, hl.dsp.window.move({ workspace = "+1" }))
lib.hypr.bind({ "SUPER", "CTRL", "comma" }, hl.dsp.window.move({ workspace = "-1", follow = false }))
lib.hypr.bind({ "SUPER", "CTRL", "period" }, hl.dsp.window.move({ workspace = "+1", follow = false }))

lib.hypr.bind({ "ALT", "tab" }, hl.dsp.window.cycle_next())
lib.hypr.bind({ "ALT", "tab" }, hl.dsp.window.bring_to_top())

lib.hypr.bind({ "SUPER", "mouse:272" }, hl.dsp.window.drag(), { mouse = true })
lib.hypr.bind({ "SUPER", "mouse:273" }, hl.dsp.window.resize(), { mouse = true })
lib.hypr.bind({ "SUPER", "mouse_down" }, hl.dsp.focus({ workspace = "+1" }))
lib.hypr.bind({ "SUPER", "mouse_up" }, hl.dsp.focus({ workspace = "-1" }))

-- Special Control Keys
lib.hypr.bind("xf86audioraisevolume", lib.ctrl.volume.raise({ sound = true }), { locked = true, repeating = true })
lib.hypr.bind("xf86audiolowervolume", lib.ctrl.volume.lower({ sound = true }), { locked = true, repeating = true })
lib.hypr.bind("xf86AudioMicMute", lib.ctrl.mic.toggle_mute(), { locked = true })
lib.hypr.bind("xf86audiomute", lib.ctrl.volume.toggle_mute(), { locked = true })
lib.hypr.bind("xf86Sleep", "systemctl suspend", { locked = true })

-- Media controls
lib.hypr.bind("xf86AudioPause", lib.ctrl.media.toggle_play(), { locked = true })
lib.hypr.bind("xf86AudioPlay", lib.ctrl.media.toggle_play(), { locked = true })
lib.hypr.bind("xf86AudioNext", lib.ctrl.media.next(), { locked = true })
lib.hypr.bind("xf86AudioPrev", lib.ctrl.media.previous(), { locked = true })
lib.hypr.bind("xf86audiostop", lib.ctrl.media.stop(), { locked = true })

-- Laptop Controls
lib.hypr.bind("xf86MonBrightnessDown", lib.ctrl.brightness.lower()) -- decrease monitor brightness
lib.hypr.bind("xf86MonBrightnessUp", lib.ctrl.brightness.raise())   -- increase monitor brightness

-- Screenshots
lib.hypr.bind("Print", lib.ctrl.screenshot("area"))
lib.hypr.bind({ "SUPER", "Print" }, lib.ctrl.screenshot("now"))
lib.hypr.bind({ "SUPER", "SHIFT", "Print" }, lib.ctrl.screenshot("win"))

-- Other Scripts
lib.hypr.bind({ "SUPER", "ALT", "R" }, { lib.hypr.refresh, lib.hypr.reload })
