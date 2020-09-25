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

" palette {{{
let s:ice0  =  [0,  '#22262e']
let s:ice1  =  [1,  '#e27878']
let s:ice2  =  [2,  '#b4be82']
let s:ice3  =  [3,  '#e2a478']
let s:ice4  =  [4,  '#84a0c6']
let s:ice5  =  [5,  '#a093c7']
let s:ice6  =  [6,  '#89b8c2']
let s:ice7  =  [7,  '#c6c8d1']

let s:ice8  =  [8,  '#6b7089']
let s:ice9  =  [9,  '#e98989']
let s:ice10 =  [10, '#c0ca8e']
let s:ice11 =  [11, '#e9b189']
let s:ice12 =  [12, '#91acd1']
let s:ice13 =  [13, '#ada0d3']
let s:ice14 =  [14, '#95c4ce']
let s:ice15 =  [15, '#d2d4de']

let s:none  =  ["none", "none"]

function! s:HL(scope, bg, fg, attr)
  exec "hi ".a:scope
    \ "ctermbg=".a:bg[0]
    \ "ctermfg=".a:fg[0]
    \ "guibg=".a:bg[1]
    \ "guifg=".a:fg[1]
    \ "cterm=".a:attr
    \ "gui=".a:attr
endfunction
" }}}

" editor settings {{{
call s:HL("Normal",       s:none,  s:ice7,  "none")
call s:HL("Cursor",       s:none,  s:ice7,  "none")
call s:HL("CursorLine",   s:ice0,  s:none,  "none")
call s:HL("LineNr",       s:none,  s:ice8,  "none")
call s:HL("CursorLineNr", s:none,  s:ice15, "bold")
"}}}

" number collumn {{{
call s:HL("CursorColumn", s:ice0,  s:none,  "none")
call s:HL("FoldedColumn", s:none,  s:none,  "none")
call s:HL("FoldColumn",   s:none,  s:ice8,  "none")
call s:HL("SignColumn",   s:none,  s:ice7,  "none")
call s:HL("Folded",       s:ice0,  s:ice4,  "none")
" }}}

" window / tab delimeters {{{
call s:HL("VertSplit",    s:none,  s:ice0,  "none")
call s:HL("ColorColumn",  s:ice0,  s:none,  "none")
call s:HL("TabLine",      s:none,  s:none,  "none")
call s:HL("TabLineFill",  s:none,  s:none,  "none")
call s:HL("TabLineSel",   s:ice0,  s:ice4,  "bold")
" }}}

" file navigation / searching {{{
call s:HL("Directory",    s:none,   s:ice4,  "none")
call s:HL("Search",       s:none,   s:none,  "reverse")
call s:HL("IncSearch",    s:none,   s:none,  "reverse")
call s:HL("HighlightedyankRegion", s:ice0,  s:none,  "none")
" }}}

" prompt / status {{{
call s:HL("StatusLine",   s:none,   s:none,  "none")
call s:HL("StatusLineNC", s:none,   s:ice8,  "none")
call s:HL("WildMenu",     s:ice8,   s:ice0,  "none")
call s:HL("Title",        s:none,   s:ice3,  "bold")
call s:HL("Question",     s:none,   s:ice12, "none")
call s:HL("MoreMsg",      s:none,   s:ice4,  "none")
call s:HL("ModeMsg",      s:none,   s:ice8,  "bold")
" }}}

" visual aid {{{
call s:HL("MatchParen",   s:none,  s:ice4,  "underline")
call s:HL("Visual",       s:ice0,  s:none,  "none")
call s:HL("VisualNOS",    s:ice0,  s:none,  "none")
call s:HL("NonText",      s:none,  s:ice0,  "none")

