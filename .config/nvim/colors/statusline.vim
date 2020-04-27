" ┓━┓┏┓┓┳━┓┏┓┓┳ ┓┓━┓┳  o┏┓┓┳━┓
" ┗━┓ ┃ ┃━┫ ┃ ┃ ┃┗━┓┃  ┃┃┃┃┣━
" ━━┛ ┇ ┛ ┇ ┇ ┇━┛━━┛┇━┛┇┇┗┛┻━┛

" ~~ Statusline configuration ~~
" ':help statusline' is your friend!

" color depending on mode {{{
function! RedrawModeColors(mode)
	" normal mode
	if a:mode ==# 'n'
		hi MyStatuslineMode ctermbg=0 ctermfg=4 cterm=none
	" insert mode
	elseif a:mode ==# 'i'
		hi MyStatuslineMode ctermbg=0 ctermfg=3 cterm=none
	" replace mode
	elseif a:mode ==# 'R'
		hi MyStatuslineMode ctermbg=0 ctermfg=1 cterm=none
	" visual mode
	elseif a:mode ==# 'v' || a:mode ==# 'V' || a:mode ==# '^V'
		hi MyStatuslineMode ctermbg=0 ctermfg=5 cterm=none
	" command mode
	elseif a:mode ==# 'c'
		hi MyStatuslineMode ctermbg=0 ctermfg=6 cterm=none
	" terminal mode
	elseif a:mode ==# 't'
		hi MyStatuslineMode ctermbg=0 ctermfg=1 cterm=none
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

" modification mark {{{
function! SetModifiedSymbol(modified)
	if a:modified == 1
		hi MyStatuslineModifiedBody ctermbg=NONE cterm=NONE ctermfg=7
		return '+'
	else
		hi MyStatuslineModifiedBody ctermbg=NONE cterm=bold ctermfg=7
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
"set statusline+=%#MyStatuslineSeparator#▒░
"set statusline+=%#MyStatuslineMode#%{ModeName(mode())}
"set statusline+=%#MyStatuslineSeparator#░▒

" filename
set statusline+=%#MyStatuslineSeparator#▒
set statusline+=%#MyStatuslineMode#%t
set statusline+=%#MyStatuslineSeparator#░▒▓█

" Modified status
set statusline+=%#MyStatuslineModifiedBody#%{SetModifiedSymbol(&modified)}%#Reset#

"==================
" right side items
"==================
" current scroll percentage
set statusline+=%=
set statusline+=%#MyStatuslineSeparator#▓▒░
set statusline+=\%#MyStatuslineLinePerc#%2p%%
set statusline+=%#MyStatuslineSeparator#░▒▓

" line and column
set statusline+=%#MyStatuslineSeparator#▓▒░
set statusline+=%#MyStatuslineLineCol#%2l
set statusline+=\/%#MyStatuslineLineCol#%2c
set statusline+=%#MyStatuslineSeparator#░▒▓

" padding
"set statusline+=\ \

" filetype
set statusline+=%#MyStatuslineSeparator#▓▒░
set statusline+=\%#MyStatuslineFiletype#%{SetFiletype(&filetype)}
set statusline+=\ \%#MyStatuslineSeparator#▒
" }}}

" colors {{{
hi StatusLine               ctermbg=none   ctermfg=5      cterm=none
hi StatusLineNC             ctermbg=none   ctermfg=8      cterm=bold

hi MyStatuslineFilename     ctermbg=0      ctermfg=7      cterm=none

hi MyStatuslineModified     ctermbg=none   ctermfg=0      cterm=none

hi MyStatuslineLineCol      ctermbg=0      ctermfg=3      cterm=none
hi MyStatuslineLinePerc     ctermbg=0      ctermfg=2      cterm=none

hi MyStatuslineFiletype     ctermbg=0      ctermfg=5      cterm=italic

hi Reset                    ctermbg=none   ctermfg=none   cterm=none
hi MyStatuslineSeparator    ctermbg=none   ctermfg=0      cterm=reverse
" }}}

" vim: fdm=marker:sw=2:sts=2:et
