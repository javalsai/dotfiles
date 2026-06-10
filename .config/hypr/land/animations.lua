-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/#animation-tree

-- ease out expo (my eyes easily take 2x the speed from before, feels more responsive without dropping the animation)
hl.curve('my-default', { type = 'bezier', points = { { 0.16, 1 }, { 0.3, 1 } } })

for _, leaf in ipairs({ 'workspaces', 'windows' }) do
  hl.animation({
    leaf = leaf,
    enabled = true,
    bezier = 'my-default',
    speed = 2.8,
  })
end
