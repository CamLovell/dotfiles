hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QUICK_CONTROLS_STYLE", "org.hyprland.style")
hl.env("GDK_SCALE", "1")
hl.env("QT_SCALE_FACTOR", "1")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- GPU env for child processes. The NVIDIA userspace libs (libnvidia-*) can be
-- installed without the kernel module (nvidia.ko), and when that happens
-- setting LIBVA_DRIVER_NAME=nvidia etc. makes every child's hardware-accel
-- lookup fail silently and fall back to software - which chews CPU and
-- shows up as general UI lag, especially in Electron apps (Slack, Chrome,
-- 1Password) doing video. Only route children through NVIDIA when the
-- kernel driver is actually loaded; otherwise point at the Intel iGPU.
local function nvidia_driver_loaded()
  local f = io.open("/sys/module/nvidia/version", "r")
  if f then
    f:close()
    return true
  end
  return false
end

if nvidia_driver_loaded() then
  hl.env("LIBVA_DRIVER_NAME", "nvidia")
  hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
  hl.env("NVD_BACKEND", "direct")
else
  -- iHD is the modern Intel VA-API driver (Arc / recent iGPUs).
  hl.env("LIBVA_DRIVER_NAME", "iHD")
end

hl.env("GSK_RENDERER", "ngl")
hl.env("EDITOR", "nvim")
