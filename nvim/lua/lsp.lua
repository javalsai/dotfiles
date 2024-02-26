local lspconfig = require('lspconfig')

-- Bash
lspconfig.bashls.setup{}

-- TS
lspconfig.tsserver.setup{}

-- Lua
lspconfig.lua_ls.setup{
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim'}
      }
    }
  }
}

-- C/CPP/...
lspconfig.clangd.setup{}

-- Rust
lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}

-- HTML
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
  capabilities = capabilities,
}
