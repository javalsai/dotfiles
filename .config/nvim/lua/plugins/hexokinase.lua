return {
  'rrethy/vim-hexokinase',
  build = 'make hexokinase',
  config = function()
    vim.g.Hexokinase_highlighters = { 'virtual' }
    vim.g.Hexokinase_optInPatterns =
    'full_hex,triple_hex,rgb,rgba,hsl,hsla,colour_names'
  end,
}
