"                         _
"   _ __   ___  _____   _(_)_ __ ___
"  | '_ \ / _ \/ _ \ \ / / | '_ ` _ \
"  | | | |  __/ (_) \ V /| | | | | | |
"  |_| |_|\___|\___/ \_/ |_|_| |_| |_|
"

"===========================
" Load vim-plug for plugins
"===========================
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !pip3 install --user pynvim
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/bundle')

	" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug '~/.fzf'
	Plug 'junegunn/fzf.vim'
	Plug 'scrooloose/nerdtree'

	Plug 'dense-analysis/ale'

	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
	Plug 'Shougo/deoplete-clangx'
	" Plug 'https://github.com/Shougo/neco-vim'
	" Plug 'https://github.com/Shougo/neoinclude.vim'
	Plug 'deoplete-plugins/deoplete-jedi'
	Plug 'deoplete-plugins/deoplete-zsh'
	Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
	Plug 'ervandew/supertab'

	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'

	Plug 'mattn/emmet-vim'

	Plug 'airblade/vim-gitgutter'
	Plug 'tpope/vim-fugitive'

	Plug '~/.config/nvim/bundle/vim-trailing-whitespace'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-commentary'
	Plug 'jiangmiao/auto-pairs'

	Plug 'itchyny/lightline.vim'
	Plug '~/.config/nvim/bundle/lightline-simple/'

	Plug 'sheerun/vim-polyglot'
	" Plug 'luochen1990/rainbow'

	Plug 'christoomey/vim-tmux-navigator'
	Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

call plug#end()

"=============
" Basic stuff
"=============
syntax on
filetype plugin indent on
set scrolloff=5
set pumheight=10
set autoindent
set smarttab
" set number relativenumber
set clipboard=unnamedplus
set inccommand=nosplit
set tabstop=4
set shiftwidth=4
set ignorecase
set smartcase
set undofile
set background=light
set mouse=a
set splitright
set splitbelow

" Restore cursor position
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

"=============
" Colorscheme
"=============
hi LineNr                       ctermfg=11  cterm=italic
hi CursorLineNr                 ctermfg=3   cterm=bold
hi ColorColumn                  ctermfg=1   cterm=undercurl
hi SignColumn                   ctermfg=7
hi VertSplit        ctermbg=8   ctermfg=0

hi Visual           ctermbg=8
hi Search           ctermbg=8               cterm=bold,reverse
hi MatchParen       ctermbg=0   ctermfg=4   cterm=reverse

hi Comment                      ctermfg=245
" hi String                       ctermfg=6
hi String                       ctermfg=1
hi Type                         ctermfg=4
hi Statement                    ctermfg=4
hi Constant                     ctermfg=5
" hi PreProc                      ctermfg=2
hi PreProc                      ctermfg=5
hi Special                      ctermfg=5

hi shFunction                   ctermfg=7
hi shOperator                   ctermfg=7
hi shQuote                      ctermfg=1
hi shFunctionKey                ctermfg=3

hi! link            shTestOpr    shOperator
hi! link            Delimiter    shOperator
hi! link            shRange      shOperator

hi vimHiGroup                   ctermfg=6
hi!                 link vimGroup  vimHiGroup

hi ErrorMsg         ctermbg=0   ctermfg=1
hi Error            ctermbg=1   ctermfg=0   cterm=undercurl

hi SpellBad         ctermbg=1   ctermfg=0   cterm=undercurl
hi SpellCap         ctermbg=2   ctermfg=0   cterm=undercurl
hi SpellRare        ctermbg=3   ctermfg=0   cterm=undercurl
hi SpellLocal       ctermbg=5   ctermfg=0   cterm=undercurl

hi DiffAdd          ctermbg=2   ctermfg=0
hi DiffChange       ctermbg=4   ctermfg=0
hi DiffDelete       ctermbg=1   ctermfg=0
hi DiffText         ctermbg=4   ctermfg=0

hi Folded           ctermbg=8
hi FoldColumn       ctermbg=8

