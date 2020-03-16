" ┏━┓┳━┓┏┓┓┳━┓┳━┓┳━┓┳
" ┃ ┳┣━ ┃┃┃┣━ ┃┳┛┃━┫┃
" ┇━┛┻━┛┇┗┛┻━┛┇┗┛┛ ┇┇━┛

" minimal number to keep above/below the cursor
set scrolloff=5

" enable auto indentation
set autoindent

" coffee pasta
set clipboard=unnamedplus

" use indents of 4 spaces
set shiftwidth=4
set shiftround

" tabs are tabs
set noexpandtab

" an indentation every four columns
set tabstop=4

" case insensitive search
set ignorecase
set smartcase
set infercase

" maintain undo history between sessions
set undofile
set nobackup
set noswapfile
set undodir=~/.config/nvim/undo
"set backupdir=~/.config/nvim/backups
"set directory=~/.config/nvim/swaps

" plebs mode
set mouse=a

set tabpagemax=15

" show tabline only when more than one tab is present
set showtabline=1

"  split
set splitright
set splitbelow

set updatetime=100

" fuzzy find
set path+=**
" lazy file name tab completion
set wildmode=longest,list,full
set wildmenu
set wildignorecase
" ignore files vim doesnt use
set wildignore+=.git,.hg,.svn
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
set wildignore+=*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
set wildignore+=*.mp3,*.oga,*.ogg,*.wav,*.flac
set wildignore+=*.eot,*.otf,*.ttf,*.woff
set wildignore+=*.doc,*.pdf,*.cbr,*.cbz
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
set wildignore+=*.swp,.lock,.DS_Store,._*

" leader key
let mapleader = ' '

" encoding
scriptencoding utf-8

" language-specific
augroup langindentation
	autocmd Filetype c setlocal tabstop=2 shiftwidth=2 softtabstop=2
	autocmd Filetype cpp setlocal tabstop=2 shiftwidth=2 softtabstop=2
	autocmd Filetype css setlocal tabstop=2 shiftwidth=2 softtabstop=2
	autocmd Filetype javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2
	autocmd Filetype html setlocal tabstop=2 shiftwidth=2 softtabstop=2
	autocmd Filetype json setlocal tabstop=2 shiftwidth=2 softtabstop=2
	autocmd Filetype scss setlocal tabstop=2 shiftwidth=2 softtabstop=2
	autocmd Filetype php setlocal tabstop=2 shiftwidth=2 softtabstop=2
	autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END