call s:HL("Todo",         s:none,  s:ice3,  "bold")
call s:HL("Underlined",   s:none,  s:ice12, "underline")
call s:HL("Error",        s:none,  s:ice1,  "none")
call s:HL("ErrorMsg",     s:none,  s:ice1,  "none")
call s:HL("WarningMsg",   s:none,  s:ice11, "none")
call s:HL("Ignore",       s:none,  s:ice1,  "none")
call s:HL("SpecialKey",   s:none,  s:ice5,  "none")
call s:HL("Whitespace",   s:none,  s:ice8,  "none")
" }}}

" variable types {{{
call s:HL("Constant",     s:none,  s:none,  "none")
call s:HL("String",       s:none,  s:ice6,  "none")
call s:HL("Character",    s:none,  s:ice1,  "none")
call s:HL("Number",       s:none,  s:ice5,  "none")
call s:HL("Boolean",      s:none,  s:ice11, "none")
call s:HL("Float",        s:none,  s:ice5,  "none")

call s:HL("Identifier",   s:none,  s:ice7,  "none")
call s:HL("Function",     s:none,  s:ice3,  "none")
" }}}

" language constructs {{{
call s:HL("Comment",      s:none,  s:ice8,  "none")
call s:HL("Statement",    s:none,  s:ice4,  "none")
call s:HL("Conditional",  s:none,  s:ice4,  "none")
call s:HL("Repeat",       s:none,  s:ice4,  "none")
call s:HL("Label",        s:none,  s:ice4,  "none")
call s:HL("Operator",     s:none,  s:ice4,  "none")
call s:HL("Keyword",      s:none,  s:ice4,  "none")
call s:HL("Exception",    s:none,  s:ice1,  "none")

call s:HL("Special",      s:none,  s:ice7,  "none")
call s:HL("SpecialChar",  s:none,  s:ice5,  "none")
call s:HL("Tag",          s:none,  s:ice4,  "none")
call s:HL("Delimiter",    s:none,  s:none,  "none")
call s:HL("SpecialComment", s:none,  s:ice5,  "none")
call s:HL("Debug",        s:none,  s:ice5,  "none")
" }}}

" c {{{
call s:HL("PreProc",      s:none,  s:ice5,  "none")
call s:HL("Include",      s:none,  s:ice5,  "none")
call s:HL("Define",       s:none,  s:ice3,  "none")
call s:HL("Macro",        s:none,  s:ice3,  "none")
call s:HL("PreCondit",    s:none,  s:ice3,  "none")

call s:HL("Type",         s:none,  s:ice4,  "none")
call s:HL("StorageClass", s:none,  s:ice15, "none")
call s:HL("Structure",    s:none,  s:ice5,  "none")
call s:HL("Typedef",      s:none,  s:ice5,  "none")
" }}}

" diff {{{
call s:HL("DiffAdd",      s:none,  s:ice2,  "none")
call s:HL("DiffDelete",   s:none,  s:ice1,  "none")
call s:HL("DiffChange",   s:none,  s:ice3,  "none")
call s:HL("DiffText",     s:none,  s:ice7,  "none")
hi! link diffSubname      DiffChange
hi! link diffAdded        DiffAdd
hi! link diffRemoved      DiffDelete
" }}}

" completion menu {{{
call s:HL("Pmenu",        s:none,  s:ice15,  "none")
call s:HL("PmenuSel",     s:ice0,  s:ice12,  "none")
call s:HL("PmenuSbar",    s:none,  s:none,   "none")
call s:HL("PmenuThumb",   s:ice0,  s:ice0,   "none")
" }}}

" quick scope {{{
call s:HL("QuickScopePrimary",   s:none,  s:ice3,  "underline")
call s:HL("QuickScopeSecondary", s:none,  s:ice4,  "underline")
" }}}

" spelling {{{
call s:HL("SpellBad",     s:none,  s:ice1,  "underline")
call s:HL("SpellCap",     s:none,  s:ice2,  "underline")
call s:HL("SpellLocal",   s:none,  s:ice3,  "underline")
call s:HL("SpellRare",    s:none,  s:ice3,  "underline")
" }}}

" netrw {{{
call s:HL("netrwClassify", s:none,  s:ice7,  "none")
" }}}

