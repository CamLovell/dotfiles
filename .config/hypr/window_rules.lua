-- Tagging Rules
hl.window_rule({ match = { class = "^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr|[Ff]irefox-bin)$" }, tag = "+browser" })
hl.window_rule({ match = { class = "^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$" }, tag = "+browser" })
hl.window_rule({ match = { class = "^(chrome-.+-Default)$" }, tag = "+browser" })
hl.window_rule({ match = { class = "^([Cc]hromium)$" }, tag = "+browser" })
hl.window_rule({ match = { class = "^([Mm]icrosoft-edge(-stable|-beta|-dev|-unstable))$" }, tag = "+browser" })
hl.window_rule({ match = { class = "^(Brave-browser(-beta|-dev|-unstable)?)$" }, tag = "+browser" })
hl.window_rule({ match = { class = "^([Tt]horium-browser|[Cc]achy-browser)$" }, tag = "+browser" })
hl.window_rule({ match = { class = "^(app.zen_browser.zen|zen-alpha|zen)$" }, tag = "+browser" })
hl.window_rule({
  match = { class = "^(swaync-control-center|swaync-notification-window|swaync-client|class)$" },
  tag =
  "+notif"
})
hl.window_rule({ match = { title = "^(KooL Quick Cheat Sheet)$" }, tag = "+KooL_Cheat" })
hl.window_rule({ match = { title = "^(KooL Hyprland Settings)$" }, tag = "+KooL_Settings" })
hl.window_rule({ match = { class = "^(nwg-displays|nwg-look)$" }, tag = "+KooL-Settings" })
hl.window_rule({ match = { class = "^(Alacritty|kitty|kitty-dropterm|com.mitchellh.ghostty)$" }, tag = "+terminal" })
hl.window_rule({ match = { class = "^([Tt]hunderbird|org.gnome.Evolution)$" }, tag = "+email" })
hl.window_rule({ match = { class = "^(eu.betterbird.Betterbird)$" }, tag = "+email" })
hl.window_rule({ match = { class = "^(cursor)$" }, tag = "+projects" })
hl.window_rule({ match = { class = "^(codium|codium-url-handler|VSCodium)$" }, tag = "+projects" })
hl.window_rule({ match = { class = "^(VSCode|code-url-handler)$" }, tag = "+projects" })
hl.window_rule({ match = { class = "^(jetbrains-.+)$" }, tag = "+projects" })
hl.window_rule({ match = { class = "^(com.obsproject.Studio)$" }, tag = "+screenshare" })
hl.window_rule({ match = { class = "^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$" }, tag = "+im" })
hl.window_rule({ match = { class = "^([Ff]erdium)$" }, tag = "+im" })
hl.window_rule({ match = { class = "^([Ww]hatsapp-for-linux)$" }, tag = "+im" })
hl.window_rule({ match = { class = "^(ZapZap|com.rtosta.zapzap)$" }, tag = "+im" })
hl.window_rule({ match = { class = "^(org.telegram.desktop|io.github.tdesktop_x64.TDesktop)$" }, tag = "+im" })
hl.window_rule({ match = { class = "^(teams-for-linux)$" }, tag = "+im" })
hl.window_rule({ match = { class = "^(im.riot.Riot|Element)$" }, tag = "+im" })
hl.window_rule({ match = { class = "^(gamescope)$" }, tag = "+games" })
hl.window_rule({ match = { class = "^(steam_app_\\d+)$" }, tag = "+games" })
hl.window_rule({ match = { class = "^([Ss]team)$" }, tag = "+gamestore" })
hl.window_rule({ match = { title = "^([Ll]utris)$" }, tag = "+gamestore" })
hl.window_rule({ match = { class = "^(com.heroicgameslauncher.hgl)$" }, tag = "+gamestore" })
hl.window_rule({ match = { class = "^(nemo|[Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$" }, tag = "+file-manager" })
hl.window_rule({ match = { class = "^(app.drey.Warp)$" }, tag = "+file-manager" })
hl.window_rule({ match = { class = "^([Ww]aytrogen)$" }, tag = "+wallpaper" })
hl.window_rule({ match = { class = "^([Aa]udacious)$" }, tag = "+multimedia" })
hl.window_rule({ match = { class = "^([Mm]pv|vlc)$" }, tag = "+multimedia_video" })
hl.window_rule({ match = { title = "^(ROG Control)$" }, tag = "+settings" })
hl.window_rule({ match = { class = "^(wihotspot(-gui)?)$" }, tag = "+settings" })
hl.window_rule({ match = { class = "^([Bb]aobab|org.gnome.[Bb]aobab)$" }, tag = "+settings" })
hl.window_rule({ match = { class = "^(gnome-disks|wihotspot(-gui)?)$" }, tag = "+settings" })
hl.window_rule({ match = { title = "(Kvantum Manager)" }, tag = "+settings" })
hl.window_rule({ match = { class = "^(file-roller|org.gnome.FileRoller)$" }, tag = "+settings" })
hl.window_rule({ match = { class = "^(nm-applet|nm-connection-editor|blueman-manager)$" }, tag = "+settings" })
hl.window_rule({
  match = { class = "^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$" },
  tag =
  "+settings"
})
hl.window_rule({ match = { class = "^(qt5ct|qt6ct|[Yy]ad)$" }, tag = "+settings" })
hl.window_rule({ match = { class = "(xdg-desktop-portal-gtk)" }, tag = "+settings" })
hl.window_rule({ match = { class = "^(org.kde.polkit-kde-authentication-agent-1)$" }, tag = "+settings" })
hl.window_rule({ match = { class = "^([Rr]ofi)$" }, tag = "+settings" })
hl.window_rule({
  match = { class = "^(gnome-system-monitor|org.gnome.SystemMonitor|io.missioncenter.MissionCenter)$" },
  tag =
  "+viewer"
})
hl.window_rule({ match = { class = "^(evince)$" }, tag = "+viewer" })
hl.window_rule({ match = { class = "^(eog|org.gnome.Loupe)$" }, tag = "+viewer" })

