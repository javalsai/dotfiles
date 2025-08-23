local utils = require 'utils'

return {
  'lewis6991/gitsigns.nvim',
  dependencies = {
    require 'plugins.which-key'
  },
  opts = {
    current_line_blame = true,
    numhl = true,
    current_line_blame_formatter =
    '<author>, <author_time:%R> - [<abbrev_sha>] <summary>',
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'
      local wk = require 'which-key'

      local _, maps = utils.bufmap(wk, bufnr)

      maps {
        { '<leader>G',   group = 'Git' },
        { '<leader>Gd',  gitsigns.diffthis,            desc = 'Show This Diff' },

        { '<leader>Gh',  group = 'Git Hunks' },
        { '<leader>Ghs', gitsigns.stage_hunk,          desc = 'Stage Hunk' },
        { '<leader>Ghr', gitsigns.reset_hunk,          desc = 'Reset hunk' },
        { '<leader>Ghp', gitsigns.preview_hunk_inline, desc = 'Preview Hunk' },

        { '<leader>Gb',  group = 'Git Buffers' },
        { '<leader>Gbs', gitsigns.stage_buffer,        desc = 'Stage Buffer' },
        { '<leader>Gbr', gitsigns.reset_buffer,        desc = 'Reset Buffer' },
      }
    end,
  },
}
