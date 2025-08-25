return {
  'williamboman/mason-lspconfig.nvim',
  event = 'VeryLazy',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    require 'plugins.lspconfig',
  },
  opts = {
    -- automatic_installation = true,
  },
}
