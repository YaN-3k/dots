"--------------------
" minimal statusline
"--------------------

function! RedrawMode(mode)
	if a:mode ==# 'n'
		return 'nor'
	elseif a:mode ==# 'i'
		return 'ins'
	elseif a:mode ==# 'R'
		return 'rep'
	elseif a:mode ==# 'v' || a:mode ==# 'V' || a:mode ==# ''
		return 'sel'
	elseif a:mode ==# 'c'
		return 'cmd'
	elseif a:mode ==# 't'
		return 'trm'
	endif
	return ''
endfunction

function! ModifiedSymbol(modified)
	if a:modified == 1 | return '[*]' | else | return '' | endif
endfunction

function! Filetype(filetype)
	if a:filetype ==# '' | return 'txt' | else | return a:filetype | endif
endfunction

set statusline=%#MinMode#\ %{RedrawMode(mode())}\ %#MinSeparator#\|
set statusline+=%#MinFilename#\ %.20t\ 
set statusline+=%#MinModified#%{ModifiedSymbol(&modified)} 
set statusline+=%=
set statusline+=\%#MinLine#\ %l.%v\ %#MinSeparator#\|
set statusline+=%#MinFiletype#\ %{Filetype(&filetype)}\ 
