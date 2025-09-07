local globals = require 'globals'

local luasnip_spec = {
  'L3MON4D3/LuaSnip',
  dependencies = {
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',

  },
  keys = function()
    local function luasnip_next() require 'luasnip'.jump(1) end
    local function luasnip_prev() require 'luasnip'.jump(-1) end
    local function luasnip_expand() require 'luasnip'.expand() end

    return {
      { '<C-S-Right>', luasnip_next,   desc = 'Luasnip next jump',     mode = { 'i', 's' } },
      { '<C-S-Left>',  luasnip_prev,   desc = 'Luasnip previous jump', mode = { 'i', 's' } },
      { '<C-q>',       luasnip_expand, desc = 'Luasnip expand',        mode = { 'i', 's' } },
    }
  end,
  config = function()
    local ls = require 'luasnip'
    require 'luasnip.loaders.from_vscode'.lazy_load()
    require 'luasnip.loaders.from_lua'.load { paths = vim.fn.stdpath('config') .. '/snippets' }

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
    event = 'VeryLazy',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'onsails/lspkind.nvim',
      luasnip_spec,
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local lspkind = require 'lspkind'

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
        mapping = {
          ['<Up>'] = cmp.mapping.select_prev_item(),
          ['<Down>'] = cmp.mapping.select_next_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<Esc>'] = cmp.mapping.abort(),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm { select = true }
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.complete_common_string()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
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
