local function esc(notif)
  if notif.active() == 0 then
    vim.cmd('nohlsearch')
  else
    notif.dismiss { pending = true, silent = true }
  end
end

return {
  'javalsai/nvim-notify-patch',
  lazy = false,
  keys = function()
    return {
      { '<ESC>', function() esc(require 'notify') end },
    }
  end,
  config = function()
    require('notify').setup({
      merge_duplicates = true,
      background_colour = '#000000',
      timeout = 1500,
      fps = 32,
      render = 'compact', -- compact",
      time_formats = {
        notification = '%T',
      },
      max_width = 70,
      stages = 'slide',
    })
    vim.notify = require('notify')
  end,
}
