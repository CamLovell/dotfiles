local startup_apps = {
  "hyprpaper",
  "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
  "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
  "gnome-keyring-daemon --start --components=secrets",
  lib.path.hypr_script("Polkit.sh"),
  "nm-applet --indicator",
  "swaync",
  "swayosd-server",
  "blueman-applet",
  "waybar",
  "wl-paste --type text --watch cliphist store",
  "wl-paste --type image --watch cliphist store",
  "hypridle",
  "fc-cache",
  "1password --silent"
}

hl.on("hyprland.start", function()
  for _, app in ipairs(startup_apps) do
    hl.exec_cmd(app)
  end
end)
