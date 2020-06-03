"
"  ████     ██                           ██
" ░██░██   ░██                          ░░
" ░██░░██  ░██  █████   ██████  ██    ██ ██ ██████████
" ░██ ░░██ ░██ ██░░░██ ██░░░░██░██   ░██░██░░██░░██░░██
" ░██  ░░██░██░███████░██   ░██░░██ ░██ ░██ ░██ ░██ ░██
" ░██   ░░████░██░░░░ ░██   ░██ ░░████  ░██ ░██ ░██ ░██
" ░██    ░░███░░██████░░██████   ░░██   ░██ ███ ░██ ░██
" ░░      ░░░  ░░░░░░  ░░░░░░     ░░    ░░ ░░░  ░░  ░░
"
" general {{{
" basic {{{
" leader key
let mapleader = ' '

" working dir the same as file
"set autochdir

" cache
set nobackup
set noswapfile
set undodir=~/.config/nvim/cache/undo
set undofile

" coffee pasta
set clipboard=unnamedplus

" plebs mode
set mouse=a

" time betwen updates
set updatetime=100

" python host prog
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

" encoding
scriptencoding utf-8
" }}}

" looks {{{
"
" o┏━┓┳━┓┳━┓┳━┓┳━┓┏━┓
" ┃┃  ┣━ ┃━┃┣━ ┃┳┛┃ ┳
" ┇┗━┛┻━┛┇━┛┻━┛┇┗┛┇━┛

" syntax highlighting
color iceberg
set termguicolors
set synmaxcol=512
syntax on

" statusline
set laststatus=2
set noruler
set noshowcmd
set noshowmode
source $HOME/.config/nvim/statusline.vim

" split style
set fillchars=vert:▒

" show matching brackets/parenthesis
set showmatch
set matchtime=3

" avoid message and prompts
set shortmess+=icw

" autocompletion menu
set pumheight=10

" show line numbers
set number relativenumber
set numberwidth=1

" line wrapping
set wrap

" highlight current line
set cursorline
"set cursorcolumn

" minimal number to keep above/below the cursor
set scrolloff=5

" show invisibles
set list
set listchars=
set listchars+=tab:·\ 
set listchars+=trail:·
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=nbsp:░

" line highlighting if it is longer than 80 characters
hi OverLength             ctermbg=none   ctermfg=1      cterm=underline
"match OverLength /\%81v.\+/

" folding {{{
"set nofoldenable
"set foldlevel=99
"set foldminlines=99
"set foldlevelstart=99
" }}}
" }}}

" indentation {{{
filetype plugin indent on
set autoindent
set noexpandtab
set shiftround
set shiftwidth=4
set tabstop=4

augroup langindentation
	autocmd Filetype c,cpp      setlocal tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab
	autocmd Filetype css        setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
	autocmd Filetype html       setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
	autocmd Filetype javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
	autocmd Filetype json       setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
	autocmd Filetype php        setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
	autocmd Filetype scss       setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
	autocmd Filetype yaml       setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup END
" }}}

" searching {{{
set hlsearch
set ignorecase
set inccommand=nosplit
set incsearch
set infercase
set smartcase

" disable hlsearch
nnoremap <silent><C-s> :noh<cr>:echo<cr>
" }}}

" buffers {{{
set hidden

" tabs
nnoremap <leader>bo :tabnew<cr>
nnoremap <leader>bc :tabclose<cr>

" tab management
nnoremap <M-1> 1gt
nnoremap <M-2> 2gt
nnoremap <M-3> 3gt
nnoremap <M-4> 4gt
nnoremap <M-5> 5gt
nnoremap <M-6> 6gt
nnoremap <M-7> 7gt
nnoremap <M-8> 8gt
nnoremap <M-9> 9gt
nnoremap <M-0> 10gt

" split
set splitright
set splitbelow

" split management
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
" }}}

" wildmenu {{{
" find
set path+=**

" lazy file name tab completion
set wildmenu
set wildignorecase
set wildmode=longest:full,full

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
" }}}

" netrw {{{
" this hides the netrw banner
let g:netrw_banner = 0

" netrw listing style
let g:netrw_liststyle = 4

" how to open new files
let g:netrw_browse_split = 0

" this makes the netrw window size only a quarter of the screen's width
let g:netrw_winsize = 25

" open netrw
nnoremap <silent><leader>be :E<cr>

" close buffer
nnoremap <silent><leader>bd :bw<cr>

" ignore files that vim doesn't use
let g:netrw_list_hide= '.*\.swp$,*/tmp/*,*.so,*.swp,*.zip,*.git,^\.\=/\=$'
" }}}

