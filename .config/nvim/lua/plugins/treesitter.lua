local globals = require 'globals'

return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = { 'nvim-treesitter/nvim-treesitter-context' },
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
    }
  end,
}
