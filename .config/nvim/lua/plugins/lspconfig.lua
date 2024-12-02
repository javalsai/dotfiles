return {
  "neovim/nvim-lspconfig",
  dependencies = {
    'b0o/schemastore.nvim',
    { 'saecki/crates.nvim', config = true }
  },
  config = function()
    local lspconfig = require('lspconfig')

    -- ASM
    local asm_capabilities = vim.lsp.protocol.make_client_capabilities()
    asm_capabilities.textDocument.completion.completionItem.snippetSupport = true
    lspconfig.asm_lsp.setup {
      capabilities = asm_capabilities,
    }

    -- Bash
    lspconfig.bashls.setup {}

    -- Zig
    lspconfig.zls.setup {}


    -- TS
    lspconfig.ts_ls.setup {}

    -- Lua
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          }
        }
      }
    }

    -- C/CPP/...
    lspconfig.clangd.setup {}

    -- Rust
    lspconfig.rust_analyzer.setup {
      -- flags = flags,
      -- capabilities = capabilities,
      -- on_attach = on_attach,
      settings = {
        ["rust-analyzer"] = {
          -- cargo = {
          --   allFeatures = true,
          -- },
          -- checkOnSave = {
          --   allFeatures = true,
          -- extraArgs = { "--all-features" }
          -- },
          -- check = {
          --   allTargets = true,
          -- },
        },
      },
    }

    -- Crates
    require("crates").setup()

    -- JSON
    local jsonls_capabilities = vim.lsp.protocol.make_client_capabilities()
    jsonls_capabilities.textDocument.completion.completionItem.snippetSupport = true
    lspconfig.jsonls.setup {
      commands = {
        Format = {
          function()
            vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
          end
        },
      },
      extraOptions = {
        allowTrailingCommas = true,
      },
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
      capabilities = jsonls_capabilities,
    }

    -- Markdown
    lspconfig.remark_ls.setup {
      settings = {
        requireConfig = true
      }
    }

    -- XML
    lspconfig.lemminx.setup {}

    -- HTML
    local html_capabilities = vim.lsp.protocol.make_client_capabilities()
    html_capabilities.textDocument.completion.completionItem.snippetSupport = true

    lspconfig.html.setup {
      capabilities = html_capabilities,
    }

    -- CSS
    local css_capabilities = vim.lsp.protocol.make_client_capabilities()
    css_capabilities.textDocument.completion.completionItem.snippetSupport = true
    lspconfig.cssls.setup {
      capabilities = css_capabilities,
    }

    --- OTHER
    -- Biome
    lspconfig.biome.setup {
      root_dir = require 'lspconfig.util'.root_pattern('biome.json', 'biome.jsonc')
    }

    -- Prisma
    lspconfig.prismals.setup {}

    -- Generic conf
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf })
      end,
    })
  end,
}
