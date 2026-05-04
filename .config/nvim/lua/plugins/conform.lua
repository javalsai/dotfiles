return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      nix = { 'nixfmt' },
    },
  },
  keys = {
    { '<leader>FF', function() require 'conform'.format() end, desc = 'Run conform formatter' },
  },
}
