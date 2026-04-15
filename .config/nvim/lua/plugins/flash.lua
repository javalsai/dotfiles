local function f()
  return require 'flash'
end

return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  --- @type Flash.Config
  opts = {},
  keys = {
    { '<leader>j', mode = { 'n', 'x', 'o' }, function() f().jump() end,              desc = 'Flash'               },
    { '<leader>J', mode = { 'n', 'x', 'o' }, function() f().treesitter() end,        desc = 'Flash Treesitter'    },
    { 'r',         mode = 'o',               function() f().remote() end,            desc = 'Remote Flash'        },
    { 'R',         mode = { 'o', 'x' },      function() f().treesitter_search() end, desc = 'Treesitter Search'   },
    { '<c-s>',     mode = { 'c' },           function() f().toggle() end,            desc = 'Toggle Flash Search' },
  },
}
