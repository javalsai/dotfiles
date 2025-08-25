local globals = require 'globals'

return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    require 'nvim-treesitter.configs'.setup {
      ensure_installed = globals.ts_langs,
      ignore_install = {},
      modules = {},
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
            ['aP'] = '@parameter.outer',
            ['iP'] = '@parameter.inner',
            ['ak'] = '@block.outer',
            ['ik'] = '@block.inner',
            ['al'] = '@loop.outer',
            ['il'] = '@loop.inner',
            ['acm'] = '@comment.outer',
            ['icm'] = '@comment.inner',
          },
        },
      },
    }
  end,
}
