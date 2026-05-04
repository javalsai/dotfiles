-- To disable formatter: `--- @diagnostic disable: codestyle-check`

local globals = require 'globals'
local utils = require 'utils'

-- Base
vim.o.encoding = 'UTF-8'
vim.o.compatible = false
vim.o.virtualedit = 'block'

-- Search Matches
vim.o.hlsearch = true
vim.o.showmatch = true
vim.o.incsearch = true

-- Line Behaviour
vim.o.linebreak = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 3
vim.o.showbreak = '↪ '

-- Syntax
vim.o.syntax = 'on'
vim.g.load_doxygen_syntax = 1
vim.cmd.filetype 'plugin on'
vim.o.list = true
vim.opt.listchars = { tab = '> ', trail = '·' }
vim.opt.fillchars = { diff = '╱' }
vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = 'red' })
vim.api.nvim_set_hl(0, 'TrailTab', { fg = 'gray', bg = 'red' })
vim.fn.matchadd('ExtraWhitespace', '\\s\\+$')
vim.fn.matchadd('TrailTab', '\\t\\+$')

-- Folds
vim.o.foldcolumn = '0'
vim.o.foldtext = ''
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = nil

-- Tabs / Indents
vim.o.autoindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true
vim.o.softtabstop = 2
vim.o.expandtab = true

-- Mouse
vim.o.mouse = 'a'

-- Draws
vim.o.ttyfast = true
vim.o.lazyredraw = false

-- Persistent Undo
vim.o.undofile = true
-- vim.o.undodir = '.cache/nvim/undodir/'

-- Idk
vim.opt.wildmode:append { 'longest', 'list' }
vim.opt.clipboard:append { 'unnamedplus' }
if vim.env.SSH_TTY ~= nil then
  vim.g.clipboard = 'osc52'
end

-- To use a interactive shell on commands (I can use aliases)
vim.o.shellcmdflag = '-ic'

vim.o.cmdheight = 0
vim.o.showcmdloc = 'statusline'

vim.env.FAST_SHELL = true
vim.env.EDITOR = 'nvr --remote-tab-wait-silent'

-- TODO: lazyfy or move to a better place
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- https://github.com/CppCXY/EmmyLuaCodeStyle/issues/223
local escape_insert_seq = 'ḉ' -- pretty neat in latin keybd
utils.keymaps_set {
  { '<C-ESC>',         '<C-\\><C-n>',        't',         desc = 'Escape from terminal mode' },
  { '<C-BACKSPACE>',   '<C-w>',              'i'                                             },
  { '<C-DEL>',         '<C-o>"_de',          'i'                                             },
  { '<Tab>',           '>gv',                'x'                                             },
  { '<S-Tab>',         '<gv',                'x'                                             },
  { escape_insert_seq, '<ESC>',              'i'                                             },

  -- { '<leader>p',     cmds.paste_over_visual_nocopy, 'x' },
  { '<leader>p',       '"_c<C-r>+<ESC>',     'x'                                             },
  { '<leader>P',       '"_c<C-r>+<ESC>',     'x'                                             },
  { '<leader>c',       '"_c',                'x'                                             },
  { '<leader>C',       '"_C',                'x'                                             },
  { '<leader>C',       '"_C',                'n'                                             },
  { '<leader>s',       '"_s',                'x'                                             },
  { '<leader>s',       '"_s',                'n'                                             },

  { '<leader>Ff',      '<cmd>tab split<CR>', 'n'                                             },

  -- bcs ` in latin layout needs to be pressed for a sole one
  { 'ñ',               '`',                  'n'                                             },
  { 'ññ',              '``',                 'n'                                             },
  { 'mñ',              'm`',                 'n'                                             },

  -- would be cool to make these work in insert mode and stay in their position
  { '<C-CR>',          'm`o<ESC>``',         'n'                                             },
  { '<C-CR>',          'm`o<ESC>``',         'i'                                             },
  { '<C-S-CR>',        'm`O<ESC>``',         'n'                                             },

  -- text objs
  -- { 'i-',              [[\w\+\ze_]],        { 'x', 'o' }                                    },
}

-- so like, when typing in insert mode, these common punctuation marks also insert pseudo undo marks, that way undo doens't wipe out all the inserted text
local undo_marks = ',.;!? )]}_-\'\"'
for i = 1, #undo_marks do
  local c = undo_marks:sub(i, i)
  vim.keymap.set('i', c, c .. '<C-g>u')
end

-- allows me to `:q` on tabs opened by nvr instead of having to remember `:bd` or go through all the files in `:ls` and
-- `:bd`'ing the ONE. If the file was open by nvr and is leaving the window, close the buffer.
vim.api.nvim_create_autocmd('WinClosed', {
  callback = function(args)
    if vim.b[args.buf].nvr then
      vim.schedule(function()
        vim.bo[args.buf].buflisted = false
        vim.api.nvim_buf_delete(args.buf, { unload = true })
      end)
    end
  end,
})

-- lazy.nvim
local lazypath = globals.lazypath
if not (vim.uv or vim.loop)['fs_stat'](lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazyrepo,
    lazypath,
  }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg'   },
      { out,                            'WarningMsg' },
      { '\nPress any key to exit...'                 },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require 'lazy'.setup {
  spec = { import = 'plugins' },
  performance = { reset_packpath = false },
  change_detection = { enabled = false },
}
