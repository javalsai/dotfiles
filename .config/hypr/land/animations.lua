-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/#animation-tree

for _, leaf in ipairs({ 'workspaces', 'windows' }) do
  hl.animation({
    leaf = leaf,
    enabled = true,
    bezier = 'default',
    speed = 5,
  })
end
