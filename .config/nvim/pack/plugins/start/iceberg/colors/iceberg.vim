" o┏━┓┳━┓┳━┓┳━┓┳━┓┏━┓
" ┃┃  ┣━ ┃━┃┣━ ┃┳┛┃ ┳
" ┇┗━┛┻━┛┇━┛┻━┛┇┗┛┇━┛

" setup
hi clear
syntax reset
set background=dark
let g:colors_name='iceberg'

" palette
let s:colors = {
	\ -1: 'NONE',
	\ 0:  '#22262e',
	\ 1:  '#e27878',
	\ 2:  '#b4be82',
	\ 3:  '#e2a478',
	\ 4:  '#84a0c6',
	\ 5:  '#a093c7',
	\ 6:  '#89b8c2',
	\ 7:  '#c6c8d1',
	\ 8:  '#6b7089',
	\ 9:  '#e98989',
	\ 10: '#c0ca8e',
	\ 11: '#e9b189',
	\ 12: '#91acd1',
	\ 13: '#ada0d3',
	\ 14: '#95c4ce',
	\ 15: '#d2d4de',
	\ 16: '#161821'
	\ }

function! s:hl(scope, bg, fg, ...)
	exec "hi ".a:scope
	\ "ctermbg=".(a:bg < 0 || a:bg > 15 ? 'NONE' : a:bg)
	\ "ctermfg=".(a:fg < 0 || a:fg > 15 ? 'NONE' : a:fg)
	\ "cterm=".(a:0 > 0 ? a:1 : 'NONE')
	\ "gui=".(a:0 > 0 ? a:1 : 'NONE')
	\ "guibg=".s:colors[a:bg]
	\ "guifg=".s:colors[a:fg]
endfunction

let g:terminal_ansi_colors = []
for i in range(16)
	call add(g:terminal_ansi_colors, s:colors[i])
	exec 'let g:terminal_color_'.i '= s:colors['.i.']'
endfor

" editor settings
call s:hl("Normal",        16,  7)
call s:hl("Cursor",         7, 16)
call s:hl("CursorLine",     0, -1)
call s:hl("LineNr",        -1,  8)
call s:hl("CursorLineNr",  -1, 15, 'bold')

" number collumn
call s:hl("CursorColumn",   0, -1)
call s:hl("FoldedColumn",  -1, -1)
call s:hl("FoldColumn",    -1,  8)
call s:hl("SignColumn",    -1,  7)
call s:hl("Folded",         0,  4)

" window / tab delimeters
call s:hl("VertSplit",     -1,  0)
call s:hl("ColorColumn",    0, -1)
call s:hl("TabLine",       -1, -1)
call s:hl("TabLineFill",   -1, -1)
call s:hl("TabLineSel",     0,  4, 'bold')

" file navigation / searching
call s:hl("Directory",     -1,  4)
call s:hl("Search",        -1, -1, 'reverse')
call s:hl("IncSearch",     -1, -1, 'reverse')

" prompt / status
call s:hl("StatusLine",    -1,  7)
call s:hl("StatusLineNC",  -1,  8)
call s:hl("WildMenu",       0, 12)
call s:hl("Title",         -1,  3, 'bold')
call s:hl("Question",      -1, 12)
call s:hl("MoreMsg",       -1,  4)
call s:hl("ModeMsg",       -1,  8, 'bold')

" visual aid
call s:hl("MatchParen",     4,  0)
call s:hl("Visual",         0, -1)
call s:hl("VisualNOS",      0, -1)
call s:hl("NonText",       -1,  8)

call s:hl("Todo",          -1,  3, 'bold')
call s:hl("Underlined",    -1, 12, 'underline')
call s:hl("Error",         -1,  1)
call s:hl("ErrorMsg",      -1,  1)
call s:hl("WarningMsg",    -1, 11)
call s:hl("Ignore",        -1,  1)
call s:hl("SpecialKey",    -1,  5)
call s:hl("Whitespace",    -1,  8)

" variable types
call s:hl("Constant",      -1, -1)
call s:hl("String",        -1,  6)
call s:hl("Character",     -1,  3)
call s:hl("Number",        -1,  5)
call s:hl("Boolean",       -1, 11)
call s:hl("Float",         -1,  5)

call s:hl("Identifier",    -1,  7)
call s:hl("Function",      -1, -1)

" language constructs
call s:hl("Comment",       -1,  8)
call s:hl("Statement",     -1,  4)
call s:hl("Conditional",   -1,  4)
call s:hl("Repeat",        -1,  4)
call s:hl("Label",         -1,  4)
call s:hl("Operator",      -1,  4)
call s:hl("Keyword",       -1,  4)
call s:hl("Exception",     -1,  1)

call s:hl("Special",       -1,  7)
call s:hl("SpecialChar",   -1,  5)
call s:hl("Tag",           -1,  4)
call s:hl("Delimiter",     -1, -1)
call s:hl("SpecialComment",-1,  5)
call s:hl("Debug",         -1,  5)

" c groups
call s:hl("PreProc",       -1,  5)
call s:hl("Include",       -1,  5)
call s:hl("Define",        -1,  3)
call s:hl("Macro",         -1,  3)
call s:hl("PreCondit",     -1,  3)

call s:hl("Type",          -1,  4)
call s:hl("StorageClass",  -1, 15)
call s:hl("Structure",     -1,  5)
call s:hl("Typedef",       -1,  5)

" diff
call s:hl("DiffAdd",       -1,  2)
call s:hl("DiffDelete",    -1,  1)
call s:hl("DiffChange",    -1,  3)
call s:hl("DiffText",      -1,  7)
hi! link diffSubname       DiffChange
hi! link diffAdded         DiffAdd
hi! link diffRemoved       DiffDelete

" completion menu
call s:hl("Pmenu",         -1, 15)
call s:hl("PmenuSel",       0, 12)
call s:hl("PmenuSbar",     -1, -1)
call s:hl("PmenuThumb",     0,  0)

" spelling
call s:hl("SpellBad",      -1,  1, 'underline')
call s:hl("SpellCap",      -1,  2, 'underline')
call s:hl("SpellLocal",    -1,  3, 'underline')
call s:hl("SpellRare",     -1,  3, 'underline')

" netrw
call s:hl("netrwClassify", -1,  7)

" sh
call s:hl("shStatement",   -1, -1)
call s:hl("shCtrlSeq",     -1,  5)
call s:hl("shFunction",    -1, -1)
call s:hl("shOption",      -1,  2)
call s:hl("shQuote",       -1,  4)
call s:hl("shDerefSimple", -1,  5)
call s:hl("shFunctionKey", -1,  3)
call s:hl("shVariable",    -1, -1)

" html
call s:hl("htmlTag",       -1,  8)
call s:hl("htmlEndTag",    -1,  8)
call s:hl("htmlArg",       -1, 13)

" statusline
call s:hl("Dark",          -1,  8)
call s:hl("Accent",        -1,  4)
