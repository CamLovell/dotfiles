-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()


-- Starting shell
config.default_prog = { '/usr/bin/fish' }

-- Aesthetics
config.color_scheme = "Gruvbox Material (Gogh)"
config.font = wezterm.font({
  family = "FiraCode Nerd Font",
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" }, -- Disable ligatures
})
-- config.font_size = 10.0

-- Tab bar config
config.use_fancy_tab_bar = true
config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.enable_scroll_bar = false

-- Title bar etc
-- config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.window_decorations = "RESIZE"

config.audible_bell = "Disabled"

-- no padding aronud term
-- config.window_padding = {
--   left = 0,
--   right = 0,
--   top = 0,
--   bottom = 0,
-- }

config.adjust_window_size_when_changing_font_size = false
-- and finally, return the configuration to wezterm
return config
