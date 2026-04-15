return {
  'folke/snacks.nvim',
  --- @type snacks.Config
  opts = {
    input = {
      win = {
        relative = 'cursor',
        row = -3,
        col = 0,
      },
    },
    scroll = {
      filter = function(buf)
        return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and vim.bo[buf].buftype ~= 'terminal'
      end,
    },
  },
}
