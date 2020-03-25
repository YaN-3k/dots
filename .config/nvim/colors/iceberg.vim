" o┏━┓┳━┓┳━┓┳━┓┳━┓┏━┓
" ┃┃  ┣━ ┃━┃┣━ ┃┳┛┃ ┳
" ┇┗━┛┻━┛┇━┛┻━┛┇┗┛┇━┛

set background=dark
hi clear
if exists('syntax_on')
    syntax reset
endif

let g:colors_name='iceberg'

set numberwidth=1

hi Normal       ctermbg=NONE   ctermfg=15     cterm=NONE
hi Cursor       ctermbg=NONE   ctermfg=15     cterm=NONE
hi Directory    ctermbg=NONE   ctermfg=4      cterm=NONE
hi ErrorMsg     ctermbg=NONE   ctermfg=1      cterm=NONE
hi VertSplit    ctermbg=NONE   ctermfg=0      cterm=NONE
hi LineNr       ctermbg=NONE   ctermfg=8      cterm=NONE
hi SignColumn   ctermbg=NONE   ctermfg=7      cterm=NONE
hi NonText      ctermbg=NONE   ctermfg=0      cterm=NONE
hi Pmenu        ctermbg=NONE   ctermfg=15     cterm=NONE
hi PmenuSel     ctermbg=0      ctermfg=4      cterm=NONE
hi PmenuSbar    ctermbg=NONE   ctermfg=NONE   cterm=NONE
hi PmenuThumb   ctermbg=0      ctermfg=0      cterm=NONE
hi Search       ctermbg=NONE   ctermfg=NONE   cterm=reverse
hi SpellBad     ctermbg=NONE   ctermfg=1      cterm=underline
hi SpellCap     ctermbg=NONE   ctermfg=2      cterm=underline
hi SpellLocal   ctermbg=NONE   ctermfg=3      cterm=underline
hi SpellRare    ctermbg=NONE   ctermfg=3      cterm=underline
hi StatusLine   ctermbg=0      ctermfg=15     cterm=NONE
hi StatusLineNC ctermbg=0      ctermfg=15     cterm=NONE
hi TabLine      ctermbg=NONE   ctermfg=NONE   cterm=NONE
hi TabLineSel   ctermbg=0      ctermfg=4      cterm=bold
hi TabLineFill  ctermbg=NONE   ctermfg=NONE   cterm=NONE
hi Title        ctermbg=NONE   ctermfg=15     cterm=NONE
hi Visual       ctermbg=0      ctermfg=NONE   cterm=NONE
hi WildMenu     ctermbg=NONE   ctermfg=4      cterm=NONE
hi WarningMsg   ctermbg=NONE   ctermfg=11     cterm=NONE
hi EndOfBuffer  ctermbg=NONE   ctermfg=0      cterm=NONE
hi CursorLine   ctermbg=0      ctermfg=NONE   cterm=NONE
hi CursorLineNr ctermbg=NONE   ctermfg=15     cterm=bold
hi CursorColumn ctermbg=0      ctermfg=NONE   cterm=NONE
hi MatchParen   ctermbg=NONE   ctermfg=4      cterm=underline
hi ModeMsg      ctermbg=NONE   ctermfg=8      cterm=NONE
hi NormalNC     ctermbg=NONE   ctermfg=15     cterm=NONE
hi Folded       ctermbg=0      ctermfg=4      cterm=NONE
hi FoldColumn   ctermbg=0      ctermfg=4      cterm=NONE
hi DiffAdd      ctermbg=NONE   ctermfg=2      cterm=NONE
hi DiffDelete   ctermbg=NONE   ctermfg=1      cterm=NONE
hi DiffChange   ctermbg=NONE   ctermfg=3      cterm=NONE
hi DiffText     ctermbg=NONE   ctermfg=7      cterm=NONE
hi diffAdded    ctermbg=NONE   ctermfg=2      cterm=NONE
hi diffRemoved  ctermbg=NONE   ctermfg=1      cterm=NONE
hi diffSubname  ctermbg=NONE   ctermfg=3      cterm=NONE

