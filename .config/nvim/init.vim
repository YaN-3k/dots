"--------
" Neovim
"--------
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smartindent

set hlsearch
set ignorecase
set smartcase
set incsearch
set inccommand=nosplit

set clipboard=unnamedplus
set undofile
let g:netrw_banner = 0
set cursorline
set noshowmode
set noshowcmd
set shortmess+=icw
set laststatus=2
source ~/.config/nvim/status/status.vim
colorscheme iceberg

let mapleader = ' '
nnoremap <silent><leader>w :%s/\s\+$//e<cr>
nnoremap <silent><leader>n :noh<cr>
nnoremap <silent><leader>s :setlocal spell! spelllang=en<CR>
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
nnoremap k gk
nnoremap j gj
vnoremap j gj
