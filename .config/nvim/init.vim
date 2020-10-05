"--------
" Neovim
"--------
set noexpandtab
set tabstop=8
set softtabstop=8
set shiftwidth=8
set smartindent

set hlsearch
set ignorecase
set smartcase
set incsearch
set inccommand=nosplit

set undofile
set cursorline
set noshowmode
set noshowcmd
set shortmess+=icw
set laststatus=2
source ~/.config/nvim/status/status.vim
colorscheme iceberg
let g:netrw_banner = 0

let mapleader = ' '
nnoremap <silent><leader>w :%s/\s\+$//e<cr>
nnoremap <silent><Esc> :noh<cr>
nnoremap <silent><leader>s :setlocal spell! spelllang=en<CR>
nnoremap <silent><leader>p :setlocal spell! spelllang=pl<CR>
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