hi Pmenu            ctermbg=0   ctermfg=4
hi PmenuSel         ctermbg=8   ctermfg=4
hi PmenuThumb       ctermbg=8   ctermfg=8
hi PmenuSbar        ctermbg=0   ctermfg=0

" Highlight current line
hi CursorLine       ctermbg=8               cterm=NONE
hi CursorColumn     ctermbg=8               cterm=NONE
augroup CursorLine
	au!
	"au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
	au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
	au WinLeave * setlocal nocursorline
augroup END

" Statusline
set laststatus=2
hi StatusLine   ctermbg=8 ctermfg=blue cterm=NONE
hi StatusLineNC ctermbg=8 ctermfg=blue cterm=NONE
hi User1        ctermbg=NONE ctermfg=blue
hi User2        ctermbg=NONE ctermfg=blue
hi User3        ctermbg=NONE ctermfg=blue
hi User4        ctermbg=8    ctermfg=blue

set statusline+=\ %t                " File type
set statusline+=\ %1*\              " Padding & switch colour
set statusline+=%r\                 " File name
set statusline+=%M                  " Modified flag
set statusline+=\ %2*\              " Padding & switch colour
set statusline+=%=                  " Switch to right-side
set statusline+=\ %3*\              " Padding & switch colour
set statusline+=%p%%                " Current line
set statusline+=\ %4*\              " Padding & switch colour
set statusline+=%y	                " File type
set statusline+=\ \|                " File type
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}\   " File coding

" Lightline - statusline
hi StatusLine       ctermbg=8   ctermfg=4    cterm=NONE
hi StatusLineNC     ctermbg=8   ctermfg=4    cterm=NONE
set noshowmode

let g:lightline = {
	\ 'colorscheme': 'simple',
	\ 'active': {
	\ 'left': [  [ 'mode' ],
	\            [ 'readonly', 'filename', 'gitbranch' ],
	\            [ 'modified' ] ],
    \ 'right': [ [ 'filetype', 'fileencoding' ],
	\            [ 'percent' ] ]
	\ },
	\ 'component_function': {
	\   'gitbranch': 'fugitive#head'
	\ },
	\ }

"================
" Plugin configs
"================
" ALE - Asynchronous Lint Engine
hi ALEWarning       ctermbg=3   ctermfg=0   cterm=undercurl
hi ALEError         ctermbg=1   ctermfg=0   cterm=undercurl
hi ALEWarningSign    		    ctermfg=3   cterm=bold
hi ALEErrorSign      		    ctermfg=1   cterm=bold

let g:ale_linters = {
\   'c': ['ccls', 'clang'],
\   'cpp': ['ccls', 'clang'],
\   'javascript': ['eslint'],
\   'php': ['php'],
\   'python': ['pyls', 'flake8'],
\   'sh': ['language_server', 'shellcheck', 'shell'],
\   'zsh': ['language_server', 'shellcheck', 'shell'],
\}
let g:ale_fixers = {
\   '*': ['trim_whitespace', 'remove_trailing_lines'],
\   'c': ['clang-format'],
\   'cpp': ['clang-format'],
\   'css': ['prettier'],
\   'go': ['gofmt'],
\   'html': ['prettier'],
\   'javascript': ['prettier'],
\   'json': ['prettier'],
\   'php': ['prettier'],
\   'python': ['black'],
\   'sh': ['shfmt'],
\   'scss': ['prettier'],
\   'yaml': ['prettier'],
\}

" fzf colors
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Statement'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'CursorLineNr'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'ErrorMsg'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Default fzf layout
let g:fzf_layout = { 'down': '~50%' }

" Python paths, needed for virtualenvs
let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog = '/usr/bin/python2'

" Syntax highlighting
let g:python_highlight_all = 1

" Go - $ go get -u github.com/stamblerre/gocode
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'

" LaTeX
let g:livepreview_previewer = 'zathura'

" Enable "Rainbow Parentheses Improved"
let g:rainbow_active = 1

