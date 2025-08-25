local terminal, last_non_term_win_id = nil, nil
local function focus_term()
  local Terminal = require 'toggleterm.terminal'.Terminal
  if terminal == nil then
    terminal = Terminal:new({ direction = 'horizontal', hidden = true })
  end
  local focused_win_id = vim.api.nvim_get_current_win()

  if terminal:is_focused() then
    if last_non_term_win_id then
      vim.api.nvim_set_current_win(last_non_term_win_id)
    end
  else
    last_non_term_win_id = focused_win_id
    if not terminal:is_open() then
      terminal:toggle()
    end
    terminal:focus()
  end
end

local all_mode = { 'n', 't', 'i', 'c', 'v' }
return {
  'akinsho/toggleterm.nvim',
  keys = {
    { '<C-ñ>',   focus_term,                            desc = 'Toggles term focus',   mode = all_mode },
    { '<C-S-ñ>', '<cmd>ToggleTerm direction=float<CR>', desc = 'Open floating window', mode = { 'n', 't' } },
  },
  opts = {
    autochdir = true,
    shade_terminals = false,
    highlights = {
      ['FloatBorder'] = { link = 'FloatBorder' },
    },
    float_opts = {
      border = 'curved',
    },
  },
}