" language syntax
hi Comment      ctermbg=NONE   ctermfg=8      cterm=NONE
hi Constant     ctermbg=NONE   ctermfg=5      cterm=NONE
hi String       ctermbg=NONE   ctermfg=6      cterm=NONE
hi Character    ctermbg=NONE   ctermfg=1      cterm=NONE
hi Number       ctermbg=NONE   ctermfg=5      cterm=NONE
hi Boolean      ctermbg=NONE   ctermfg=11     cterm=NONE
hi Float        ctermbg=NONE   ctermfg=4      cterm=NONE
hi Identifier   ctermbg=NONE   ctermfg=15     cterm=NONE
hi Function     ctermbg=NONE   ctermfg=3      cterm=NONE
hi Conditional  ctermbg=NONE   ctermfg=4      cterm=NONE
hi Repeat       ctermbg=NONE   ctermfg=4      cterm=NONE
hi Label        ctermbg=NONE   ctermfg=4      cterm=NONE
hi Operator     ctermbg=NONE   ctermfg=NONE   cterm=NONE
hi Keyword      ctermbg=NONE   ctermfg=4      cterm=NONE
hi Exception    ctermbg=NONE   ctermfg=1      cterm=NONE
hi Include      ctermbg=NONE   ctermfg=2      cterm=NONE
hi Define       ctermbg=NONE   ctermfg=2      cterm=NONE
hi Macro        ctermbg=NONE   ctermfg=3      cterm=NONE
hi PreCondit    ctermbg=NONE   ctermfg=3      cterm=NONE
hi Type         ctermbg=NONE   ctermfg=4      cterm=NONE
hi StorageClass ctermbg=NONE   ctermfg=15     cterm=NONE
hi PreProc      ctermbg=NONE   ctermfg=5      cterm=NONE
hi Structure    ctermbg=NONE   ctermfg=5      cterm=NONE
hi Special      ctermbg=NONE   ctermfg=5      cterm=NONE
hi SpecialChar  ctermbg=NONE   ctermfg=5      cterm=NONE
hi SpecialKey   ctermbg=NONE   ctermfg=5      cterm=NONE
hi NonText      ctermbg=NONE   ctermfg=8      cterm=NONE
hi Delimiter    ctermbg=NONE   ctermfg=NONE   cterm=NONE
hi Underliend   ctermbg=NONE   ctermfg=1      cterm=underline
hi Ignore       ctermbg=NONE   ctermfg=1      cterm=NONE
hi Error        ctermbg=NONE   ctermfg=1      cterm=bold
hi Todo         ctermbg=NONE   ctermfg=3      cterm=bold
hi Statement    ctermbg=NONE   ctermfg=4      cterm=bold
hi Include      ctermbg=NONE   ctermfg=5      cterm=NONE

" c/cpp
hi cBlock       ctermbg=NONE ctermfg=NONE cterm=NONE

" sh
hi shStatement  ctermbg=NONE   ctermfg=4      cterm=NONE
hi shFunction   ctermbg=NONE   ctermfg=7      cterm=NONE
hi shOperator   ctermbg=NONE   ctermfg=7      cterm=NONE
hi shQuote      ctermbg=NONE   ctermfg=6      cterm=NONE
hi shFunctionKey ctermbg=NONE   ctermfg=3     cterm=NONE
hi shOption     ctermbg=NONE   ctermfg=2

" vim syntx
hi vimHiGroup  ctermbg=NONE   ctermfg=6       cterm=NONE

" Markdown
hi htmlItalic             ctermbg=NONE   ctermfg=NONE    cterm=italic
hi htmlBold               ctermbg=NONE   ctermfg=7       cterm=bold
hi markdownLinkText       ctermbg=NONE   ctermfg=7       cterm=underline
hi Title                  ctermbg=NONE   ctermfg=4       cterm=NONE
hi Delimiter              ctermbg=NONE   ctermfg=NONE    cterm=NONE
hi markdownCode           ctermbg=NONE   ctermfg=5       cterm=NONE
hi markdownBlockquote     ctermbg=NONE   ctermfg=3       cterm=NONE
hi markdownCodeDelimiter  ctermbg=NONE   ctermfg=5       cterm=NONE

" ALE - Asynchronous Lint Engine
hi ALEWarning       ctermbg=NONE  ctermfg=3   cterm=underline
hi ALEError         ctermbg=NONE  ctermfg=1   cterm=underline
hi ALEWarningSign   ctermbg=NONE  ctermfg=3   cterm=bold
hi ALEErrorSign     ctermbg=NONE  ctermfg=1   cterm=bold

" Git gutter
hi GitGutterChange        ctermbg=NONE   ctermfg=3       cterm=bold
hi GitGutterAdd           ctermbg=NONE   ctermfg=2       cterm=bold
hi GitGutterDelete        ctermbg=NONE   ctermfg=1       cterm=bold
hi GitGutterChangeDelete  ctermbg=NONE   ctermfg=5 	     cterm=bold

" Statusline
source $HOME/.config/nvim/colors/statusline.vim
