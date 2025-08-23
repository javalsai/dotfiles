return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require('null-ls')

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.black,
        -- add more formatters here
      },
    })

    -- optional: format on save
    -- vim.api.nvim_create_autocmd('BufWritePre', {
    --   callback = function()
    --     vim.lsp.buf.format({ async = false })
    --   end,
    -- })
  end,
}
