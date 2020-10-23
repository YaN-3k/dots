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

function! s:hi(scope, bg, fg, ...)
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
call s:hi("Normal",        16,  7)
call s:hi("Cursor",         7, 16)
call s:hi("CursorLine",     0, -1)
call s:hi("LineNr",        -1,  8)
call s:hi("CursorLineNr",  -1, 15, 'bold')

" number collumn
call s:hi("CursorColumn",   0, -1)
call s:hi("FoldedColumn",  -1, -1)
call s:hi("FoldColumn",    -1,  8)
call s:hi("SignColumn",    -1,  7)
call s:hi("Folded",         0,  4)

" window / tab delimeters
call s:hi("VertSplit",     -1,  0)
call s:hi("ColorColumn",    0, -1)
call s:hi("TabLine",       -1, -1)
call s:hi("TabLineFill",   -1, -1)
call s:hi("TabLineSel",     0,  4, 'bold')

" file navigation / searching
call s:hi("Directory",     -1,  4)
call s:hi("Search",        -1, -1, 'reverse')
call s:hi("IncSearch",     -1, -1, 'reverse')

" prompt / status
call s:hi("StatusLine",    -1,  7)
call s:hi("StatusLineNC",  -1,  8)
call s:hi("WildMenu",       0, 12)
call s:hi("Title",         -1,  3, 'bold')
call s:hi("Question",      -1, 12)
call s:hi("MoreMsg",       -1,  4)
call s:hi("ModeMsg",       -1,  8, 'bold')

" visual aid
call s:hi("MatchParen",     4,  0)
call s:hi("Visual",         0, -1)
call s:hi("VisualNOS",      0, -1)
call s:hi("NonText",       -1,  8)

call s:hi("Todo",          -1,  3, 'bold')
call s:hi("Underlined",    -1, 12, 'underline')
call s:hi("Error",         -1,  1)
call s:hi("ErrorMsg",      -1,  1)
call s:hi("WarningMsg",    -1, 11)
call s:hi("Ignore",        -1,  1)
call s:hi("SpecialKey",    -1,  5)
call s:hi("Whitespace",    -1,  8)

" variable types
call s:hi("Constant",      -1,  4)
call s:hi("String",        -1,  6)
call s:hi("Character",     -1,  3)
call s:hi("Number",        -1,  5)
call s:hi("Boolean",       -1, 11)
call s:hi("Float",         -1,  5)

call s:hi("Identifier",    -1,  7)
call s:hi("Function",      -1, -1)

" language constructs
call s:hi("Comment",       -1,  8)
call s:hi("Statement",     -1,  4)
call s:hi("Conditional",   -1,  4)
call s:hi("Repeat",        -1,  4)
call s:hi("Label",         -1,  4)
call s:hi("Operator",      -1,  4)
call s:hi("Keyword",       -1,  4)
call s:hi("Exception",     -1,  1)

call s:hi("Special",       -1,  7)
call s:hi("SpecialChar",   -1,  5)
call s:hi("Tag",           -1,  4)
call s:hi("Delimiter",     -1, -1)
call s:hi("SpecialComment",-1,  5)
call s:hi("Debug",         -1,  5)

" c groups
call s:hi("PreProc",       -1,  5)
call s:hi("Include",       -1,  5)
call s:hi("Define",        -1,  3)
call s:hi("Macro",         -1,  3)
call s:hi("PreCondit",     -1,  3)

call s:hi("Type",          -1,  4)
call s:hi("StorageClass",  -1, 15)
call s:hi("Structure",     -1,  5)
call s:hi("Typedef",       -1,  5)

" diff
call s:hi("DiffAdd",       -1,  2)
call s:hi("DiffDelete",    -1,  1)
call s:hi("DiffChange",    -1,  3)
call s:hi("DiffText",      -1,  3)
hi! link diffSubname       DiffChange
hi! link diffAdded         DiffAdd
hi! link diffRemoved       DiffDelete

" completion menu
call s:hi("Pmenu",         -1, 15)
call s:hi("PmenuSel",       0, 12)
call s:hi("PmenuSbar",     -1, -1)
call s:hi("PmenuThumb",     0,  0)

" spelling
call s:hi("SpellBad",      -1,  1, 'underline')
call s:hi("SpellCap",      -1,  2, 'underline')
call s:hi("SpellLocal",    -1,  3, 'underline')
call s:hi("SpellRare",     -1,  3, 'underline')

" netrw
call s:hi("netrwClassify", -1,  7)

" sh
call s:hi("shStatement",   -1, -1)
call s:hi("shCtrlSeq",     -1,  5)
call s:hi("shFunction",    -1, -1)
call s:hi("shOption",      -1,  2)
call s:hi("shQuote",       -1,  4)
call s:hi("shDerefSimple", -1,  5)
call s:hi("shFunctionKey", -1,  3)
call s:hi("shVariable",    -1, -1)

" html
call s:hi("htmlTag",       -1,  8)
call s:hi("htmlEndTag",    -1,  8)
call s:hi("htmlArg",       -1, 13)

" statusline
call s:hi("Dark",          -1,  8)
call s:hi("Accent",        -1,  4)
