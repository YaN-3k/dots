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

" cache
set nobackup
set noswapfile
set undodir=~/.config/nvim/cache/undo
set undofile

" coffee pasta
set clipboard=unnamedplus

" plebs mode
set mouse=a

set updatetime=100

" encoding
scriptencoding utf-8
" }}}

" looks {{{

" show matching brackets/parenthesis
set showmatch
set matchtime=3

" disable startup message
set shortmess+=I

" syntax highlighting
syntax on
set synmaxcol=512

" autocompletion menu
set pumheight=10

" statusline
set laststatus=2
set noruler
set noshowcmd
set noshowmode

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

" vim diff highlighting
if &diff
	hi DiffAdd      ctermbg=NONE   ctermfg=2      cterm=NONE
	hi DiffChange   ctermbg=NONE   ctermfg=3      cterm=NONE
	hi DiffDelete   ctermbg=NONE   ctermfg=1      cterm=NONE
	hi DiffText     ctermbg=NONE   ctermfg=7      cterm=NONE
endif

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
nnoremap <C-o> :tabnew<cr>
nnoremap <C-c> :tabclose<cr>

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

" split style
set fillchars=vert:▒

" split management
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
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
" netrw settings
let g:netrw_banner = 0
let g:netrw_liststyle = 4
let g:netrw_browse_split = 0
let g:netrw_winsize = 20

" open netrw
nnoremap <silent><C-n> :Lexplore<cr>

" ignore
let g:netrw_list_hide= '.*\.swp$,*/tmp/*,*.so,*.swp,*.zip,*.git,^\.\=/\=$'

" open netrw if no files were specified
augroup OpenNetrw
	au!
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Lexplore | endif
augroup end

" close netrw/nerdtree if it's the only buffer open
augroup finalcountdown
	au!
	autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif
	autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) || &buftype == 'quickfix' |q|endif
augroup END

function! OpenToRight()
	normal v
	let g:path=expand('%:p')
	q!
	execute 'belowright vnew' g:path
	normal <C-l>
endfunction

function! OpenBelow()
	normal v
	let g:path=expand('%:p')
	q!
	execute 'belowright new' g:path
	normal <C-l>
endfunction

function! NetrwMappings()
	" Hack fix to make ctrl-l work properly
	nnoremap <buffer> <C-l> <C-w>l
	nnoremap <buffer><c-v> :call OpenToRight()<cr>
	nnoremap <buffer><C-o> :call OpenBelow()<cr>
endfunction

augroup netrw_mappings
	autocmd!
	autocmd filetype netrw call NetrwMappings()
augroup END
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

" enable and disable auto comment
nnoremap <leader>c :setlocal formatoptions-=cro<cr>
nnoremap <leader>C :setlocal formatoptions+=cro<cr>

" enable and disable auto indent
nnoremap <leader>i :setlocal autoindent<cr>
nnoremap <leader>I :setlocal noautoindent<cr>

" replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" check file in shellcheck:
noremap <leader>s :sp \| terminal shellcheck %<cr>:resize 15<cr>

" deletes all trailing whitespace
noremap <leader>fw :%s/\s\+$//e<cr>

" exit/open terminal
noremap <C-A-t> :split term://zsh<cr>:resize 15<cr>
"tnoremap <Esc> <C-\><C-n>
tnoremap <C-e> <C-\><C-n>

" execute file
nnoremap <leader>x :!chmod +x %<cr>
nnoremap <leader>e :!./%<cr>

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

" syntax hl {{{
Plug 'sheerun/vim-polyglot'
" }}}

" autocompletion && linting {{{
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" }}}

" git integration {{{
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
" }}}

" features {{{
" show colors preview
Plug 'lilydjwg/colorizer'

" extend %
Plug 'isa/vim-matchit'

" quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" fuzzy searching
Plug 'kien/ctrlp.vim'

" move lines
Plug 'matze/vim-move'

" split management between vim and tmux
Plug 'christoomey/vim-tmux-navigator'

Plug 'vimwiki/vimwiki'
Plug 'wikitopian/hardmode'
"Plug '~/.config/fzf/fzf'
"Plug 'junegunn/fzf.vim'
"" }}}

call plug#end()
" }}}

" autocompletion && linting {{{
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent><leader>K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting code.
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
"nmap <silent> <C-s> <Plug>(coc-range-select)
"xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" }}}

" git {{{
let g:gitgutter_max_signs = 1500
let g:gitgutter_diff_args = '-w'

" custom symbols
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = ':'

" maping
nnoremap <Leader>gt :GitGutterToggle<cr>
nnoremap gn :GitGutterNextHunk<cr>
nnoremap gN :GitGutterPrevHunk<cr>
nnoremap gs :GitGutterStageHunk<cr>
nnoremap gu :GitGutterUndoHunk<cr>
nnoremap gp :GitGutterPreviewHunk<cr>
" }}}

" fuzzy searching {{{
" CtrlP
let g:ctrlp_show_hidden = 1
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_map = '<c-p>'
nnoremap <Tab> :CtrlPBuffer<cr>
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

" feature {{{
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
map <leader>z :call Zoom()<cr>
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

" toggle statusbar {{{
nnoremap <silent><S-T> :call ToggleHiddenAll()<cr>
let s:hidden_all = 0
function! ToggleHiddenAll()
	if s:hidden_all  == 0
		let s:hidden_all = 1
		set laststatus=1
		set noruler
		set noshowcmd
		set showmode
	else
		let s:hidden_all = 0
		set laststatus=2
		set noruler
		set noshowcmd
		set noshowmode
	endif
endfunction
" }}}

" show syntax highlighting groups {{{
nmap <silent><F10> :call <SID>SynStack()<CR>
function! <SID>SynStack()
	if !exists('*synstack')
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" }}}
" }}}

color iceberg
" vim: fdm=marker
