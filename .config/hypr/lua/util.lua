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

return M
