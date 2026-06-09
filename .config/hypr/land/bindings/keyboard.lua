local util = require 'land.mod.util'
-- local ui = require 'land.mod.ui'

local cfg = require 'land.mod.config'
local mainMod, settings, programs = cfg.mainMod, cfg.settings, cfg.programs

local cmd = {
  cmdPalette = 'vicinae deeplink vicinae://pop_to_root; vicinae vicinae://toggle',
  genericAppLauncher = 'vicinae deeplink vicinae://launch/applications?toggle=true',
  locker = 'hyprlock',
  hibernate = 'hibernate',
}

hl.bind(mainMod .. ' + p', hl.dsp.exec_cmd(cmd.cmdPalette))
hl.bind(mainMod .. ' + SHIFT + p', hl.dsp.exec_cmd(cmd.genericAppLauncher))
hl.bind(mainMod .. ' + Tab',
  hl.dsp.exec_cmd('killall wofi; hyprctl dispatch "hl.dsp.focus({ window = \\"address:$(hypr-window-chooser)\\" })"'))

hl.bind(mainMod .. ' + z', hl.dsp.exec_cmd(cmd.locker))
hl.bind(mainMod .. ' + SHIFT + z', hl.dsp.exec_cmd(cmd.locker))
hl.bind(mainMod .. ' + SHIFT + z', hl.dsp.exec_cmd(cmd.hibernate))
hl.bind('switch:on:Lid Switch', hl.dsp.exec_cmd(cmd.locker))

hl.bind('ALT + Tab', function()
  hl.dispatch(hl.dsp.window.cycle_next())
  hl.dispatch(hl.dsp.window.bring_to_top())
end)
hl.bind('ALT + SHIFT + Tab', hl.dsp.group.next())
hl.bind(mainMod .. ' + Space', function()
  local address = util.getHovered()
  if address == nil then return end

  hl.dispatch(hl.dsp.focus({ window = 'address:' .. address }))
end)

-- FIXME: idek how-to atp, one thing blocks or on other side I cannot get internal state
-- might as well do this with a qs window picker and fancy methods
-- hl.bind(mainMod .. ' + s', hl.dsp.exec_cmd('scratchpad'))
-- hl.bind(mainMod .. ' + SHIFT + s', hl.dsp.exec_cmd('scratchpad -g'))

---- App Launchers
for k, program in pairs({
  ['return'] = programs.terminal,
  w = programs.browser,
  ['ALT + w'] = programs.privateBrowser,
  e = programs.fileManager,
  n = programs.terminal .. ' nvim',
  k = programs.terminal .. ' qalc',
}) do
  hl.bind(mainMod .. ' + ' .. k, hl.dsp.exec_cmd(program))

  local fProgram = util.subPrefix(program, programs.terminal, programs.terminalFloat)
  hl.bind(mainMod .. ' + SHIFT + ' .. k,
    hl.dsp.exec_cmd(settings.float:asExec() .. ' ' .. fProgram))
end

---- Desktop Bindings
-- clipboard
hl.bind(mainMod .. ' + v', hl.dsp.exec_cmd('vicinae deeplink vicinae://launch/clipboard/history'))
hl.bind(mainMod .. ' + SHIFT + v', hl.dsp.exec_cmd('vicinae deeplink vicinae://launch/clipboard/clear-history'))

-- notifications
hl.bind(mainMod .. ' + ALT + h', hl.dsp.exec_cmd('dunstctl history-pop'))
hl.bind(mainMod .. ' + ALT + n', hl.dsp.exec_cmd('dunstctl close'))

