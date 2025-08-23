return {
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  config = function()
    require('lsp_lines').setup {}
    vim.diagnostic.config({
      virtual_text = false,
      severity_sort = true,
      virtual_lines = {
        only_current_line = true,
      },
      float = {
        source = true,
      },
    })
  end,
}
