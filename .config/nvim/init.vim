" ___    ______
" __ |  / /__(_)______ ___
" __ | / /__  /__  __ `__ \
" __ |/ / _  / _  / / / / /
" _____/  /_/  /_/ /_/ /_/

" general
set nocompatible
set autoread
set belloff=all
set completeopt+=longest
set hidden
set lazyredraw
set listchars=tab:>\ ,trail:-,nbsp:+,eol:$
set scrolloff=5
set ttimeout
set ttimeoutlen=50
set undofile
set wildmenu
set wildmode=longest:full,full

" formating
filetype plugin indent on
set autoindent
set smartindent
set backspace=indent,eol,start
set formatoptions+=jl
set noexpandtab
set shiftround
set shiftwidth=8
set smarttab
set softtabstop=8
set tabstop=8
set textwidth=79
au! Filetype gitcommit,markdown setl spell!

" searching
set path+=**
set hlsearch
set ignorecase
set smartcase
set incsearch
if has('nvim') | set inccommand=nosplit | endif

" theme
syntax on
colors iceberg
set number
set relativenumber
set ruler
set showcmd
set noshowmode
set cursorline
set shortmess+=cs

" cursor
let &t_EI = "\e[2 q"
let &t_SI = "\e[6 q"
let &t_SR = "\e[4 q"
au! VimEnter * silent exec '!printf "' &t_EI '"'

" statusline
set laststatus=2
let StatusModes = {
	\ 'n': 'nor',
	\ 'i': 'ins',
	\ 'R': 'rep',
	\ 'c': 'cmd',
	\ 't': 'trm',
	\ 'v': 'sel',
	\ 'V': 'sel',
	\ '': 'sel'
	\ }
set stl=%#Dark#\ %{get(StatusModes,mode(),'-')}\ \|
set stl+=%#Normal#\ %t\ 
set stl+=%#Dark#%{&paste?'[PASTE]':''}%r%m
set stl+=%=
set stl+=\%#Accent#\ %l.%v\ %#Dark#\|\ 
set stl+=%{empty(&filetype)?'txt':&filetype}\ 

" plugins configs
let g:netrw_list_hide = '^\.\.\=/\=$'
let g:netrw_winsize = 25
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_preview = 1

set rtp+=~/.config/fzf
let $FZF_DEFAULT_OPTS .= '--layout=default'
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = {'down': '33%'}
let g:fzf_preview_window = 'right:50%'
au! FileType fzf set ls=0 nonu nornu | au BufLeave <buffer> set ls=2

" mapping
let mapleader = ' '
let maplocalleader = ','
set pastetoggle=<C-k>
nno <Leader>c :cd %:p:h<CR>
nno <silent><Esc> :noh<CR>
nno <silent><leader>q :cw<CR>
nno <silent><leader>i :set list! cuc! \| let &cc = &cc ? 0 : &tw<CR>
nno <silent><Leader>e :Lex<CR>
nno <silent><Leader>w :%s/\s\+$//e<CR>
nno <silent><Leader>s :setl spell!<CR>
nno <silent><Leader>n :let [&nu, &rnu] = [!&rnu, &nu + &rnu == 1]<CR>

" fzf
nno <silent><Leader>f :Files<CR>
nno <silent><Leader>b :Buffers<CR>
nno <silent><Leader>l :BLines<CR>
nno <silent><Leader>L :Lines<CR>
nno <silent><Leader>t :Tags<CR>
nno <silent><Leader>m :Marks<CR>
nno <silent><Leader>h :History<CR>
nno <silent><Leader>H :Helptags<CR>
