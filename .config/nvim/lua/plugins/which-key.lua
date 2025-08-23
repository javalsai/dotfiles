return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    delay = 700,
    sort = { 'local', 'alphanum', 'order', 'group', 'mod' },
    icons = {
      separator = '|',
    },
    spec = {
      -- {
      --     "<leader>h",
      --     group = "Git Hunks",
      -- },
    },
  },
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
}
