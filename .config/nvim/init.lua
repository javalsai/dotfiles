require 'utils'

-- Base
vim.o.encoding = "UTF-8"
vim.o.compatible = false

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
vim.o.listchars = "tab:> ,trail:·"
vim.api.nvim_set_hl(0, 'ExtraWhitespace', { ctermbg = 'red', bg = 'red' })
vim.api.nvim_set_hl(0, 'Tab', { ctermbg = 'gray', fg = 'gray' })
vim.fn.matchadd('ExtraWhitespace', '\\s\\+$')
vim.fn.matchadd('Tab', '\\t\\+')

-- Tabs / Indents
vim.o.autoindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.cmd.filetype 'plugin indent on'

-- Mouse
vim.o.mouse = "a"

-- Draws
vim.o.ttyfast = true
vim.o.lazyredraw = false

-- Persistent Undo
vim.o.undofile = true
-- vim.o.undodir = '.cache/nvim/undodir/'

-- Idk
vim.opt.wildmode:append { "longest", "list" }
vim.opt.clipboard:append { "unnamedplus" }

-- To use a interactive shell on commands (I can use aliases)
vim.o.shellcmdflag = "-ic"

vim.o.cmdheight = 0
vim.o.showcmdloc = 'statusline'

vim.env.EDITOR = "nvr --remote-tab-wait-silent"

-- vim cmd, not sure what this was for
-- set completeopt-=preview " For No Previews

-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- lazyfy these
local function is_term(win_id)
  -- could be used to check split info and pick better
  -- local split_info = vim.api.nvim_win_get_config(win_id)

  local buf = vim.api.nvim_win_get_buf(win_id)
  local bufname = vim.api.nvim_buf_get_name(buf)
  return bufname:startswith('term://')
end

Last_non_term_win_id = nil
function Focus_term()
  local focused_win_id = vim.api.nvim_get_current_win()

  if is_term(focused_win_id) then
    if Last_non_term_win_id then
      vim.api.nvim_set_current_win(Last_non_term_win_id)
    end
  else
    Last_non_term_win_id = focused_win_id

    for _, win_id in ipairs(vim.api.nvim_list_wins()) do
      if is_term(win_id) then
        vim.api.nvim_set_current_win(win_id)
        return
      end
    end

    vim.cmd('below split')
    vim.cmd('term')
  end
end

-- TODO: lazyfy or move to a better place
vim.g.mapleader = " "
vim.g.maplocalleader = "\\ "
vim.keymap.set({ 'n', 'v', 'i', 'c', 't' }, '<C-ñ>', '<cmd>lua Focus_term()<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-ESC>', '<C-\\><C-n>', { noremap = true, silent = true })
vim.keymap.set('n', 'F', '<cmd>lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'Z', '<Cmd>lua vim.diagnosis.open_float()<CR>', { noremap = true, silent = true })
vim.keymap.set(
  'n',
  '<leader>K',
  '<Cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>',
  { noremap = true, silent = true }
)
vim.keymap.set('n', '<ESC>', function()
  local notif = require 'notify'
  if notif.active() == 0 then
    vim.cmd('nohlsearch')
    return
  end
  require('notify').dismiss { pending = true, silent = true }
end, { noremap = true, silent = true })
vim.keymap.set('i', '<C-BACKSPACE>', '<C-o>lvb"_d', { noremap = true, silent = true })
vim.keymap.set('i', '<C-DEL>', '<C-o>vwh"_d', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-D>', '"_')
vim.keymap.set('v', '<Tab>', '>gv')
vim.keymap.set('v', '<S-Tab>', '<gv')
vim.keymap.set('i', '<S-Tab>', '<C-o><<')

-- Setup lazy.nvim
-- require("lazy").setup({
--   spec = {
--     -- import your plugins
--     { import = "plugins" },
--   },
--   -- Configure any other settings here. See the documentation for more details.
--   -- colorscheme that will be used when installing plugins.
--   install = { colorscheme = { "habamax" } },
--   -- automatically check for plugin updates
--   checker = { enabled = true },
-- })
require("lazy").setup("plugins")
