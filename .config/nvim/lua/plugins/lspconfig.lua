-- local globals = require 'globals'
local utils = require 'utils'

local function default_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  return capabilities
end

local function rustacean_init()
  -- https://github.com/mrcjkb/rustaceanvim#zap-quick-setup
  -- https://github.com/mrcjkb/rustaceanvim#gear-advanced-configuration
  vim.g.rustaceanvim = {
    tools = {},
    server = {
      on_attach = function(_, bufnr)
        local wk = require 'which-key'
        local _, maps = utils.bufmap(wk, bufnr)

        local function action() vim.cmd.RustLsp('codeAction') end
        local function hover() vim.cmd.RustLsp({ 'hover', 'actions' }) end

        maps {
          { '<leader>a', action, desc = 'LSP action (rustacean)' },
          { '<leader>K', hover,  desc = 'LSP hover (rustacean)' },
        }
      end,
      default_settings = { ['rust-analyzer'] = {} },
    },
    dap = {},
  }
end

return {
  'neovim/nvim-lspconfig',
  lazy = false,
  dependencies = {
    {
      'mrcjkb/rustaceanvim',
      lazy = false,
      dependencies = { require 'plugins.which-key' },
      init = rustacean_init,
    },

    { 'saecki/crates.nvim', config = true },
    'b0o/schemastore.nvim',
    require 'plugins.which-key',
  },
  config = function()
    local lspconfig = require 'lspconfig'
    local lspconfig_util = require 'lspconfig.util'

    local crates = require 'crates'
    local schemastore = require 'schemastore'

    local capabilities = default_capabilities()

    -- ASM
    lspconfig.asm_lsp.setup { capabilities = capabilities }

    -- Bash
    lspconfig.bashls.setup { capabilities = capabilities }

    -- Zig
    lspconfig.zls.setup { capabilities = capabilities }

    -- TS
    lspconfig.ts_ls.setup { capabilities = capabilities }

    -- Lua
    lspconfig.lua_ls.setup {
      capabilities = capabilities,
      settings = {
        -- workspace = { library = { vim.env.VIMRUNTIME, globals.lazypath } },
        telemetry = { enable = false },
      },
    }

    -- C/CPP/...
    lspconfig.clangd.setup { capabilities = capabilities }

    -- Rustacean nvim is used anyways
    -- Rust
    -- lspconfig.rust_analyzer.setup {
    --   -- flags = flags,
    --   -- capabilities = capabilities,
    --   -- on_attach = on_attach,
    --   settings = {
    --     ["rust-analyzer"] = {
    --       -- cargo = {
    --       --   allFeatures = true,
    --       -- },
    --       -- checkOnSave = {
    --       --   allFeatures = true,
    --       -- extraArgs = { "--all-features" }
    --       -- },
    --       -- check = {
    --       --   allTargets = true,
    --       -- },
    --     },
    --   },
    -- }

    -- Rust Crates
    crates.setup {}

    -- Toml...
    lspconfig.taplo.setup { capabilities = capabilities }

    -- JSON
    lspconfig.jsonls.setup {
      commands = {
        Format = {
          function()
            vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line('$'), 0 })
          end,
        },
      },
      extraOptions = {
        allowTrailingCommas = true,
      },
      settings = {
        json = {
          schemas = schemastore.json.schemas(),
          validate = { enable = true },
        },
      },
      capabilities = capabilities,
    }

    -- Markdown
    -- FUCK markdown LSP clients, they all suck, embrace TreeSitter

    -- lspconfig.remark_ls.setup {
    --   settings = {
    --     remark = {
    --       requireConfig = false
    --     }
    --   }
    -- }
    -- lspconfig.marksman.setup {}

    -- XML
    lspconfig.lemminx.setup { capabilities = capabilities }

    -- HTML
    lspconfig.html.setup { capabilities = capabilities }

    -- CSS
    lspconfig.cssls.setup { capabilities = capabilities }

    -- Emmet
    lspconfig.emmet_ls.setup({
      capabilities = capabilities,
      filetypes = {
        'css',
        'eruby',
        'html',
        'javascript',
        'javascriptreact',
        'less',
        'sass',
        'scss',
        'svelte',
        'pug',
        'typescriptreact',
        'vue',
        'json',
      },
      init_options = {
        html = {
          options = {
            -- https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
            ['bem.enabled'] = true,
          },
        },
      },
    })

    --- OTHER
    -- Biome
    lspconfig.biome.setup {
      capabilities = capabilities,
      root_dir = lspconfig_util.root_pattern('biome.json', 'biome.jsonc'),
    }

    -- Prisma
    lspconfig.prismals.setup { capabilities = capabilities }

    -- Qml
    lspconfig.qmlls.setup({
      capabilities = capabilities,
      -- on_attach = on_attach,
      cmd = { '/usr/lib/qt6/bin/qmlls' },
      filetypes = { 'qml' },
      single_file_support = true,
      root_dir = function(fname)
        local git = vim.fs.find('.git', { path = fname, upward = true })
        return vim.fn.dirname(git and git[1] or fname)
      end,
    })

    -- Generic conf
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        local wk = require 'which-key'
        local _, maps = utils.bufmap(wk, ev.buf)

        -- TODO: remove non LSP groupped once I get used
        -- TODO: move onto some onattach
        maps {
          { '<leader>F',   vim.lsp.buf.format,        desc = 'LSP format' },
          { 'K',           vim.lsp.buf.hover,         desc = 'LSP hover' },
          { 'Z',           vim.diagnostic.open_float, desc = 'Open diagnostic' },
          { 'gd',          vim.lsp.buf.definition,    desc = 'Go to definition' },
          { '<leader>r',   vim.lsp.buf.rename,        desc = 'LSP rename' },
          { '<leader>l',   group = 'LSP / related' },
          { '<leader>lf',  vim.lsp.buf.format,        desc = 'LSP format' },
          { '<leader>lk',  vim.lsp.buf.hover,         desc = 'LSP hover' },
          { '<leader>lz',  vim.diagnostic.open_float, desc = 'Open diagnostic' },
          { '<leader>lr',  vim.lsp.buf.rename,        desc = 'LSP rename' },
          { '<leader>lgd', vim.lsp.buf.definition,    desc = 'Go to definition' },
        }
      end,
    })
  end,
}