---- Base Window/Hyprland Bindings
hl.bind(mainMod .. ' + mouse:272', hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. ' + mouse:273', hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. ' + delete', hl.dsp.exit())
hl.bind(mainMod .. ' + q', hl.dsp.window.close())
hl.bind(mainMod .. ' + f', hl.dsp.window.float())
hl.bind(mainMod .. ' + h', hl.dsp.window.fullscreen())
hl.bind(mainMod .. ' + SHIFT + h', hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(mainMod .. ' + t', hl.dsp.group.toggle()) -- tab

-- e±<float> worked for relative alpha a BIG time ago tho 😔
-- one day I'll be able to getprop and compute relative with that
for k, v in pairs({
  mouse_down = 1,
  mouse_up = 0.5,
}) do
  hl.bind(mainMod .. ' + ' .. k, function()
    local hovered = util.getHovered()
    if hovered == nil then return end

    hl.dispatch(hl.dsp.window.set_prop({ window = hovered, prop = 'opacity', value = v }))
    hl.dispatch(hl.dsp.window.set_prop({ window = hovered, prop = 'opacity_inactive', value = v }))
    -- there's also _fullscreen, and _override variants of each of these
  end)
end

---- Workspaces
for k, v in pairs(util.spreadTables({
  {
    masculine = 'previous',
    left = 'e-1',
    right = 'e+1',
  },
  util.mkrange(1, 9),
})) do
  hl.bind(mainMod .. ' + ' .. k, hl.dsp.focus({ workspace = v, on_current_monitor = true }))
  hl.bind(mainMod .. ' + SHIFT + ' .. k, hl.dsp.window.move({ workspace = v }))
end

-- TODO: maybe a bindings to change focused window to other monitor if there's 2??

---- Directional Bindings
for _, fqdirection in ipairs({
  { 'up',    'u', 'k', { x = 0, y = -1 } },
  { 'down',  'd', 'j', { x = 0, y = 1 }  },
  { 'left',  'l', 'h', { x = -1, y = 0 } },
  { 'right', 'r', 'l', { x = 1, y = 0 }  },
}) do
  local o = { repeating = true }
  local arrow, direction, vimlike, delta =
      fqdirection[1], fqdirection[2], fqdirection[3], fqdirection[4]

  local relative15DeltaOpts = { x = delta.x * 15, y = delta.y * 15, relative = true }
  hl.bind(mainMod .. ' + CTRL + ' .. arrow, hl.dsp.focus { direction = direction }, o)
  hl.bind(mainMod .. ' + ALT + ' .. arrow, hl.dsp.window.resize(relative15DeltaOpts), o)
  hl.bind(mainMod .. ' + CTRL + ' .. vimlike, hl.dsp.window.move(relative15DeltaOpts), o)
end

---- Unicode Pickers
hl.bind(mainMod .. ' + PERIOD', hl.dsp.exec_cmd('vicinae deeplink vicinae://launch/core/search-emojis'))
hl.bind(mainMod .. ' + SHIFT + PERIOD', hl.dsp.exec_cmd('rofimoji --selector wofi --action print | wl-copy -n'))
hl.bind(mainMod .. ' + COMMA', hl.dsp.exec_cmd('.local/bin/shits/unipicker.sh | wl-copy'))

---- Screenshots
for modifiers, mkDsp in pairs({
  [''] = function(redir) return hl.dsp.exec_cmd('grim - ' .. redir) end,
  ['CTRL + '] = function(redir)
    return function()
      local window = hl.get_active_window()
      if window == nil then
        hl.dispatch(hl.dsp.exec_cmd('notify-send -u critical "Window Screenshot" "No window is focused"'))
        return
      end

      local geometry = window.at.x .. ',' .. window.at.y .. ' ' .. window.size.x .. 'x' .. window.size.y
      local command = 'grim -g "' .. geometry .. '" - '

      local noRounding = window.fullscreen or (settings.noGapsWhenOnly and window.workspace.windows == 1)
      local rounding = not noRounding or window.floating
      if rounding then
        -- rounding
        -- hl.dispatch(hl.dsp.exec_cmd('notify-send "Window Screenshot" "Rounding..."')) -- for debug purposes
        command = command .. '| shadower --padding-x 0 --padding-y 0 -r ' .. settings.winRadius .. ' '
      end

      hl.dispatch(hl.dsp.exec_cmd(command .. redir))
    end
  end,
  ['SHIFT + '] = function(redir) return hl.dsp.exec_cmd('slurp | grim -g - - ' .. redir) end,
}) do
  hl.bind(modifiers .. 'PRINT', mkDsp('| wl-copy'))
  hl.bind(modifiers .. 'ALT + PRINT', mkDsp('> "$(xdg-user-dir PICTURES)/Screenshots/$(date +%Y-%m-%d_%H:%M:%S).png"'))
end
