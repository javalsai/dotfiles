return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            -- "hrsh7th/cmp-vsnip",
            -- "hrsh7th/vim-vsnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "onsails/lspkind.nvim",
            {
                "L3MON4D3/LuaSnip",
                dependencies = {
                    "saadparwaiz1/cmp_luasnip",
                    {
                        "rafamadriz/friendly-snippets",
                        config = function()
                            require("luasnip.loaders.from_vscode").lazy_load()
                            -- require("luasnip.loaders.from_lua").lazy_load({ paths = "./lua/snippets" })
                        end,
                    },
                },
                config = function()
                    local ls = require 'luasnip'

                    ls.add_snippets("all", {
                        ls.snippet("lorem ipsum", {
                            ls.text_node(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                        }),

                        ls.snippet("lorem sed ut", {
                            ls.text_node(
                                "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?")
                        }),

                        ls.snippet("lorem at vero", {
                            ls.text_node(
                                "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.")
                        }),
                    })
                end,
            },
        },
        config = function()
            local lspkind = require('lspkind')
            local cmp = require('cmp')
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
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                view = {
                    entries = {
                        follow_cursor = true,
                    },
                },
                mapping = cmp.mapping.preset.insert {
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    -- ['<C-e>'] = cmp.mapping.abort(),
                    ['<Esc>'] = cmp.mapping.abort(),
                    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ['<Tab>'] = cmp.mapping.confirm { select = true },
                },
                sources = cmp.config.sources {
                    { name = 'nvim_lsp' },
                    { name = 'vsnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                    { name = 'crates' },
                    { name = 'luasnip' },
                }
            }
        end,
    },
}
