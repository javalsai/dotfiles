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
      local C = colors

      -- https://github.com/catppuccin/catppuccin/blob/main/docs/style-guide.md
      return {
        -- bg: Typography > Subtle
        DiffDelete = { fg = colors.overlay1 },
        -- bg: Code Editors > General > Information
        FoldMoreMsg = { fg = colors.teal },
        -- bg: General Usage > Secondary Panes
        Folded = { bg = colors.mantle },

        -- `cat lua/catppuccin/groups/integrations/neotree.lua | rg blue`
        -- I want red main color >:(

        NeoTreeDirectoryName = { fg = C.red },
        NeoTreeDirectoryIcon = { fg = C.red },
        NeoTreeRootName = { fg = C.red, style = { 'bold' } },
        NeoTreeTitleBar = { fg = C.mantle, bg = C.red },
      }
    end,
    integrations = {
      notify = true,
      gitsigns = true,

      lualine = {
        all = function(colors)
          --- @type CtpIntegrationLualineOverride
          return {
            normal = {
              a = { bg = colors.red },
              b = { fg = colors.red },
            },

            replace = {
              a = { bg = colors.blue },
              b = { fg = colors.blue },
            },

            inactive = {
              a = { fg = colors.red },
            }
          }
        end,
      },
    },
  },
  config = function(spec)
    require('catppuccin').setup(spec.opts)
    vim.cmd.colorscheme 'catppuccin'
  end,
}
