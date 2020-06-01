" o┏━┓┳━┓┳━┓┳━┓┳━┓┏━┓
" ┃┃  ┣━ ┃━┃┣━ ┃┳┛┃ ┳
" ┇┗━┛┻━┛┇━┛┻━┛┇┗┛┇━┛

" syntax {{{
"
" ┓━┓┓ ┳┏┓┓┏┓┓┳━┓┓ ┃
" ┗━┓┗┏┛┃┃┃ ┃ ┃━┫┏╋┛
" ━━┛ ┇ ┇┗┛ ┇ ┛ ┇┇ ┗
"
" setup {{{
hi clear
syntax clear
set background=dark
let g:colors_name='iceberg'
" }}}

" basic {{{
hi Normal       ctermbg=none   ctermfg=15     cterm=none
hi Cursor       ctermbg=none   ctermfg=15     cterm=none
hi Directory    ctermbg=none   ctermfg=4      cterm=none
hi ErrorMsg     ctermbg=none   ctermfg=1      cterm=none
hi VertSplit    ctermbg=none   ctermfg=0      cterm=none
hi LineNr       ctermbg=none   ctermfg=8      cterm=none
hi SignColumn   ctermbg=none   ctermfg=7      cterm=none
hi NonText      ctermbg=none   ctermfg=0      cterm=none
hi Pmenu        ctermbg=none   ctermfg=15     cterm=none
hi PmenuSel     ctermbg=0      ctermfg=4      cterm=none
hi PmenuSbar    ctermbg=none   ctermfg=none   cterm=none
hi PmenuThumb   ctermbg=0      ctermfg=0      cterm=none
hi Search       ctermbg=none   ctermfg=none   cterm=reverse
hi SpellBad     ctermbg=none   ctermfg=1      cterm=underline
hi SpellCap     ctermbg=none   ctermfg=2      cterm=underline
hi SpellLocal   ctermbg=none   ctermfg=3      cterm=underline
hi SpellRare    ctermbg=none   ctermfg=3      cterm=underline
hi StatusLine   ctermbg=0      ctermfg=15     cterm=none
hi StatusLineNC ctermbg=0      ctermfg=15     cterm=none
hi TabLine      ctermbg=none   ctermfg=none   cterm=none
hi TabLineSel   ctermbg=0      ctermfg=4      cterm=bold
hi TabLineFill  ctermbg=none   ctermfg=none   cterm=none
hi Title        ctermbg=none   ctermfg=15     cterm=none
hi Visual       ctermbg=0      ctermfg=none   cterm=none
hi WildMenu     ctermbg=8      ctermfg=0      cterm=none
hi WarningMsg   ctermbg=none   ctermfg=11     cterm=none
hi EndOfBuffer  ctermbg=none   ctermfg=0      cterm=none
hi CursorLine   ctermbg=0      ctermfg=none   cterm=none
hi CursorLineNr ctermbg=none   ctermfg=15     cterm=bold
hi CursorColumn ctermbg=0      ctermfg=none   cterm=none
hi MatchParen   ctermbg=none   ctermfg=4      cterm=underline
hi ModeMsg      ctermbg=none   ctermfg=8      cterm=none
hi NormalNC     ctermbg=none   ctermfg=15     cterm=none
hi Folded       ctermbg=0      ctermfg=4      cterm=none
hi FoldColumn   ctermbg=0      ctermfg=4      cterm=none
hi DiffAdd      ctermbg=none   ctermfg=2      cterm=none
hi DiffDelete   ctermbg=none   ctermfg=1      cterm=none
hi DiffChange   ctermbg=none   ctermfg=3      cterm=none
hi DiffText     ctermbg=none   ctermfg=7      cterm=none
hi diffAdded    ctermbg=none   ctermfg=2      cterm=none
hi diffRemoved  ctermbg=none   ctermfg=1      cterm=none
hi diffSubname  ctermbg=none   ctermfg=3      cterm=none
" }}}

" language syntax {{{
hi Comment      ctermbg=none   ctermfg=8      cterm=none
hi Constant     ctermbg=none   ctermfg=5      cterm=none
hi String       ctermbg=none   ctermfg=6      cterm=none
hi Character    ctermbg=none   ctermfg=1      cterm=none
hi Number       ctermbg=none   ctermfg=5      cterm=none
hi Boolean      ctermbg=none   ctermfg=11     cterm=none
hi Float        ctermbg=none   ctermfg=4      cterm=none
hi Identifier   ctermbg=none   ctermfg=15     cterm=none
hi Function     ctermbg=none   ctermfg=3      cterm=none
hi Conditional  ctermbg=none   ctermfg=4      cterm=none
hi Repeat       ctermbg=none   ctermfg=4      cterm=none
hi Label        ctermbg=none   ctermfg=4      cterm=none
hi Operator     ctermbg=none   ctermfg=none   cterm=none
hi Keyword      ctermbg=none   ctermfg=4      cterm=none
hi Exception    ctermbg=none   ctermfg=1      cterm=none
hi Include      ctermbg=none   ctermfg=2      cterm=none
hi Define       ctermbg=none   ctermfg=2      cterm=none
hi Macro        ctermbg=none   ctermfg=3      cterm=none
hi PreCondit    ctermbg=none   ctermfg=3      cterm=none
hi Type         ctermbg=none   ctermfg=4      cterm=none
hi StorageClass ctermbg=none   ctermfg=15     cterm=none
hi PreProc      ctermbg=none   ctermfg=5      cterm=none
hi Structure    ctermbg=none   ctermfg=5      cterm=none
hi Special      ctermbg=none   ctermfg=5      cterm=none
hi SpecialChar  ctermbg=none   ctermfg=5      cterm=none
hi SpecialKey   ctermbg=none   ctermfg=5      cterm=none
hi NonText      ctermbg=none   ctermfg=8      cterm=none
hi Delimiter    ctermbg=none   ctermfg=none   cterm=none
hi Underliend   ctermbg=none   ctermfg=1      cterm=underline
hi Ignore       ctermbg=none   ctermfg=1      cterm=none
hi Error        ctermbg=none   ctermfg=1      cterm=bold
hi Todo         ctermbg=none   ctermfg=3      cterm=bold
hi Statement    ctermbg=none   ctermfg=4      cterm=bold
hi Include      ctermbg=none   ctermfg=5      cterm=none
" }}}