" restore cursor position {{{
function! ResCur()
	if line("'\"") <= line('$')
		normal! g`"
		return 1
	endif
endfunction

if has("folding")
  function! UnfoldCur()
    if !&foldenable
      return
    endif
    let cl = line(".")
    if cl <= 1
      return
    endif
    let cf  = foldlevel(cl)
    let uf  = foldlevel(cl - 1)
    let min = (cf > uf ? uf : cf)
    if min
      execute "normal!" min . "zo"
      return 1
    endif
  endfunction
endif

augroup resCur
  autocmd!
  if has("folding")
    autocmd BufWinEnter * if ResCur() | call UnfoldCur() | endif
  else
    autocmd BufWinEnter * call ResCur()
  endif
augroup END
" }}}

" zoom {{{
nnoremap <leader>bz :call Zoom()<cr>
function! Zoom() abort
	if winnr('$') > 1
		if exists('t:zoomed') && t:zoomed
		execute t:zoom_winrestcmd
		let t:zoomed = 0
	else
		let t:zoom_winrestcmd = winrestcmd()
		resize
		vertical resize
		let t:zoomed = 1
		endif
	else
		execute 'silent !tmux resize-pane -Z'
	endif
endfunction
" }}}
" }}}

" mapping {{{
" switch to normal mode
inoremap jk <esc>

" when line overflows, it will go
" one _visual_ line and not actual
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" spell-check (English US and Polish)
noremap <F6> :setlocal spell! spelllang=en_us<cr>
noremap <F7> :setlocal spell! spelllang=pl<cr>

" replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" check file in shellcheck:
nnoremap <leader>bt :fc \| terminal shellcheck %<cr>:resize 15<cr>

" deletes all trailing whitespace
nnoremap <leader>fw :%s/\s\+$//e<cr>

" exit/open terminal
nnoremap <leader>bt :split term://zsh<cr>:resize 15<cr>
"tnoremap <Esc> <C-\><C-n>
tnoremap <C-e> <C-\><C-n>

" execute file
nnoremap <leader>bx :!chmod +x %<cr>
nnoremap <leader>br :!./%<cr>

" abbreviations
iab @@ Cherrry9@disroot.org

augroup BufferWrite
	au!
	" automatically deletes all trailing whitespace on save.
	"autocmd BufWritePre * %s/\s\+$//e
	" when shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost files,directories !shortcuts
	" run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xdefaults !xrdb %
	" update binds when sxhkdrc is updated.
	autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
	" reload vim when configuration is updated
	autocmd BufWritePost init.vim,iceberg.vim source $MYVIMRC
augroup end

" show syntax highlighting groups {{{
nmap <silent><F10> :call <SID>SynStack()<CR>
function! <SID>SynStack()
	if !exists('*synstack')
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

map <F9> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" }}}
" }}}

" plugins {{{
" setup {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	echo 'Downloading junegunn/vim-plug to manage plugins...'
	silent call system('mkdir -p ~/.config/nvim/{autoload,bundle,cache/{cache,undo,backups,swaps}}')
	silent call system('pip3 install --user pynvim msgpack')
	silent call system('curl -flo ~/.config/nvim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
	execute 'source  ~/.config/nvim/autoload/plug.vim'
	augroup plugsetup
		au!
		autocmd VimEnter * PlugInstall
	augroup end
endif
" }}}

" load {{{
call plug#begin('~/.config/nvim/bundle')

" syntax hl
Plug 'sheerun/vim-polyglot'

" Conquer Of Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" project management
Plug 'mhinz/vim-startify'

" default snippets
Plug 'honza/vim-snippets'

" latex suppoer
Plug 'lervag/vimtex'
" autodetect latex files correctly
let g:tex_flavor = 'latex'

" shows keybindings in popup
Plug 'liuchengxu/vim-which-key'

" git integration
Plug 'tpope/vim-fugitive'
" commit browser
Plug 'junegunn/gv.vim'

" fuzzy searching
Plug '~/.config/fzf/fzf'
Plug 'junegunn/fzf.vim'

" changes Vim working directory to project root
Plug 'airblade/vim-rooter'

" color preview
"Plug 'lilydjwg/colorizer'

" extend %
Plug 'isa/vim-matchit'

" lightning fast left-right movement
Plug 'unblevable/quick-scope'

" quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" move lines
Plug 'matze/vim-move'

" split management between vim and tmux
Plug 'christoomey/vim-tmux-navigator'

" notes and diaries
Plug 'vimwiki/vimwiki'

" vanilla vim is to easy
Plug 'takac/vim-hardtime'
let g:hardtime_default_on = 0

call plug#end()
" }}}

" coc {{{
" global extensions
let g:coc_global_extensions = [
\	'coc-lists',
\	'coc-snippets',
\	'coc-pairs',
\	'coc-yank',
\	'coc-git',
\	'coc-highlight',
\	'coc-tabnine',
\	'coc-dictionary',
\	'coc-tag',
\	'coc-word',
\]

" language extensions
let g:coc_global_extensions += [
\	'coc-vimtex',
\	'coc-html',
\	'coc-css',
\	'coc-emmet',
\	'coc-python',
\	'coc-tsserver',
\	'coc-json',
\	'coc-prettier',
\	'coc-rls',
\]

" autocompletion {{{
" completion with tab or shift-tab
inoremap <expr><silent><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><silent><S-tab> pumvisible() ? "\<c-p>" : "\<tab>"

" refresh
inoremap <silent><expr> <c-space> coc#refresh()

" trigger snippets
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : 
                                           \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" real tab
inoremap <A-tab> <tab>

" real enter
inoremap <M-cr> <cr>
" }}}

" linting {{{
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>fc  <Plug>(coc-format)

" apply AutoFix to problem on the current line
nmap <leader>fq  <Plug>(coc-fix-current)

" navigate diagnostics
nnoremap <silent> [d <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]d <Plug>(coc-diagnostic-next)

" list errors and warnings
nnoremap <silent><leader>cd  <Plug>(coc-list-diagnostics)

" add `:Format` command to format current buffer
command! -nargs=0 Format :call CocAction('format')

" add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" }}}

" definition {{{
" g... - go to definition / reference / implementation etc.
nmap <silent><leader>dd <Plug>(coc-definition)
nmap <silent><leader>dt <Plug>(coc-type-definition)
nmap <silent><leader>di <Plug>(coc-implementation)
nmap <silent><leader>dr <Plug>(coc-references)

" symbol renaming.
nmap <leader>cr <Plug>(coc-rename)
" highlight symbol under cursor 
"autocmd CursorHold * silent call CocActionAsync('highlight')

" get hint on whatever's under the cursor
nnoremap <silent><leader>dh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" }}}

" snippets {{{
" trigger snippet expand
imap <C-j> <Plug>(coc-snippets-expand)

" select text for visual placeholder of snippet
vmap <C-j> <Plug>(coc-snippets-select)

" expand and jump (make expand higher priority)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" jump to next placeholder
let g:coc_snippet_next = '<c-j>'

" jump to previous placeholder
let g:coc_snippet_prev = '<c-k>'
" }}}

" git {{{
" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)

" show chunk diff at current position
nmap <silent><leader>hi :CocCommand git.chunkInfo<cr>

" undo chunk
nmap <silent><leader>hu :CocCommand git.chunkUndo<cr>

" stage chunk
nmap <silent><leader>hs :CocCommand git.chunkStage<cr>

" show commit contains current position
nmap gc <Plug>(coc-git-commit)

" create text object for git chunks
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)
" }}}

" other mapping {{{
" coc list
nmap <silent><leader>cl  <Plug>(CocList)

" map function and class text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" run code actions
vmap <leader>ca <Plug>(coc-codeaction-selected)
nmap <leader>ca <Plug>(coc-codeaction)
" }}}
" }}}

" startify {{{
let g:startify_custom_header = [
			\ '   _____   __                 _____            ',
			\ '   ___  | / /_____________   ____(_)______ ___ ',
			\ '   __   |/ /_  _ \  __ \_ | / /_  /__  __ `__ \',
			\ '   _  /|  / /  __/ /_/ /_ |/ /_  / _  / / / / /',
			\ '   /_/ |_/  \___/\____/_____/ /_/  /_/ /_/ /_/ ',
			\]

