"--------------------
" Minimal statusline
"--------------------

function! RedrawMode(mode)
  " normal mode
  if a:mode ==# 'n'
    return 'nor'
    " insert mode
  elseif a:mode ==# 'i'
    return 'ins'
    " replace mode
  elseif a:mode ==# 'R'
    return 'rep'
    " visual mode
  elseif a:mode ==# 'v' || a:mode ==# 'V' || a:mode ==# ''
    return 'sel'
    " command mode
  elseif a:mode ==# 'c'
    return 'cmd'
    " terminal mode
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

set statusline=%#MinMode#\ %{RedrawMode(mode())}\ %#MinSeparator#\| " mode
set statusline+=%#MinFilename#\ %.20t\  " filename
set statusline+=%#MinModified#%{ModifiedSymbol(&modified)} " modified status
set statusline+=%= " right side
set statusline+=\%#MinLine#\ %l.%c\ %#MinSeparator#\| " ruler
set statusline+=%#MinFiletype#\ %{Filetype(&filetype)}\  " filetype
