local browser = os.getenv 'BROWSER' or 'firefox'

local handle = io.popen('hostname')
if handle == nil then
  error 'handle should not be nil'
end
local hostname = handle:read('*a'):gsub('\n', '') -- trim trailing newline
handle:close()

return {
  mainMod = 'SUPER',

  settings = {
    winRadius = 8,
    cursorSize = 22,

    noGapsWhenOnly = true,

    float = {
      center = true,
      width = 960,
      height = 540,

      asExec = function(self)
        local s = '[float;'

        if self.center then
          s = s .. ' center;'
        end

        s = s .. ' size ' .. self.width .. ' ' .. self.height

        return s .. ']'
      end,

      --- @param otherProps table|HL.WindowRuleSpec
      asWindowRule = function(self, otherProps)
        local o = {}
        for k, v in pairs(otherProps) do
          o[k] = v
        end

        o.float, o.center, o.size = true, self.center, { self.width, self.height }

        return o
      end,
    },
  },

  programs = {
    terminal = 'kitty -1',
    terminalFloat = 'kitty -1 --class kitty-float',
    browser = browser,
    privateBrowser = browser .. ' --private-window',
    fileManager = 'dolphin',
  },

  hostname = hostname,
}
