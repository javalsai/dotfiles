local cfg = require 'land.mod.config'
local mainMod, programs = cfg.mainMod, cfg.programs

hl.gesture({ fingers = 2, direction = 'pinch', mods = mainMod, action = 'resize' })

hl.gesture({ fingers = 3, direction = 'swipe', mods = mainMod, action = 'move' })

--- @param dsp HL.Dispatcher
--- @return function
local function fundsp(dsp)
  return function()
    hl.dispatch(dsp)
  end
end

hl.gesture({ fingers = 4, direction = 'horizontal', action = 'workspace' })
hl.gesture({
  fingers = 4,
  direction = 'left',
  mods = 'CTRL',
  action = fundsp(hl.dsp.workspace.move({ monitor = 'e+1' })),
})
hl.gesture({
  fingers = 4,
  direction = 'right',
  mods = 'CTRL',
  action = fundsp(hl.dsp.workspace.move({ monitor = 'e-1' })),
})

hl.gesture({ fingers = 4, direction = 'down', action = fundsp(hl.dsp.window.float { action = 'float' }) })
hl.gesture({ fingers = 4, direction = 'up', action = fundsp(hl.dsp.window.float { action = 'tile' }) })

hl.gesture({ fingers = 4, direction = 'up', mods = mainMod, action = fundsp(hl.dsp.exec_cmd(programs.browser)) })
hl.gesture({ fingers = 4, direction = 'left', mods = mainMod, action = fundsp(hl.dsp.exec_cmd(programs.fileManager)) })
hl.gesture({ fingers = 4, direction = 'down', mods = mainMod, action = fundsp(hl.dsp.exec_cmd(programs.terminal)) })