let g:startify_lists = [
			\ { 'type': 'files',     'header': ['   Files']            },
			\ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
			\ { 'type': 'sessions',  'header': ['   Sessions']       },
			\ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
			\ ]

let g:startify_bookmarks = [
			\ { 'i': '~/.config/nvim/init.vim' },
			\ { 'c': '~/.config' },
			\ { 'b': '~/.local/bin' },
			\ { 'd': '~/.local/dl' },
			\ { 'D': '~/dox' },
			\ ]

" session dir
let g:startify_session_dir = '~/.config/nvim/cache/session'

" let Startify take care of buffers
let g:startify_session_delete_buffers = 1

" similar to Vim-rooter
let g:startify_change_to_vcs_root = 0

" autoload Session.vim
let g:startify_session_autoload = 1

" automaticly update session
let g:startify_session_persistence = 1

" get rid of empy buffer and quit
let g:startify_enable_special = 0
" }}}

" fuzzy searching {{{
" mapping
nnoremap <silent><tab> :Buffers<cr>
nnoremap <silent><leader>sb :Buffers<cr>
nnoremap <silent><leader>sf :Files<cr>
nnoremap <silent><leader>sg :GFiles<cr>
nnoremap <silent><leader>sp :Rg<cr>
nnoremap <silent><leader>st :Tags<cr>
nnoremap <silent><leader>sm :Marks<cr>

