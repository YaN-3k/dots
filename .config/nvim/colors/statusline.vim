"
" ┓━┓┏┓┓┳━┓┏┓┓┳ ┓┓━┓┳  o┏┓┓┳━┓
" ┗━┓ ┃ ┃━┫ ┃ ┃ ┃┗━┓┃  ┃┃┃┃┣━
" ━━┛ ┇ ┛ ┇ ┇ ┇━┛━━┛┇━┛┇┇┗┛┻━┛
"
" ~~ Statusline configuration ~~
" ':help statusline' is your friend!

" color depending on mode {{{
function! RedrawModeColors(mode)
	" normal mode
	if a:mode ==# 'n'
		call g:C("Mode", g:dark.black,    g:dark.blue,      "none")
	" insert mode
	elseif a:mode ==# 'i'
		call g:C("Mode", g:dark.black,    g:dark.yellow,    "none")
	" replace mode
	elseif a:mode ==# 'R'
		call g:C("Mode", g:dark.black,    g:dark.red,       "none")
	" visual mode
	elseif a:mode ==# 'v' || a:mode ==# 'V' || a:mode ==# ''
		call g:C("Mode", g:dark.black,    g:dark.magenta,   "none")
	" command mode
	elseif a:mode ==# 'c'
		call g:C("Mode", g:dark.black,    g:dark.green,     "none")
	" terminal mode
	elseif a:mode ==# 't'
		call g:C("Mode", g:dark.black,    g:dark.red,       "none")
	endif
	" Return empty string so as not to display anything in the statusline
	return ''
endfunction " }}}

" nice mode name {{{
function! ModeName(mode)
  if a:mode ==# 'n'
    return 'NORMAL'
  " Insert mode
  elseif a:mode ==# 'i'
    return 'INSERT'
  " Replace mode
  elseif a:mode ==# 'R'
    return 'REPLACE'
  " Visual mode
  elseif a:mode ==# 'v'
    return 'VISUAL'
  elseif a:mode ==# 'V'
    return 'V-LINE'
  elseif a:mode ==# ''
    return 'V-BLOCK'
  " Command mode
  elseif a:mode ==# 'c'
    return 'COMMAND'
  " Terminal mode
  elseif a:mode ==# 't'
    return 'TERMINAL'
  endif
endfunction " }}}

" git {{{
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction
" }}}

" modification mark {{{
function! SetModifiedSymbol(modified)
	if a:modified == 1
		hi ModifiedBody ctermbg=NONE cterm=NONE ctermfg=7
		return '+'
	else
		hi ModifiedBody ctermbg=NONE cterm=bold ctermfg=7
		return ''
	endif
endfunction
" }}}

" filetype {{{
function! SetFiletype(filetype)
	if a:filetype ==# ''
		return '-'
	else
		return a:filetype
	endif
endfunction
" }}}

" statusbar {{{
"=================
" statusbar items
"=================
" this will not be displayed, but the function RedrawModeColors will be
" called every time the mode changes, thus updating the colors used for the
" components.
set statusline=%{RedrawModeColors(mode())}

"=================
" left side items
"=================
" Mode
"set statusline+=%#Separator#▒░
"set statusline+=%#Mode#%{ModeName(mode())}
"set statusline+=%#Separator#░▒

" filename
set statusline+=%#Separator#▒
set statusline+=%#Mode#%t

" git branch
let branch = GitBranch()
if !empty(branch)
	set statusline+=%#Separator#░▒▓
	set statusline+=%#Separator#▓▒░
	set statusline+=%#Git#%{FugitiveHead()}
	set statusline+=%#Separator#░▒▓█
else
	set statusline+=%#Separator#░▒▓█
endif

" Modified status
set statusline+=%#ModifiedBody#%{SetModifiedSymbol(&modified)}%#Reset#

"==================
" right side items
"==================
" current scroll percentage
set statusline+=%=
set statusline+=%#Separator#█▓▒░
set statusline+=\%#LinePerc#%2p%%
set statusline+=%#Separator#░▒▓

" line and column
set statusline+=%#Separator#▓▒░
set statusline+=%#LineCol#%2l
set statusline+=\/%#LineCol#%2c
set statusline+=%#Separator#░▒▓

" filetype
set statusline+=%#Separator#▓▒░
set statusline+=\%#Filetype#%{SetFiletype(&filetype)}
set statusline+=\ \%#Separator#▒
" }}}

" colors {{{
call g:C("Reset",    g:none,         g:none,           "none")
call g:C("Separator",g:none,         g:dark.black,     "reverse")
call g:C("Git",      g:dark.black,   g:dark.white,     "none")
call g:C("Modified", g:dark.black,   g:dark.black,     "none")
call g:C("LineCol",  g:dark.black,   g:dark.yellow,    "none")
call g:C("LinePerc", g:dark.black,   g:dark.green,     "none")
call g:C("Filetype", g:dark.black,   g:dark.magenta,   "italic")

" }}}

" vim: fdm=marker
