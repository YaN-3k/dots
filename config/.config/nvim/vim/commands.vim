" disable hlsearch
map <C-s> :noh<CR>

" go to last change
nnoremap <Leader>l :'.<CR>

" Switch to normal mode
inoremap jk <esc>

" complete with <TAB>
"inoremap <expr> <silent> <Tab>  pumvisible()?"\<C-n>":"\<TAB>"
"inoremap <expr> <silent> <S-TAB>  pumvisible()?"\<C-p>":"\<S-TAB>"

" when line overflows, it will go
" one _visual_ line and not actual
nnoremap j gj
nnoremap k gk

" tab managment
map <C-o> :tabnew<CR>
map <C-c> :tabclose<CR>
nnoremap <Leader>k gT
nnoremap <Leader>j gt

" spell-check (English US and Polish)
map <F6> :setlocal spell! spelllang=en_us<CR>
map <F7> :setlocal spell! spelllang=pl<CR>

" split Managment
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Execute file
nnoremap <leader>x :!chmod +x !% && ./%<CR>

" Check file in shellcheck:
"noremap <leader>s :!clear && shellcheck %<CR>
noremap <leader>s :sp \| terminal shellcheck %<CR>

" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated, renew bash and ranger configs with new material:
autocmd BufWritePost files,directories !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
" Update binds when sxhkdrc is updated.
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" open terminal
map <C-A-t> :split term://zsh<CR>:resize 10<CR>

" exit from terminal mode
"tnoremap <Esc> <C-\><C-n>
tnoremap <C-e> <C-\><C-n>

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
command Zoom call s:Zoom()
map <leader>z :call Zoom()<cr>

" toggle statusbar
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

nnoremap <S-T> :call ToggleHiddenAll()<CR>

" identify the syntax highlighting group
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" close if final buffer is netrw or the quickfix
augroup finalcountdown
  au!
  autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif
  autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) || &buftype == 'quickfix' | q | endif
  "nmap - :Lexplore<cr>
  nmap - :NERDTreeToggle<cr>
augroup END

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
	hi DiffAdd      ctermbg=NONE   ctermfg=2      cterm=NONE
	hi DiffDelete   ctermbg=NONE   ctermfg=1      cterm=NONE
	hi DiffChange   ctermbg=NONE   ctermfg=3      cterm=NONE
	hi DiffText     ctermbg=NONE   ctermfg=7      cterm=NONE
endif

" abbreviations
iab @@ Cherrry9@disroot.org
map <leader>t :r ~/.local/share/template<CR>
