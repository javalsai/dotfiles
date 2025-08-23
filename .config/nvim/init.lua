local globals = require 'globals'
local utils = require 'utils'
local cmds = require 'cmds'

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

-- Syntax
vim.o.syntax = 'on'
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

-- To use a interactive shell on commands (I can use aliases)
vim.o.shellcmdflag = '-ic'

vim.o.cmdheight = 0
vim.o.showcmdloc = 'statusline'

vim.env.EDITOR = 'nvr --remote-tab-wait-silent'

-- TODO: lazyfy or move to a better place
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

utils.keymaps_set {
  {
    '<C-ñ>',
    cmds.focus_term,
    { 'n', 'v', 'i', 'c', 't' },
    desc = 'Toggles term focus',
  },
  {
    '<C-ESC>',
    '<C-\\><C-n>',
    't',
    desc = 'Escape from terminal mode',
  },
  { '<C-BACKSPACE>', '<C-w>',                       'i' },
  { '<C-DEL>',       '<C-o>"_de',                   'i' },
  { '<Tab>',         '>gv',                         'v' },
  { '<S-Tab>',       '<gv',                         'v' },
  { '<S-Tab>',       cmds.cursor_follow_stab,       'i' },
  { '<leader>p',     cmds.paste_over_visual_nocopy, 'x' },
  -- vim.keymap.set({ 'i', 'v' }, 's', '"_s', kargs)
  -- vim.keymap.set({ 'i', 'v' }, 'c', '"_c', kargs)
}

-- lazy.nvim
local lazypath = globals.lazypath
if not (vim.uv or vim.loop)['fs_stat'](lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out,                            'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require('lazy').setup('plugins')
