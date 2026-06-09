--- @param volDelta number
local function volumeChange(volDelta)
  local sign = '+'
  if volDelta < 0 then sign = '-' end

  local volStr = math.abs(volDelta) .. '%' .. sign
  return hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ ' .. volStr)
end

-- volume
for name, direction in pairs({
  XF86AudioRaiseVolume = 1,
  XF86AudioLowerVolume = -1,
}) do
  local bindle = { repeating = true, locked = true }

  hl.bind(name, volumeChange(5 * direction), bindle)
  hl.bind('SHIFT + ' .. name, volumeChange(2 * direction), bindle)
  hl.bind('CTRL + ' .. name, volumeChange(15 * direction), bindle)
end

-- prev/next
for name, direction in pairs({
  XF86AudioPrev = { '-', 'previous' },
  XF86AudioNext = { '+', 'next' },
}) do
  local directionS, directionW = direction[1], direction[2]
  local binde = { repeating = true }

  hl.bind(name, hl.dsp.exec_cmd('playerctl ' .. directionW), binde)
  hl.bind('SHIFT + ' .. name, hl.dsp.exec_cmd('playerctl position 1.5' .. directionS), binde)
  hl.bind('CTRL + ' .. name, hl.dsp.exec_cmd('playerctl position 7.5' .. directionS), binde)
end

-- misc
hl.bind('XF86AudioMute', hl.dsp.exec_cmd('amixer set Master toggle'), { locked = true })
hl.bind('XF86AudioStop', hl.dsp.exec_cmd('playerctl stop'))
hl.bind('XF86AudioPlay', hl.dsp.exec_cmd('playerctl play-pause'))
hl.bind('ALT + XF86AudioPlay', hl.dsp.exec_cmd('playerctl pause -a'))

---- Brightness Keys
for name, direction in pairs({
  XF86MonBrightnessDown = { '-', 0 },
  XF86MonBrightnessUp = { '+', 100 },
}) do
  local sign, edge = direction[1], direction[2]

  hl.bind(name, hl.dsp.exec_cmd('brightnessctl set 15%' .. sign))
  hl.bind('SHIFT + ' .. name, hl.dsp.exec_cmd('brightnessctl set 5%' .. sign))
  hl.bind('CTRL + ' .. name, hl.dsp.exec_cmd('brightnessctl set ' .. edge .. '%'))
end
