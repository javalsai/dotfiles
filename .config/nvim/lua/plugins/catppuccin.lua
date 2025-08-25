return {
  'catppuccin/nvim',
  name = 'catppuccin',
  dependencies = {
    require 'plugins.notify',
    require 'plugins.gitsigns',
  },
  priority = 1000,
  opts = {
    float = { transparent = true, solid = false },
    flavour = 'macchiato',
    transparent_background = true,
    custom_highlights = function(colors)
      -- https://github.com/catppuccin/catppuccin/blob/main/docs/style-guide.md
      return {
        -- bg: Typography > Subtle
        DiffDelete = { fg = colors.overlay1 },
        -- bg: Code Editors > General > Information
        FoldMoreMsg = { fg = colors.teal },
        -- bg: General Usage > Secondary Panes
        Folded = { bg = colors.mantle },
      }
    end,
    integrations = {
      notify = true,
      gitsigns = true,
    },
  },
  config = function(spec)
    require('catppuccin').setup(spec.opts)
    vim.cmd.colorscheme 'catppuccin'
  end,
}
