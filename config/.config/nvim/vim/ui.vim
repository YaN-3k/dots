" show matching brackets/parenthesis
set showmatch

" disable startup message
set shortmess+=I

" colorscheme
color term

" syntax highlighting
syntax on
set synmaxcol=512
filetype plugin indent on

" autocompletion menu
set pumheight=10

" Statusline
source $HOME/.config/nvim/colors/statusline.vim

set laststatus=2
set noruler
set showcmd
set noshowmode

" no folding
"set nofoldenable
"set foldlevel=99
"set foldminlines=99
"set foldlevelstart=99

" no line wrapping
"set nowrap

" show line numbers
set number relativenumber

" show invisibles
set list
set listchars=
set listchars+=tab:·\ 
set listchars+=trail:·
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=nbsp:░

" highlight current line
hi CursorLine             ctermbg=0  ctermfg=NONE  cterm=NONE
hi CursorColumn           ctermbg=0  ctermfg=NONE  cterm=NONE
augroup CursorLine
	au!
	"au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
	au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
	au WinLeave * setlocal nocursorline
augroup END

" split style
set fillchars=vert:▒

" tree style file explorer
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_winsize=25
