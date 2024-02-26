local wezterm = require 'wezterm'

return {
  { key = 'o', mods = 'CTRL|ALT', action = wezterm.action.EmitEvent 'toggle-opacity' },
}