" c/cpp {{{
hi cBlock                 ctermbg=none   ctermfg=none   cterm=none
" }}}

" sh {{{
hi shStatement            ctermbg=none   ctermfg=4      cterm=none
hi shFunction             ctermbg=none   ctermfg=7      cterm=none
hi shOperator             ctermbg=none   ctermfg=7      cterm=none
hi shQuote                ctermbg=none   ctermfg=6      cterm=none
hi shFunctionKey          ctermbg=none   ctermfg=3      cterm=none
hi shOption               ctermbg=none   ctermfg=2      cterm=none
" }}}

" vim syntx {{{
hi vimHiGroup             ctermbg=none   ctermfg=6      cterm=none
" }}}

" markdown {{{
hi htmlItalic             ctermbg=none   ctermfg=none   cterm=italic
hi htmlBold               ctermbg=none   ctermfg=7      cterm=bold
hi markdownLinkText       ctermbg=none   ctermfg=7      cterm=underline
hi Title                  ctermbg=none   ctermfg=4      cterm=none
hi Delimiter              ctermbg=none   ctermfg=none   cterm=none
hi markdownCode           ctermbg=none   ctermfg=5      cterm=none
hi markdownBlockquote     ctermbg=none   ctermfg=3      cterm=none
hi markdownCodeDelimiter  ctermbg=none   ctermfg=5      cterm=none
" }}}

" linting {{{
hi CocWarningSign         ctermbg=none   ctermfg=3      cterm=none
hi ALEErrorSign           ctermbg=none   ctermfg=1      cterm=none
hi CocErrorHighlight      ctermbg=none   ctermfg=1      cterm=underline
hi CocWarningHighlight    ctermbg=none   ctermfg=3      cterm=underline
" }}}

" git {{{
hi GitGutterChange        ctermbg=none   ctermfg=3      cterm=bold
hi GitGutterAdd           ctermbg=none   ctermfg=2      cterm=bold
hi GitGutterDelete        ctermbg=none   ctermfg=1      cterm=bold
hi GitGutterChangeDelete  ctermbg=none   ctermfg=5      cterm=bold
" }}}

" vim wiki {{{
hi VimwikiHeader1         ctermfg=1
hi VimwikiHeader2         ctermfg=2
hi VimwikiHeader3         ctermfg=3
hi VimwikiHeader4         ctermfg=4
hi VimwikiHeader5         ctermfg=5
hi VimwikiHeader6         ctermfg=6
" }}}
" }}}

" statusline {{{
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

" coc {{{
function! CocWarning()
	let info = get(b:, 'coc_diagnostic_info', {})
	if empty(info) | return '' | endif
		let msgs = []
	if get(info, 'warning', 0)
		call add(msgs, 'W' . info['warning'])
	endif
	return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

function! CocError()
	let info = get(b:, 'coc_diagnostic_info', {})
	if empty(info) | return '' | endif
	let msgs = []
	if get(info, 'error', 0)
		call add(msgs, 'E' . info['error'])
	endif
	return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction
" }}}

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
set statusline+=%#MyStatuslineSeparator#░▒▓█%#Reset#

" git branch
" https://github.com/tpope/vim-fugitive - help fugitive: statusline:
" Use FugitiveHead() to return the name of the current branch. If the current
" HEAD is detached, FugitiveHead() will return the empty string
if exists('*FugitiveHead')
    let branch = FugitiveHead()
    if !empty(branch)
		set statusline+=%#MyStatuslineSeparator#▒░
		set statusline+=%{FugitiveHead()}
		set statusline+=%#MyStatuslineSeparator#░▒▓
    endif
endif
" output:
" error detected while processing /home/jan/.config/nvim/colors/iceberg.vim:
" line  281:
" E117: Unknown function: FugitiveHead
" E15: Invalid expression: FugitiveHead() != ''
" E117: Unknown function: FugitiveHead
" E15: Invalid expression: FugitiveHead() != ''


" CoC vim
set statusline+=%#MyStatuslineWarning#%{CocWarning()}
set statusline+=%#MyStatuslineError#%{CocError()}

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

hi MyStatuslineError        ctermbg=none   ctermfg=1      cterm=none
hi MyStatuslineWarning      ctermbg=none   ctermfg=3      cterm=none

hi MyStatuslineModified     ctermbg=none   ctermfg=0      cterm=none

hi MyStatuslineLineCol      ctermbg=0      ctermfg=3      cterm=none
hi MyStatuslineLinePerc     ctermbg=0      ctermfg=2      cterm=none

hi MyStatuslineFiletype     ctermbg=0      ctermfg=5      cterm=italic

hi Reset                    ctermbg=none   ctermfg=none   cterm=none
hi MyStatuslineSeparator    ctermbg=none   ctermfg=0      cterm=reverse
" }}}
" }}}

" vim: fdm=marker
