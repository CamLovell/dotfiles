local colours = require("colours")

hl.config({
  general = {
    resize_on_border = true,
    layout = "dwindle",
    border_size = 2,
    gaps_in = 2,
    gaps_out = 4,
    col = {
      active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
      inactive_border = "rgba(595959aa)"
    },
  },

  decoration = {
    rounding = 10,

    active_opacity = 1.0,
    inactive_opacity = 1.0,
    fullscreen_opacity = 1.0,

    dim_inactive = true,
    dim_strength = 0.05,
    dim_special = 0.8,

    shadow = {
      enabled = false,
      range = 3,
      render_power = 1,

      color = colours.color12,
      color_inactive = colours.color10,
    },


    blur = {
      enabled = true,
      size = 6,
      passes = 2,
      ignore_opacity = true,
      new_optimizations = true,
      special = true,
      popups = true,
    },
  },
  group = {
    col = { border_active = colours.color15 },

    groupbar = {
      col = { active = colours.color0 },
    }
  },
  animations = { enabled = false },
  dwindle = {
    preserve_split = true,
    special_scale_factor = 0.8,
  },
  master = {
    new_status = "master",
    new_on_top = 1,
    mfact = 0.5,
  },
  input = {
    kb_layout = "us",
    repeat_rate = 50,
    repeat_delay = 300,

    sensitivity = 0,
    numlock_by_default = true,
    left_handed = false,
    follow_mouse = 1,
    float_switch_override_focus = false,

    touchpad = {
      disable_while_typing = true,
      natural_scroll = true,
      clickfinger_behavior = false,
      middle_button_emulation = false,
      tap_to_click = true,
      drag_lock = false,
    },

    touchdevice = {
      enabled = true,
    },

    tablet = {
      transform = 0,
      left_handed = 0,
    },
  },
  gestures = {
    -- May need to actually add a gesture with hl.gesture
    workspace_swipe_distance = 500,
    workspace_swipe_invert = true,
    workspace_swipe_min_speed_to_force = 30,
    workspace_swipe_cancel_ratio = 0.5,
    workspace_swipe_create_new = true,
    workspace_swipe_forever = true,
  },
  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    vrr = 2,
    mouse_move_enables_dpms = true,
    focus_on_activate = true,
    initial_workspace_tracking = 0,
    middle_click_paste = false,
    enable_anr_dialog = true,
    anr_missed_pings = 15,
    allow_session_lock_restore = true,
  },
  binds = {
    workspace_back_and_forth = false,
    allow_workspace_cycles = true,
    pass_mouse_when_bound = false,
  },
  xwayland = {
    enabled = true,
    force_zero_scaling = true,
  },

  render = {
    direct_scanout = 0,
  },

  cursor = {
    sync_gsettings_theme = true,
    no_hardware_cursors = 1,
    enable_hyprcursor = true,
    warp_on_change_workspace = 2,
    -- no_warps = true
  }
})
