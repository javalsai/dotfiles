local utils = require 'utils'

return {
  'nvim-telescope/telescope.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-lua/plenary.nvim',
    require 'plugins.treesitter',
    require 'plugins.which-key',
  },
  keys = function()
    local wk = require 'which-key'

    -- Remember, <Tab> selects stuff, you can <M-q> to send to quickfix list (:copen, :cclose, :cn, :cp) or <C-q> to send all.
    return utils.lazy_wkeys(wk, {
      { '<leader>f',  group = 'Find / Telescope'                                  },
      { '<leader>ff', require 'telescope.builtin'.find_files, desc = 'Find Files' },
      { '<leader>fg', require 'telescope.builtin'.live_grep,  desc = 'Live Grep'  },
      { '<leader>fb', require 'telescope.builtin'.buffers,    desc = 'Buffers'    },
      { '<leader>fh', require 'telescope.builtin'.help_tags,  desc = 'Help Tags'  },
      { '<leader>fr', require 'telescope.builtin'.resume,     desc = 'Resume'     },
    })
  end,

  init = function(_)
    require 'telescope'.load_extension('ui-select')
  end,
  opts = {
    extensions = {
      ['ui-select'] = {
        require 'telescope.themes'.get_dropdown {},
      },
    },
  },
}
