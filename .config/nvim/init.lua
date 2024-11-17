-- Base
vim.o.encoding = "UTF-8"
vim.o.compatible = false

-- Search Matches
vim.o.hlsearch = true
vim.o.showmatch = true
vim.o.incsearch = true

-- Line Behaviour
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 3

-- Syntax
vim.o.syntax = 'on'
vim.cmd.filetype 'plugin on'

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

-- Idk
vim.opt.wildmode:append { "longest", "list" }
vim.opt.clipboard:append { "unnamedplus" }

vim.o.cmdheight = 0
vim.o.showcmdloc = 'statusline'

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.cmd([[
  highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$/

  highlight Tab ctermfg=gray guifg=gray
  match Tab /\t\+/

  set linebreak
  set list listchars=tab:>\ ,trail:·

  let NERDTreeChDirMode=2

  inoremap <S-Tab> <C-d>

  set completeopt-=preview " For No Previews
]])

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

vim.g.mapleader = " "
vim.g.maplocalleader = "\\ "
vim.api.nvim_set_keymap('n', 'F', '<cmd>lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'Z', '<Cmd>lua vim.diagnosis.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  'n',
  '<leader>K',
  '<Cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>',
  { noremap = true, silent = true }
)

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