" statusline {{{
call s:HL("NormalMode",   s:ice0,  s:ice4,  "none")
call s:HL("InsertMode",   s:ice0,  s:ice3,  "none")
call s:HL("ReplaceMode",  s:ice0,  s:ice1,  "none")
call s:HL("VisualMode",   s:ice0,  s:ice5,  "none")
call s:HL("CmdMode",      s:ice0,  s:ice2,  "none")
call s:HL("TermMode",     s:ice0,  s:ice1,  "none")

call s:HL("Reset",        s:none,  s:ice0,  "none")
call s:HL("Modified",     s:none,  s:ice8,  "none")
call s:HL("Separator",    s:none,  s:ice0,  "none")
call s:HL("Git",          s:ice0,  s:ice7,  "none")
call s:HL("LineCol",      s:ice0,  s:ice3,  "none")
call s:HL("LinePerc",     s:ice0,  s:ice2,  "none")
call s:HL("Filetype",     s:ice0,  s:ice5,  "italic")

call s:HL("MinSeparator", s:none,  s:ice8,  "none")
call s:HL("MinModified",  s:none,  s:ice8,  "none")
call s:HL("MinMode",      s:none,  s:ice8,  "none")
call s:HL("MinLine",      s:none,  s:ice4,  "none")
call s:HL("MinFilename",  s:none,  s:ice7,  "none")
call s:HL("MinFiletype",  s:none,  s:ice8,  "none")
" }}}

" linting {{{
call s:HL("CocErrorSign",        s:none,  s:ice1,  "none")
call s:HL("CocErrorHighlight",   s:none,  s:none,  "underline")
call s:HL("CocWarningSign",      s:none,  s:ice3,  "none")
call s:HL("CocWarningHighlight", s:none,  s:none,  "underline")
" }}}

" startify {{{
hi! link StartifyBracket Comment
hi! link StartifyFile    Identifier
hi! link StartifyFooter  Title
hi! link StartifyHeader  Title
hi! link StartifyNumber  Special
hi! link StartifyPath    Comment
hi! link StartifySection Statement
hi! link StartifySlash   Comment
hi! link StartifySpecial Normal
" }}}

" which key {{{
highlight default link WhichKey          Statement
highlight default link WhichKeySeperator Comment
highlight default link WhichKeyGroup     Comment
highlight default link WhichKeyDesc      Function
" }}}

" vim wiki {{{
call s:HL("VimwikiHeader1", s:none,  s:ice3,   "bold")
call s:HL("VimwikiHeader2", s:none,  s:ice2,   "bold")
call s:HL("VimwikiHeader3", s:none,  s:ice5,   "bold")
call s:HL("VimwikiHeader4", s:none,  s:ice14,  "bold")
call s:HL("VimwikiHeader5", s:none,  s:ice4,   "bold")
call s:HL("VimwikiHeader6", s:none,  s:ice8,   "bold")
call s:HL("VimwikiPre",     s:none,  s:ice8,   "italic")
" }}}

" sh {{{
call s:HL("shStatement",   s:none,  s:none,  "none")
call s:HL("shCtrlSeq",     s:none,  s:ice5,  "none")
call s:HL("shFunction",    s:none,  s:none,  "none")
call s:HL("shOption",      s:none,  s:ice2,  "none")
call s:HL("shQuote",       s:none,  s:ice4,  "none")
call s:HL("shDerefSimple", s:none,  s:ice5,  "none")
call s:HL("shFunctionKey", s:none,  s:ice3,  "none")
call s:HL("shVariable",    s:none,  s:none,  "none")
" }}}

" html {{{
call s:HL("htmlTag",      s:none,  s:ice8,  "none")
call s:HL("htmlEndTag",   s:none,  s:ice8,  "none")
call s:HL("htmlArg",      s:none,  s:ice13, "none")
" }}}

" python {{{
call s:HL("pythonFunctionCall", s:none,  s:none,  "none")
call s:HL("pythonImport",       s:none,  s:ice4,  "none")
" }}}
