local cfg = require 'land.mod.config'
local hostname = cfg.hostname

if hostname == 'the-art' then
  -- hl.monitor({ output = 'DP-1', mode = '1920x1080@165', position = '1440x0', scale = 1 })
  hl.monitor({ output = 'DP-1', mode = '1920x1080@165', position = '0x0', scale = 1 })
  hl.workspace_rule({ workspace = '1', monitor = 'DP-1', default = true })
  -- hl.monitor({ output = "HDMI-A-1", mode = "1440x900@60", position = "0x90", scale = 1 })
  hl.monitor({ output = 'HDMI-A-1', disabled = true })
  -- hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1", default = true })
elseif hostname == 'laptop' then
  hl.monitor({ output = 'eDP-1', mode = '1920x1080@60', position = '0x0', scale = 1.2 })
end

hl.monitor({ output = '', mode = 'preferred', position = 'auto', scale = 1 })

hl.config({
  xwayland = { force_zero_scaling = true },
})
