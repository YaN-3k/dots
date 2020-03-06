" ~~~~ Statusline configuration ~~~~
" ':help statusline' is your friend!

" Color depending on mode
function! RedrawModeColors(mode) " {{{
	" Normal mode
	if a:mode == 'n'
		hi MyStatuslineFilename ctermfg=4 cterm=none ctermbg=0
	" Insert mode
	elseif a:mode == 'i'
		hi MyStatuslineFilename ctermfg=3 cterm=none ctermbg=0
	" Replace mode
	elseif a:mode == 'R'
		hi MyStatuslineFilename ctermfg=1 cterm=none ctermbg=0
	" Visual mode
	elseif a:mode == 'v' || a:mode == 'V' || a:mode == '^V'
		hi MyStatuslineFilename ctermfg=5 cterm=none ctermbg=0
	" Command mode
	elseif a:mode == 'c'
		hi MyStatuslineFilename ctermfg=6 cterm=none ctermbg=0
	" Terminal mode
	elseif a:mode == 't'
		hi MyStatuslineFilename ctermfg=1 cterm=none ctermbg=0
	endif
	" Return empty string so as not to display anything in the statusline
	return ''
endfunction
" }}}

" Modification mark
function! SetModifiedSymbol(modified) " {{{
	if a:modified == 1
		hi MyStatuslineModifiedBody ctermbg=NONE cterm=NONE ctermfg=7
		return '+'
	else
		hi MyStatuslineModifiedBody ctermbg=NONE cterm=bold ctermfg=7
		return ''
	endif
endfunction
" }}}

" Filetype
function! SetFiletype(filetype) " {{{
	if a:filetype == ''
		return '-'
	else
		return a:filetype
	endif
endfunction
" }}}

"=================
" Statusbar items
"=================
" This will not be displayed, but the function RedrawModeColors will be
" called every time the mode changes, thus updating the colors used for the
" components.
set statusline=%{RedrawModeColors(mode())}

"=================
" Left side items
"=================
" Filename
set statusline+=%#MyStatuslineFiletype#█▓▒░
set statusline+=/\%#MyStatuslineFilename#%t
set statusline+=%#MyStatuslineSeparator#░▒▓█

" Modified status
set statusline+=%#MyStatuslineModifiedBody#%{SetModifiedSymbol(&modified)}%#Reset#

"==================
" Right side items
"==================
" Current scroll percentage and total lines of the file
set statusline+=%=
set statusline+=%#MyStatuslineLineCol#█▓▒░
set statusline+=\/%#MyStatuslineLineColBody#%2p%%
set statusline+=%#MyStatuslineLineCol#░▒▓█

" Padding
"set statusline+=\ \

" Filetype
set statusline+=%#MyStatuslineFiletype#█▓▒░
set statusline+=\/%#MyStatuslineFiletypeBody#%{SetFiletype(&filetype)}
set statusline+=%#MyStatuslineFiletype#░▒▓█

" Setup the colors
hi StatusLine               ctermfg=5     ctermbg=NONE  cterm=NONE
hi StatusLineNC             ctermbg=NONE  ctermfg=8     cterm=bold

hi MyStatuslineSeparator    ctermbg=NONE  ctermfg=0     cterm=reverse

hi MyStatuslineModified     ctermbg=NONE  ctermfg=0     cterm=NONE

hi MyStatuslineFiletype     ctermbg=NONE  ctermfg=0     cterm=reverse
hi MyStatuslineFiletypeBody ctermfg=5     cterm=italic  ctermbg=0

hi MyStatuslineLineCol      ctermbg=NONE  ctermfg=0     cterm=reverse
hi MyStatuslineLineColBody  ctermbg=0     ctermfg=2     cterm=none

hi Reset                    ctermbg=NONE  ctermfg=NONE  cterm=NONE
