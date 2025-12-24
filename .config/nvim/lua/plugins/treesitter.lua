local globals = require 'globals'

local function makeTextObj(binding, obj)
  return {
    binding,
    function()
      require 'nvim-treesitter-textobjects.select'.select_textobject(obj, 'textobjects')
    end,
    mode = { 'x', 'o' },
    desc = 'Treesitter textobj',
  }
end

return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-context',
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      branch = 'main',
      lazy = false,
      config = {
        select = {
          lookahead = true,
          include_surroundings_whitespace = true,
        },
      },

      keys = {
        makeTextObj('af', '@function.outer'),
        makeTextObj('if', '@function.inner'),
        makeTextObj('ac', '@class.outer'),
        makeTextObj('ic', '@class.inner'),
        makeTextObj('aP', '@parameter.outer'),
        makeTextObj('iP', '@parameter.inner'),
        makeTextObj('ak', '@block.outer'),
        makeTextObj('ik', '@block.inner'),
        makeTextObj('al', '@loop.outer'),
        makeTextObj('il', '@loop.inner'),
        makeTextObj('acm', '@comment.outer'),
        makeTextObj('icm', '@comment.inner'),
      },
    },
  },
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require 'nvim-treesitter'.install(globals.ts_langs)
  end,
}
