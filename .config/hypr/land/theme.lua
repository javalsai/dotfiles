local cfg = require 'land.mod.config'
local settings = cfg.settings

local col = {
  primary = 'dd5555',
  secondary = 'ff9922',
}

hl.env('HYPRCURSOR_THEME', 'Nordzy-hyprcursors')
hl.env('XCURSOR_SIZE', settings.cursorSize)
hl.env('HYPRCURSOR_SIZE', settings.cursorSize)

local hlcol = {
  active = '#' .. col.primary .. 'ff',
  inactive = '#' .. col.secondary .. '44',
}

hl.config {
  general = {
    gaps_in = 7,
    gaps_out = 12,

    border_size = 3,
    col = {
      active_border = hlcol.active,
      inactive_border = hlcol.inactive,
    },
  },

  decoration = {
    rounding = settings.winRadius,

    shadow = {
      range = 7,
      render_power = 1,
      color = '#0a0000aa',
      color_inactive = '#00000077',
      offset = { 7, 7 },
    },

    blur = {
      enabled = true,
      size = 3,
      passes = 2,
    },
  },

  group = {
    col = {
      border_active = hlcol.active,
      border_inactive = hlcol.inactive,
    },

    groupbar = {
      font_family = 'Hack Nerd Font',
      font_size = 11,
      height = 20,
      col = hlcol,
    },
  },

  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
  },
}

-- no_gaps_when_only new boi in town (again) (again²)
-- https://wiki.hyprland.org/Configuring/Workspace-Rules#smart-gaps
if settings.noGapsWhenOnly then
  for _, w in ipairs({ 'w[tv1]', 'f[1]' }) do -- workspace with 1 window, fullscreen workspace
    hl.workspace_rule({ workspace = w, gaps_out = 0, gaps_in = 0 })
    hl.window_rule({ match = { workspace = w, float = false }, border_size = 0, rounding = 0 })
  end

  hl.window_rule({ match = { fullscreen = true }, border_size = 0, rounding = 0 })
end
