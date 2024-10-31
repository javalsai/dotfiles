local bg = '#151515'
local fg = '#b2b5b3'
local bright_bg = '#2d3234'
local bright_fg = '#c5c8c6'
local black = '#131415'
local white = '#eaeaea'

return {
  tab_bar = {
    background = black,
    active_tab = {
      bg_color = bg,
      fg_color = bright_fg,
      intensity = 'Bold', -- "Half" "Normal" "Bold"
      underline = 'None', -- "None" "Single" "Double"
      italic = false,
      strikethrough = false,
    },
    inactive_tab = {
      bg_color = black,
      fg_color = fg,
    },
    new_tab = {
      bg_color = black,
      fg_color = fg,
    },
    inactive_tab_hover = {
      bg_color = black,
      fg_color = bright_fg,
      italic = false,
    },
    new_tab_hover = {
      bg_color = bg,
      fg_color = bright_fg,
      italic = false,
    },
  },
  background = bg,
  foreground = fg,
  cursor_bg = fg,
  cursor_fg = black,
  cursor_border = fg,
  selection_fg = black,
  selection_bg = fg,
  scrollbar_thumb = fg,
  split = black,
  ansi = {
    -- bg,
    '#4d5254',
    '#cc6666',
    '#b5bd68',
    '#f0c674',
    '#81a2be',
    '#b294bb',
    '#8abeb7',
    '#c5c8c6',
  },
  brights = {
    '#676665',
    '#d54e53',
    '#b9ca4a',
    '#e7c547',
    '#7aa6da',
    '#c397d8',
    '#70c0b1',
    '#eaeaea',
  },
}
