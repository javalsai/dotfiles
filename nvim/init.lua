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

vim.opt.wildmode:append { "longest", "list" }
vim.opt.clipboard:append { "unnamedplus" }

-- Modules
require('plugins')
require('lsp')

vim.cmd([[
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

highlight Tab ctermfg=gray guifg=gray
match Tab /\t\+/

set linebreak
set list listchars=tab:>\ ,trail:·


let NERDTreeChDirMode=2
nnoremap <leader>n :NERDTree .<CR>


let g:Hexokinase_highlighters = [ 'virtual' ]
let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla,colour_names'

inoremap <S-Tab> <C-d>

nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>

nmap <F8> :TagbarToggle<CR>

set completeopt-=preview " For No Previews

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" General Mappings
inoremap <C-BS> <C-w>

" Coc config
inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
inoremap <expr> <Esc> pumvisible() ? " <BS>" : "<Esc>"

" require("scrollbar.handlers").setup()

nnoremap <silent> <leader>f <cmd>lua vim.lsp.buf.format()<CR>
]])

vim.api.nvim_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
