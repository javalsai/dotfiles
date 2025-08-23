local utils = require 'utils'

return {
  'nvim-telescope/telescope.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    require 'plugins.treesitter',
    require 'plugins.which-key',
  },
  keys = function()
    local wk = require 'which-key'
    local builtin = require 'telescope.builtin'

    return utils.lazy_wkeys(wk, {
      { '<leader>f',  group = 'Find / Telescope' },
      { '<leader>ff', builtin.find_files,        desc = 'Find Files' },
      { '<leader>fg', builtin.live_grep,         desc = 'Live Grep' },
      { '<leader>fb', builtin.buffers,           desc = 'Buffers' },
      { '<leader>fh', builtin.help_tags,         desc = 'Help Tags' },
    })
  end,

  config = true,
}