" fzf colorscheme
let g:fzf_colors = {
\	'fg':      ['fg', 'Normal'],
\	'bg':      ['bg', 'Normal'],
\	'hl':      ['fg', 'Statement'],
\	'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\	'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
\	'hl+':     ['fg', 'Todo'],
\	'info':    ['fg', 'Comment'],
\	'border':  ['fg', 'LineNr'],
\	'prompt':  ['fg', 'Comment'],
\	'pointer': ['fg', 'Exception'],
\	'marker':  ['fg', 'Keyword'],
\	'spinner': ['fg', 'Label'],
\	'header':  ['fg', 'Comment'],
\}

" center fzf
"let g:fzf_layout = {
"\	'up':'~90%',
"\	'window':
"\	{
"\		'width': 0.8,
"\		'height': 0.8,
"\		'yoffset':0.5,
"\		'xoffset': 0.5,
"\		'highlight': 'Type',
"\		'border': 'sharp'
"\	}
"\}

" option
let g:fzf_tags_command = 'ctags -R'
let g:fzf_history_dir = '~/.cache/fzf-history'
let g:fzf_preview_window = ''
let g:fzf_action = {
	\ 'ctrl-t': 'tab split',
	\ 'ctrl-s': 'split',
	\ 'ctrl-v': 'vsplit' }

" statusline
function! s:fzf_statusline()
	call g:C("Fzf", g:dark.black, g:dark.white, "none")
	setlocal statusline=%#Separator#▒
	setlocal statusline+=%#Fzf#FZF
	setlocal statusline+=%#Separator#█▓▒░%#Reset#
endfunction

augroup Fzf
	au!
	autocmd! User FzfStatusLine call <SID>fzf_statusline()
augroup end
" }}}

" which key {{{
" map leader to which_key
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

" create map to add keys to
let g:which_key_map =  {}
" define a separator
let g:which_key_sep = '-'
" fast up
set timeoutlen=100

" not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" coc
let g:which_key_map.c = {
			\ 'name' : '+coc',
			\ 'a' : 'code action',
			\ 'd' : 'diagnostic',
			\ 'l' : 'list',
			\ 'r' : 'symbol rename',
			\ }

" fuzzy search
let g:which_key_map.s = {
			\ 'name' : '+search',
			\ 'b' : 'buffers',
			\ 'f' : 'files',
			\ 'g' : 'git-files',
			\ 'm' : 'marks',
			\ 'p' : 'pattern',
			\ 't' : 'tags',
			\ }

" format
let g:which_key_map.f = {
			\ 'name' : '+format',
			\ 'c' : 'format code',
			\ 'q' : 'fix code',
			\ 's' : 'shellcheck',
			\ 'w' : 'fix whitespace',
			\ }

" buffers action
let g:which_key_map.b = {
			\ 'name' : '+buffer',
			\ 'c' : 'close tab',
			\ 'd' : 'delete buffer',
			\ 'e' : 'explore',
			\ 'o' : 'open tab',
			\ 'r' : 'run',
			\ 't' : 'open terminal',
			\ 'x' : 'make executable',
			\ 'z' : 'zoom',
			\ }

" goto definition
let g:which_key_map.d = {
			\ 'name' : '+documentation',
			\ 'd' : 'definition',
			\ 't' : 'type definition',
			\ 'r' : 'references',
			\ 'i' : 'implementation',
			\ 'h' : 'hint',
			\ }

" git chunk
let g:which_key_map.h = {
			\ 'name' : '+chunk',
			\ 'u' : 'undo',
			\ 's' : 'stage',
			\ 'i' : 'info',
			\ }

" vim wiki
let g:which_key_map.w = {
			\ 'name' : '+wiki',
			\ 'w' : 'wiki index',
			\ 'i' : 'diary index file',
			\ 't' : 'index in new tab',
			\ 's' : 'list wikis',
			\ ' ' : {
			\ 'name': '+diary',
			\ 'w' : 'today diary',
			\ 't' : 'today diary in new tab',
			\ 'y' : 'yesterday diary',
			\ 'm' : 'tomorrow diary',
			\ 'i' : 'generate diary links',
			\ },
			\ }

" register dictionary
call which_key#register('<Space>', "g:which_key_map")
" }}}

" quick scope {{{
" blacklist
let g:qs_buftype_blacklist = ['terminal']
" trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" }}}

" vimwiki {{{
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_list = [{'path': '~/dox/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
augroup vimwiki
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex
augroup end
" }}}
" }}}

" vim: fdm=marker