" Whitspace
let g:extra_whitespace_ignored_filetypes = [ 'help', 'vim-plug' ]

" GitGutter
set updatetime=1000
hi GitGutterChange       ctermfg=3    cterm=bold
hi GitGutterAdd          ctermfg=2    cterm=bold
hi GitGutterDelete       ctermfg=1    cterm=bold
hi GitGutterChangeDelete ctermfg=5 	  cterm=bold

" Open Nerd Tree if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Emmet settings
let g:user_emmet_mode='a'
let g:user_emmet_leader_key=','
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" Deoplete - autocompletion
let g:deoplete#enable_at_startup = 1
set completeopt-=preview

call deoplete#custom#source('ultisnips', 'rank', 1000)

" AutoPairs
let g:AutoPairs={'(':')', '[':']', '{':'}', "'":"'", '"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"} "'<':'>',

"On startup, go to the last changes
"au BufEnter * :'.

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

"===================
" Language-specific
"===================
augroup langindentation
	autocmd Filetype c setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
	autocmd Filetype cpp setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
	autocmd Filetype css setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
	autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
	autocmd Filetype html setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
	autocmd Filetype json setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
	autocmd Filetype scss setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
	autocmd Filetype php setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
	autocmd Filetype yaml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
augroup END

"==============
" Key Bindings
"==============
" Leader key
let mapleader = ' '

" enable/disable deoplete
map <Leader>d :call deoplete#toggle()<CR>

" gitgutter maping
map <Leader>gt :GitGutterToggle<CR>
nmap gn <Plug>(GitGutterNextHunk)
nmap gN <Plug>(GitGutterPrevHunk)
nmap gs <Plug>(GitGutterStageHunk)
nmap gu <Plug>(GitGutterUndoHunk)
nmap gp <Plug>(GitGutterPreviewHunk)

" Disable hlsearch
map <C-s> :noh<CR>

" Go to last change
map <Leader>l :'.<CR>

" Complete with <TAB>
" inoremap <expr> <silent> <Tab>  pumvisible()?"\<C-n>":"\<TAB>"
" inoremap <expr> <silent> <S-TAB>  pumvisible()?"\<C-p>":"\<S-TAB>"

" When line overflows, it will go
" one _visual_ line and not actual
map j gj
map k gk

" fzf, fuzzy finder
nnoremap <C-p> :Files<CR>
nnoremap <C-g> :GFiles<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

map <C-n> :NERDTreeToggle<CR>

" SuperTab
let g:SuperTabMappingTabLiteral = '<a-tab>'
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = '<c-n>'

" LaTeX
map <Leader>l :LLPStartPreview<CR>

" ALE - Asynchronous Lint Engine
map fw :FixWhitespace<CR>
map <Leader>af :ALEFix<CR>
map <Leader>an :ALENext<CR>
map <Leader>aN :ALEPrevious<CR>
map <Leader>ad :ALEDetail<CR>
map <Leader>ag :ALEGoToDefinitionInSplit<CR>
map <Leader>aG :ALEGoToDefinition<CR>

" Tab Managment
map <C-o> :tabnew<CR>
map <C-c> :tabclose<CR>
nnoremap <Leader>k gT
nnoremap <Leader>j gt

" Split Managment
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" Spell-check (English US and Polish)
map <F6> :setlocal spell! spelllang=en_us<CR>
map <F7> :setlocal spell! spelllang=pl<CR>

" Sudo read-only file
cnoremap sudow w !sudo tee % >/dev/null

" Open terminal
map <C-A-t> :split term://zsh<CR>:resize 10<CR>

" Exit from terminal mode
tnoremap <C-e> <C-\><C-n>

" UltiSnips
let g:UltiSnipsExpandTrigger='<C-z>'
let g:UltiSnipsJumpForwardTrigger='<C-s>'
let g:UltiSnipsJumpBackwardTrigger='<C-g>'
let g:UltiSnipsListSnippets='<C-l>'

" Identify the syntax highlighting group
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"==Encoding==
scriptencoding utf-8
