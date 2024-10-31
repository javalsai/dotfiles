local wezterm = require 'wezterm'
require('events')

return {
  colors = require('theme'),
  window_frame = {
    active_titlebar_bg = '#333333',
    inactive_titlebar_bg = '#333333',
  },
  use_fancy_tab_bar = true,
  font = wezterm.font 'Hack Nerd Font',
  font_size = 10.5,
  default_cursor_style = 'BlinkingBar',

  window_close_confirmation = 'NeverPrompt',
  hide_tab_bar_if_only_one_tab = true,

  enable_scroll_bar = false;
  enable_wayland = false,
  window_padding = {
    top    = '3px',
    right  = '3px',
    bottom = '3px',
    left   = '3px',
  },

  inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.8,
  },

  window_background_opacity = .85,
  text_background_opacity = 1.0,

  keys = require('keys')
}
