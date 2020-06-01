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
hi VimwikiHeader1    ctermbg=none   ctermfg=4   cterm=none
hi VimwikiHeader2    ctermbg=none   ctermfg=5   cterm=none
hi VimwikiHeader3    ctermbg=none   ctermfg=6   cterm=none
hi VimwikiHeader4    ctermbg=none   ctermfg=4   cterm=none
hi VimwikiHeader5    ctermbg=none   ctermfg=2   cterm=none
hi VimwikiHeader6    ctermbg=none   ctermfg=3   cterm=none
hi VimwikiPre        ctermbg=none   ctermfg=8   cterm=none
hi VimwikiWeblink1   ctermbg=none   ctermfg=4   cterm=underline
hi VimwikiImage      ctermbg=none   ctermfg=4   cterm=underline
" }}}

" vim: fdm=marker
