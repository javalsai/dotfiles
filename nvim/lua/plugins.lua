local vim = vim
local Plug = vim.fn['plug#']

--- PLUGINS ---

vim.call('plug#begin')

Plug('tpope/vim-surround')                        -- Surrounding ysw
Plug('preservim/nerdtree')                        -- NerdTree
Plug('tpope/vim-commentary')                      -- For Commenting gcc & gc
Plug('lifepillar/pgsql.vim')                      -- PSQL Pluging needs :SQLSetType pgsql.vim
Plug('preservim/tagbar')                          -- Tagbar for code navigation
Plug('terryma/vim-multiple-cursors')              -- CTRL + N for multiple cursors
-- Plug 'pechorin/any-jump.vim'
Plug('akinsho/toggleterm.nvim', { ['tag'] = '*'})
Plug('petertriho/nvim-scrollbar')

-- Theming
Plug('catppuccin/nvim', { [ 'as' ] = 'catppuccin' })

Plug('ryanoasis/vim-devicons')
Plug('vim-airline/vim-airline')

Plug('rrethy/vim-hexokinase', { [ 'do' ] = 'make hexokinase' })

-- LSP
Plug('neovim/nvim-lspconfig')

-- Completion
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')

-- Langs
Plug('leafgarland/typescript-vim')

-- Misc
Plug('ahmedkhalf/project.nvim')
Plug('vimsence/vimsence')
Plug('lambdalisue/suda.vim')

vim.call('plug#end')

--- CONFIG ---

-- vim.cmd([[
-- let &t_8f = "\[38;2;%lu;%lu;%lum"
-- let &t_8b = "\[48;2;%lu;%lu;%lum"
-- ]])

-- require("scrollbar").setup()

require('toggleterm').setup()

require("catppuccin").setup {
    flavour = "frappe",
    transparent_background = true,
}
vim.cmd.colorscheme "catppuccin"

require("project_nvim").setup {
    detetion_methods = { 'lsp', 'pattern' },
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", 'bun.lockb', 'init.lua' },
    silent_chdir = true,
}

local cmp = require('cmp')
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
    })
})
