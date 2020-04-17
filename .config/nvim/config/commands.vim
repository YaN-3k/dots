" ┏━┓┏━┓┏┏┓┏┏┓┳━┓┏┓┓┳━┓┓━┓
" ┃  ┃ ┃┃┃┃ ┃┃┃ ┃━┫┃┃┃┃ ┃┗━┓
" ┗━┛┛━┛┛ ┇┛ ┇┛ ┇┇┗┛┇━┛━━┛

" basic file system commands
nnoremap <C-t> :!touch<space>
nnoremap <C-d> :!mkdir -p<space>
nnoremap <C-v> :!mv %<space>

" switch to normal mode
inoremap jk <esc>

" when line overflows, it will go
" one _visual_ line and not actual
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" tab managment
nnoremap <C-o> :tabnew<cr>
nnoremap <C-c> :tabclose<cr>
nnoremap <Leader>k gT
nnoremap <Leader>j gt

" spell-check (English US and Polish)
map <F6> :setlocal spell! spelllang=en_us<cr>
map <F7> :setlocal spell! spelllang=pl<cr>

" split Managment
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" disable hlsearch
map <C-s> :noh<cr>:echo<cr>

" enable and disable auto comment
nnoremap <leader>c :setlocal formatoptions-=cro<cr>
nnoremap <leader>C :setlocal formatoptions+=cro<cr>
inoremap <M-return> <esc>:setlocal formatoptions-=cro<cr>o<esc>:setlocal formatoptions+=cro<cr>i
nnoremap <M-o> <esc>:setlocal formatoptions-=cro<cr>o<esc>:setlocal formatoptions+=cro<cr>i
nnoremap <M-O> <esc>:setlocal formatoptions-=cro<cr>O<esc>:setlocal formatoptions+=cro<cr>i

" enable and disable auto indent
nnoremap <leader>i :setlocal autoindent<cr>
nnoremap <leader>I :setlocal noautoindent<cr>

" go to last change
nnoremap <leader>l :'.<cr>

" replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" check file in shellcheck:
"noremap <leader>s :!clear && shellcheck %<cr>
noremap <leader>s :sp \| terminal shellcheck %<cr>:resize 15<cr>

" deletes all trailing whitespace
noremap <leader>fw :%s/\s\+$//e<cr>

augroup BufferWrite
	au!
	" automatically deletes all trailing whitespace on save.
	"autocmd BufWritePre * %s/\s\+$//e
	" when shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost files,directories !shortcuts
	" run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
	" update binds when sxhkdrc is updated.
	autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
	" reload vim when configuration is updated
	autocmd BufWritePost init.vim,general.vim,commands.vim,statusline.vim,plugins.vim source $MYVIMRC
augroup end

augroup Compile
	au!
	autocmd Filetype c nnoremap <leader>m :make<cr>
	autocmd Filetype c nnoremap <leader>b :!gcc % -o %:r.out<cr>
	autocmd Filetype c nnoremap <leader>r :!./%:r.out<cr>

	autocmd Filetype cpp nnoremap <leader>m :make<cr>
	autocmd Filetype cpp nnoremap <leader>b :!g++ % -o %:r.out<cr>
	autocmd Filetype cpp nnoremap <leader>r :!./%:r.out<cr>

	autocmd Filetype rust nnoremap <leader>r :!cargo run<cr>

	autocmd Filetype sh,zsh nnoremap <leader>x :!chmod +x %<cr>
	autocmd Filetype sh,zsh nnoremap <leader>e :!./%<cr>
augroup end

" open terminal
noremap <C-A-t> :split term://zsh<cr>:resize 15<cr>

" exit from terminal mode
"tnoremap <Esc> <C-\><C-n>
tnoremap <C-e> <C-\><C-n>

" open netrw
nmap <silent><C-n> :Lexplore<cr>

" ignore
let g:netrw_list_hide= '.*\.swp$,*/tmp/*,*.so,*.swp,*.zip,*.git,^\.\=/\=$'

" open netrw if no files were specified
"augroup OpenNetrw
"	au!
"	autocmd StdinReadPre * let s:std_in=1
"	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Lexplore | endif
"augroup end

" close netrw/nerdtree if it's the only buffer open
augroup finalcountdown
  au!
  autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif
  autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) || &buftype == 'quickfix' |q|endif
augroup END

" netrw settings
let g:netrw_banner = 0
let g:netrw_liststyle = 4
let g:netrw_browse_split = 0
let g:netrw_winsize = 20

function! OpenToRight()
	:normal v
	let g:path=expand('%:p')
	:q!
	execute 'belowright vnew' g:path
	:normal <C-l>
endfunction

function! OpenBelow()
	:normal v
	let g:path=expand('%:p')
	:q!
	execute 'belowright new' g:path
	:normal <C-l>
endfunction

function! NetrwMappings()
	" Hack fix to make ctrl-l work properly
	noremap <buffer> <C-l> <C-w>l
	noremap <buffer><c-v> :call OpenToRight()<cr>
	noremap <buffer><C-x> :call OpenBelow()<cr>
endfunction

augroup netrw_mappings
	autocmd!
	autocmd filetype netrw call NetrwMappings()
augroup END

" restore cursor position
function! ResCur()
	if line("'\"") <= line('$')
		normal! g`"
		return 1
	endif
endfunction
augroup resCur
	autocmd!
	autocmd BufWinEnter * call ResCur()
augroup END

" zoom
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
map <leader>z :call Zoom()<cr>

" toggle statusbar
nnoremap <S-T> :call ToggleHiddenAll()<cr>
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

" auto pair
nnoremap <Leader>p :call ToggleAutoPair()<cr>
let s:pair = 1
function! ToggleAutoPair()
	if s:pair == 1
		let s:pair = 0
		inoremap { {}<esc>ha
		inoremap ( ()<esc>ha
		inoremap ` ``<esc>ha
		inoremap ' ''<esc>ha
		inoremap " ""<esc>ha
	else
		let s:pair = 1
		iunmap {
		iunmap (
		iunmap `
		iunmap '
		iunmap "
	endif
endfunction
call ToggleAutoPair()

" Show syntax highlighting groups for word under cursor
nmap <F10> :call <SID>SynStack()<CR>
function! <SID>SynStack()
	if !exists('*synstack')
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" vim diff highlighting
if &diff
	hi DiffAdd      ctermbg=NONE   ctermfg=2      cterm=NONE
	hi DiffDelete   ctermbg=NONE   ctermfg=1      cterm=NONE
	hi DiffChange   ctermbg=NONE   ctermfg=3      cterm=NONE
	hi DiffText     ctermbg=NONE   ctermfg=7      cterm=NONE
endif

" Use D to show documentation in preview window
"nnoremap <silent><C-d> :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" abbreviations
iab @@ Cherrry9@disroot.org
map <leader>t :r ~/.local/share/template<cr>
