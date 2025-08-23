local utils = require 'utils'

local M = {}

-- just for a f*ing cursor-follow-'<<'
function M.cursor_follow_stab()
  local col = vim.fn.col('.')
  local row = vim.fn.line('.')
  local line_len = #vim.fn.getline(row)
  vim.cmd('normal! <<')
  vim.schedule(function()
    local d_line_len = line_len - #vim.fn.getline(row)
    vim.fn.cursor(row, col - d_line_len)
  end)
end

function M.paste_over_visual_nocopy()
  local start_pos, end_pos = utils.sort_pos(
    vim.fn.getpos('v'), vim.fn.getpos('.')
  )

  local srow, scol         = start_pos[2] - 1, start_pos[3] - 1
  local erow, ecol         = end_pos[2] - 1, end_pos[3]

  local regname            = vim.v.register
  local reg                = vim.fn.getreg(regname)
  local regtype            = vim.fn.getregtype(regname)
  local contents           = vim.split(reg, '\n', { plain = true })

  vim.api.nvim_buf_set_text(0, srow, scol, erow, ecol, contents)
  vim.fn.setreg(regname, reg, regtype)

  -- exit visual mode
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes('<Esc>', true, false, true),
    'n', true
  )
  -- update the '> mark to the end of pasted text
  local nlines = #contents
  local lastline_len = #contents[#contents]
  local new_end = {
    0,
    srow + nlines,
    (nlines == 1 and scol + lastline_len or lastline_len),
    0,
  }
  vim.notify(vim.inspect(new_end))
  vim.fn.setpos('.', new_end)
  vim.fn.setpos("'<", start_pos)
  vim.fn.setpos("'>", new_end)
end

local last_non_term_win_id = nil
function M.focus_term()
  local focused_win_id = vim.api.nvim_get_current_win()

  if utils.is_term(focused_win_id) then
    if last_non_term_win_id then
      vim.api.nvim_set_current_win(last_non_term_win_id)
    end
  else
    last_non_term_win_id = focused_win_id

    for _, win_id in ipairs(vim.api.nvim_list_wins()) do
      if utils.is_term(win_id) then
        vim.api.nvim_set_current_win(win_id)
        return
      end
    end

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_open_win(buf, true, {
      split = 'below',
      win = 0,
    })
    vim.cmd.term()
  end
end

return M
