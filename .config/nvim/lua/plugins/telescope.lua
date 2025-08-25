local utils = require 'utils'

return {
  'nvim-telescope/telescope.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    require 'plugins.treesitter',
    require 'plugins.which-key',
  },
  keys = function()
    local wk = require 'which-key'

    return utils.lazy_wkeys(wk, {
      { '<leader>f',  group = 'Find / Telescope' },
      { '<leader>ff', require 'telescope.builtin'.find_files, desc = 'Find Files' },
      { '<leader>fg', require 'telescope.builtin'.live_grep,  desc = 'Live Grep' },
      { '<leader>fb', require 'telescope.builtin'.buffers,    desc = 'Buffers' },
      { '<leader>fh', require 'telescope.builtin'.help_tags,  desc = 'Help Tags' },
    })
  end,

  config = true,
}
