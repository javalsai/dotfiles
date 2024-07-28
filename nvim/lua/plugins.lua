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
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'

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

Plug('b0o/schemastore.nvim')

-- Langs
Plug('leafgarland/typescript-vim')
Plug('saecki/crates.nvim', { [ 'tag' ] = 'stable' })

-- Misc
Plug('ahmedkhalf/project.nvim')
-- Plug('vimsence/vimsence')
Plug('lambdalisue/suda.vim')
Plug('NMAC427/guess-indent.nvim')
Plug('akinsho/git-conflict.nvim')
Plug 'goolord/alpha-nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug('nvim-lua/plenary.nvim')

vim.call('plug#end')

--- CONFIG ---

-- vim.cmd([[
-- let &t_8f = "\[38;2;%lu;%lu;%lum"
-- let &t_8b = "\[48;2;%lu;%lu;%lum"
-- ]])

-- require("scrollbar").setup()

local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})

require('lualine').setup {}

local alpha = require('alpha')
if alpha then
    alpha.setup(require'alpha.themes.theta'.config)
end


require('git-conflict').setup {}

require('guess-indent').setup {}

require('toggleterm').setup {}

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
cmp.setup {
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
    mapping = cmp.mapping.preset.insert {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        -- ['<C-e>'] = cmp.mapping.abort(),
        ['<Esc>'] =cmp.mapping.abort(),
        -- ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<Tab>'] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'crates' },
    }
}
