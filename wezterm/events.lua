local wezterm = require 'wezterm'

wezterm.on('padding-off', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if not overrides.window_padding then
    overrides.window_padding = {
      top    = '0',
      right  = '0',
      bottom = '0',
      left   = '0',
    }
  else
    overrides.window_padding = nil
  end
  window:set_config_overrides(overrides)
end)

wezterm.on('toggle-opacity', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if overrides.window_background_opacity == 0 then
    overrides.window_background_opacity = 1
  elseif overrides.window_background_opacity == 1 then
    overrides.window_background_opacity = .85
  else
    overrides.window_background_opacity = 0
  end

  window:set_config_overrides(overrides)
end)
