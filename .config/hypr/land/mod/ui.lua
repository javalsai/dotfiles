local util = require 'land.mod.util'

local M = {}

--- @param stdin string
--- @param cb function
--- @param template string Must contain enough X's somewhere.
--- @return any
function M.mktempStdin(stdin, cb, template)
  local mktHandle = io.popen('mktemp -t "' .. template .. '"')
  if mktHandle == nil then error 'error popening' end
  local path = mktHandle:read '*a'
  mktHandle:close()

  local pathHandle = io.open(path, 'w')
  if pathHandle == nil then error 'error opening' end
  pathHandle:write(stdin)
  pathHandle:close()

  local ret = cb(path)

  os.remove(path)
  return ret
end

-- emulate the
--
-- $_window_fmt = \(.initialTitle) <b>[\(.workspace.name)]</b> <sup><i>\(.size[0])x\(.size[1])</i></sup>
-- $_window_addr_fmter = hyprctl clients -j | jq '.[] | "\(.address) $_window_fmt"'
-- $_window_chooser = $_window_addr_fmter | wofi -d -r 'echo %s | cut -d" " -f2- | tr -d "\n"' | jq -r | cut -d' ' -f1
--
-- $_window_chooser
--- @return string Window ID selected
function M.windowChooser()
  -- error 'Chooser not supported'

  local windows = hl.get_windows()

  local windowsStdin = ''
  for _, window in ipairs(windows) do
    local windowName = window.initial_title:gsub('\n', ' ')
    local windowWsName = '<b>[' .. window.workspace.name:gsub('\n', ' ') .. ']</b>'

    local windowLine = window.address .. ' ' .. windowName .. ' ' .. windowWsName

    if type(window.size) == 'table' and type(window.size[1]) == 'number' and type(window.size[2]) == 'number' then
      local windowResolution = '<sup><i>' .. window.size[1] .. 'x' .. window.size[2] .. '</i></sup>'
      windowLine = windowLine .. ' ' .. windowResolution
    end

    windowsStdin = windowsStdin .. windowLine .. '\n'
  end

  return M.mktempStdin(windowsStdin, function(path)
    -- TODO: maybe rm tr if no trailing \n
    local p = io.popen('wofi -d -r \'echo %s <"' .. path .. '" | cut -d" " -f2- | tr -d "\\n"\'', 'r')
    if p == nil then error 'error running wofi' end

    --- @type string
    local wofiResult = p:read('*a')
    p:close()

    local address = util.split(wofiResult)[0]
    return address
  end, 'wofi-hyprland-windows.XXXXXX.stdin')
end

return M
