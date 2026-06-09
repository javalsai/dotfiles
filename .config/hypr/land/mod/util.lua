local M = {}

--- @param str string
--- @param with string
function M.startsWith(str, with)
  return string.sub(str, 1, string.len(with)) == with
end

--- @param str string
--- @param pref string
--- @param with string
function M.subPrefix(str, pref, with)
  if M.startsWith(str, pref) then
    return with .. string.sub(str, string.len(pref) + 1)
  end

  return str
end

--- @param from number
--- @param to number
function M.mkrange(from, to)
  local t = {}
  for i = from, to do
    t[i] = i
  end

  return t
end

--- @param tables table[]
function M.spreadTables(tables)
  local spread = {}

  for _, t in ipairs(tables) do
    for k, v in pairs(t) do
      spread[k] = v
    end
  end

  return spread
end

--- @param s string
--- @param sepr? string
function M.split(s, sepr)
  if sepr == nil then sepr = ' ' end

  local list = {}
  for w in string.gmatch(s, '([^' .. sepr .. ']+)') do
    table.insert(list, w)
  end

  return list
end

--- @return HL.Window?
function M.getHovered()
  local pos = hl.get_cursor_pos()
  if pos == nil then error 'couldn\'t get mouse position' end
  local posX, posY = pos.x, pos.y

  local monitor = hl.get_monitor_at(pos)
  if monitor == nil then error 'couldn\'t get monitor at mouse' end

  local windows = hl.get_windows()

  --- @type HL.Window[]
  local hovered_windows = {}
  for _, window in ipairs(windows) do
    if window.monitor.id ~= monitor.id or not window.workspace.active then
      goto continue
    end

    local left, top = window.at.x, window.at.y
    local right, bottom = left + window.size.x, top + window.size.y

    if posX >= left and posX <= right and posY >= top and posY <= bottom then
      table.insert(hovered_windows, window)
    end

    ::continue::
  end

  if #hovered_windows == 0 then
    return nil
  end

  local minHistWindow = hovered_windows[1]
  for _, window in ipairs(hovered_windows) do
    if window.floating and window.focus_history_id < minHistWindow.focus_history_id then
      minHistWindow = window
    end
  end

  return minHistWindow
end

return M
