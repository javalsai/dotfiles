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
  local ra_path = utils.exepath('rust-analyzer')
  vim.g.rustaceanvim = {
    tools = {
      code_actions = { ui_select_fallback = true },
    },
    server = {
      cmd = ra_path and { ra_path } or { 'rustup', 'run', 'nightly', 'rust-analyzer' },
      standalone = true,

      on_attach = function(_, bufnr)
        local wk = require 'which-key'
        local _, maps = utils.bufmap(wk, bufnr)

        local function action() vim.cmd.RustLsp('codeAction') end
        local function hover() vim.cmd.RustLsp({ 'hover', 'actions' }) end
        local function down() vim.cmd.RustLsp({ 'moveItem', 'down' }) end
        local function up() vim.cmd.RustLsp({ 'moveItem', 'up' }) end

        maps {
          { '<leader>a', action, desc = 'LSP action (rustacean)'         },
          { '<leader>K', hover,  desc = 'LSP hover (rustacean)'          },
          { '<M-j>',     down,   desc = 'LSP move item down (rustacean)' },
          { '<M-k>',     up,     desc = 'LSP move item up (rustacean)'   },
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
      init = rustacean_init,
    },

    { 'saecki/crates.nvim', config = true },
    'b0o/schemastore.nvim',
  },
  config = function()
    local lspconfig_util = require 'lspconfig.util'

    local crates = require 'crates'
    local schemastore = require 'schemastore'

    vim.lsp.config('*', {
      capabilities = default_capabilities(),
      -- root_markers = { '.git' },
    })

    -- ASM
    vim.lsp.enable('asm_lsp')

    -- Bash
    vim.lsp.enable('bashls')

    -- Zig
    vim.lsp.enable('zls')

    -- TS
    vim.lsp.enable('ts_ls')

    -- Lua
    vim.lsp.config('lua_ls', {
      settings = {
        -- https://github.com/folke/lazydev.nvim/issues/136#issuecomment-3796597122
        -- Lua = { workspace = { library = vim.api.nvim_get_runtime_file('', true), }, },
        telemetry = { enable = false },
      },
    })
    vim.lsp.enable('lua_ls')

    -- C/CPP/...
    vim.lsp.enable('clangd')

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
    vim.lsp.enable('taplo')

    -- Python
    vim.lsp.enable('pylsp')

    -- JSON
    vim.lsp.config('jsonls', {
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
    })
    vim.lsp.enable('jsonls')

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

    -- Typst
    -- TODO:
    -- - properly cfg main/imported stuff
    -- - add typstyle to mason somehow (i dont remember how i cfgd mason)
    -- - add the preview thingy, dont wanna manually zathura every time and typst watch
    -- - use my coolass proper keys thing
    vim.lsp.config('tinymist', {
      settings = {
        formatterMode = 'typstyle',
        exportPdf = 'onType',
        semanticTokens = 'disable',
      },
      -- https://myriad-dreamin.github.io/tinymist/frontend/neovim.html#label-Working%20with%20Multiple-Files%20Projects
      on_attach = function(client, bufnr)
        vim.keymap.set('n', '<leader>tp', function()
          client:exec_cmd({
            title = 'pin',
            command = 'tinymist.pinMain',
            arguments = { vim.api.nvim_buf_get_name(0) },
          }, { bufnr = bufnr })
        end, { desc = '[T]inymist [P]in', noremap = true })
        vim.keymap.set('n', '<leader>tu', function()
          client:exec_cmd({
            title = 'unpin',
            command = 'tinymist.pinMain',
            arguments = { vim.v.null },
          }, { bufnr = bufnr })
        end, { desc = '[T]inymist [U]npin', noremap = true })
      end,
    })
    vim.lsp.enable('tinymist')

    -- XML
    vim.lsp.enable('lemminx')

    -- HTML
    vim.lsp.enable('html')

    -- CSS
    vim.lsp.enable('cssls')

    -- Emmet
    vim.lsp.config('emmet_ls', {
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
    vim.lsp.enable('emmet_ls')

    --- OTHER
    -- Biome
    vim.lsp.config('biome', {
      root_dir = lspconfig_util.root_pattern('biome.json', 'biome.jsonc'),
    })
    vim.lsp.enable('biome')

    -- Prisma
    vim.lsp.enable('prismals')

    -- Kotlin
    vim.lsp.enable('kotlin_language_server')

    -- Qml
    local qmlls_path = utils.avail_exepath({ 'qmlls6', 'qmlls' })
    vim.lsp.config('qmlls', {
      cmd = { qmlls_path, '-E' },
      filetypes = { 'qml' },
      single_file_support = true,
      root_markers = { 'shell.qml' },

      -- that `on_dir` took some crying
      --
      -- root_dir = function(bufnr, on_dir)
      --   local fname = vim.api.nvim_buf_get_name(0)
      --   local upfname = vim.fs.find('shell.qml', { path = fname, upward = true })
      --   on_dir(vim.fs.dirname(upfname and upfname[1] or fname))
      -- end,
    })
    vim.lsp.enable('qmlls')

    -- WGSL
    vim.lsp.enable('wgsl_analyzer')

    -- Ctags
    -- vim.lsp.enable('ctags_lsp')

    -- Generic conf
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        local wk = require 'which-key'
        local tc = require 'telescope.builtin'
        local _, maps = utils.bufmap(wk, ev.buf)

        -- TODO: remove non LSP groupped once I get used
        -- TODO: move onto some onattach (or maybe not, i usually trigger without lsp even)
        maps {
          -- { '<leader>F',   vim.lsp.buf.format,        desc = 'LSP format'       },
          { 'K',           vim.lsp.buf.hover,         desc = 'LSP hover'        },
          { 'Z',           vim.diagnostic.open_float, desc = 'Open diagnostic'  },
          { 'gd',          tc.lsp_definitions,        desc = 'Go to definition' },
          { 'gt',          tc.lsp_type_definitions,   desc = 'Go to definition' },
          { '<leader>r',   vim.lsp.buf.rename,        desc = 'LSP rename'       },
          { '<leader>l',   group = 'LSP / related'                              },
          { '<leader>lf',  vim.lsp.buf.format,        desc = 'LSP format'       },
          { '<leader>lk',  vim.lsp.buf.hover,         desc = 'LSP hover'        },
          { '<leader>lz',  vim.diagnostic.open_float, desc = 'Open diagnostic'  },
          { '<leader>lr',  vim.lsp.buf.rename,        desc = 'LSP rename'       },
          { '<leader>lR',  tc.lsp_references,         desc = 'References'       },
          { '<leader>lgd', tc.lsp_definitions,        desc = 'Go to definition' },
          { '<leader>lgt', tc.lsp_type_definitions,   desc = 'Go to definition' },
        }
      end,
    })
  end,
}
