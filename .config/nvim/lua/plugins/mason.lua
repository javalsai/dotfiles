return {
  'williamboman/mason-lspconfig.nvim',
  lazy = false,
  dependencies = {
    {
      'williamboman/mason.nvim',
      lazy = false,
      config = true,
    },
  },
  opts = {
    automatic_installation = true,
  },
}
