return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
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
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
}