-- Management Rules
hl.window_rule({ match = { tag = "multimedia_video*" }, no_blur = true, opacity = 1.0 })
hl.window_rule({ match = { tag = "KooL_Cheat*" }, center = true, size = { "(monitor_w*0.65)", "(monitor_h*0.9)" } })
hl.window_rule({ match = { class = "(hunar)", title = "negative:(.*[Tt]hunar.*)" }, center = true })
hl.window_rule({ match = { title = "^(ROG Control)$" }, center = true })
hl.window_rule({ match = { tag = "KooL-Settings*" }, center = true })
hl.window_rule({ match = { title = "^(Keybindings)$" }, center = true })
hl.window_rule({ match = { class = "^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$" }, center = true })
hl.window_rule({ match = { class = "^([Ww]hatsapp-for-linux|ZapZap|com.rtosta.zapzap)$" }, center = true })
hl.window_rule({ match = { class = "^([Ff]erdium)$" }, center = true })

hl.window_rule({ match = { tag = "settings*" }, float = true, size = { "(monitor_w*0.7)", "(monitor_h*0.7)" } })
hl.window_rule({ match = { tag = "wallpaper*" }, float = true, size = { "(monitor_w*0.7)", "(monitor_h*0.7)" } })
hl.window_rule({ match = { tag = "viewer*" }, float = true })
hl.window_rule({ match = { tag = "KooL-Settings*" }, float = true })
hl.window_rule({
  match = { title = "^(Authentication Required)$" },
  float = true,
  center = true
})
hl.window_rule({
  match = { title = "^(Picture-in-Picture)$" },
  float = true,
  center = true,
  keep_aspect_ratio = true,
  pin = true
})
hl.window_rule({
  match = { title = "^(SDDM Background)$" },
  float = true,
  center = true,
  size = { "(monitor_w*0.16)", "(monitor_h*0.12)" }
})
hl.window_rule({
  match = { title = "^(Add Folder to Workspace)$" },
  float = true,
  center = true,
  size = { "(monitor_w*0.7)", "(monitor_h*0.6)" }
})
hl.window_rule({
  match = { title = "^(Save As)$" },
  float = true,
  center = true,
  size = { "(monitor_w*0.7)", "(monitor_h*0.6)" }
})
hl.window_rule({
  match = { title = "^(Open Files)$" },
  float = true,
  size = { "(monitor_w*0.7)", "(monitor_h*0.6)" }
})
hl.window_rule({ match = { tag = "KooL-Cheat*" }, float = true })

-- Actually Mine
hl.window_rule({ match = { class = "slack" }, workspace = 1 })
hl.window_rule({ match = { tag = "browser" }, workspace = 2 })
