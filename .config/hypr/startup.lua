local startup_apps = {
  "hyprpaper",
  "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
  "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
  -- lib.path.home .. "/.config/hypr/scripts/Dropterminal.sh" .. "ghostty &",
  lib.path.hypr_script("Polkit.sh"),
  "nm-applet --indicator",
  "swaync",
  "swayosd-server",
  "blueman-applet",
  "waybar",
  "wl-paste --type text --watch cliphist store",
  "wl-paste --type image --watch cliphist store",
  lib.path.user_script("RainbowBorders.sh"),
  "hypridle",
  -- lib.path.hypr_script("PortalHyprland.sh"),
  "fc-cache"
}

hl.on("hyprland.start", function()
  for _, app in ipairs(startup_apps) do
    hl.exec_cmd(app)
  end
end)
