local cfg = require 'land.mod.config'
local settings = cfg.settings

hl.config {
  input = {
    follow_mouse = 2,
    float_switch_override_focus = 0,

    kb_layout = 'es',
    repeat_rate = 35,
    repeat_delay = 200,

    touchpad = {
      natural_scroll = true,
      disable_while_typing = false,
      -- middle_button_emulation = true
      drag_3fg = 1,
    },
  },

  ecosystem = {
    no_update_news = true,
    no_donation_nag = true,
  },

  misc = {
    focus_on_activate = true,
  },

  -- idek where this is now though, not sure if in `hl.config`
  dwindle = {
    -- thing is, I do love this when I'm with several windows or when I put the
    -- cursor on the edge of the screen, BUT usually i just want new windows to
    -- show on my left/right side when im in single window and my cursor never
    -- in a position for that.
    --
    -- I'd love to see this but if your cursor is a window insted of a gap it
    -- places the new window vertically splitting that window, not with the
    -- relative pos or whatever
    --
    -- smart_split = true
  },
}

----- window rules

local careful_xorg_matches = {
  -- odd steam games that dont like animated resize
  { class = 'steam_app.*', xwayland = true },
}

for _, match in ipairs(careful_xorg_matches) do
  hl.window_rule({ match = match, no_anim = true })
end

-----

local float_windows_matches = {
  -- zapzap save file
  { title = 'Save file',          class = 'com\\.rtosta\\.zapzap' },
  -- gimp layer select
  { title = 'Layer Select',       class = 'gimp'                  },
  -- gimp export
  { title = 'Export Image as .*', class = 'file-.*'               },
}

for _, match in ipairs(float_windows_matches) do
  hl.window_rule({ match = match, float = true })
end

-----

hl.window_rule(settings.float:asWindowRule {
  match = { class = '.*-float' },
})

-----

hl.layer_rule { match = { namespace = 'vicinae' }, blur = true, ignore_alpha = 0, no_anim = true }
