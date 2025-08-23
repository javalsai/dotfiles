local globals = require 'globals'

local luasnip_spec = {
  'L3MON4D3/LuaSnip',
  dependencies = {
    'saadparwaiz1/cmp_luasnip',
    {
      'rafamadriz/friendly-snippets',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
      end,
    },
  },
  config = function()
    local ls = require 'luasnip'

    local snippets = {}
    for k, v in pairs(globals.text_snippets) do
      table.insert(snippets, ls.snippet(k, { ls.text_node(v) }))
    end

    ls.add_snippets('all', snippets)
  end,
}

return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'onsails/lspkind.nvim',
      luasnip_spec,
    },
    config = function()
      local lspkind = require 'lspkind'
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      cmp.setup {
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = {
              menu = 30,
            },
            ellipsis_char = '…',
          }),
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        view = {
          entries = {
            name = 'custom',
            follow_cursor = true,
          },
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<Esc>'] = cmp.mapping.abort(),
          ['<Tab>'] = cmp.mapping.confirm { select = true },
        },
        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'crates' },
          { name = 'lazydev' },
          { name = 'luasnip' },
        },
      }
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'path' },
          { name = 'cmdline' },
        },
      })
    end,
  },
}
