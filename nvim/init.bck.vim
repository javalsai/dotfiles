set encoding=UTF-8
:set nocompatible            " disable compatibility to old-time vi
:set showmatch               " show matching 
":set ignorecase              " case insensitive 
:set mouse=v                 " middle-click paste with 
:set hlsearch                " highlight search 
:set incsearch               " incremental search
:set expandtab               " converts tabs to white space
:set wildmode=longest,list   " get bash-like tab completions
:set clipboard+=unnamedplus  " using system clipboard
:set ttyfast

syntax on                   " syntax highlighting
filetype plugin indent on   " allow auto-indenting depending on file type
filetype plugin on

:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a

lua require('plugins')
lua require('lsp')

lua require("toggleterm").setup()


:set runtimepath+=/home/javalsai/.local/share/nvim/plugged/awesome-vim-colorschemes/
:colo abstract

set autochdir
let NERDTreeChDirMode=2
nnoremap <leader>n :NERDTree .<CR>

nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>

nmap <F8> :TagbarToggle<CR>

:set completeopt-=preview " For No Previews

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
