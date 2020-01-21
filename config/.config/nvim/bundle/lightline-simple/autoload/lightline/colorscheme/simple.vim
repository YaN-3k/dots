" Color Scheme  [ '#rrggbb', Xresources number]
let s:black =   [ '#181b21', 0 ]
let s:red =     [ '#cf5252', 1 ]
let s:green =   [ '#92ad4a', 2 ]
let s:yellow =  [ '#c9895b', 3 ]
let s:blue =    [ '#6f97b8', 4 ]
let s:magenta = [ '#ab6ba6', 5 ]
let s:cyan =    [ '#6fa69f', 6 ]
let s:white =   [ '#cccccc', 7 ]
let s:darkgrey =[ '#22262e', 8 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

" Airline have something like boxes, where you put plugins. So you have to
" change colors for all boxes individually. If you don't want to, you don't have
" to set different colors for different Vim modes, you can just comment them out.
"
" Syntax:
" let s:p.mode.position    [[ s:foreground, s:background ], [ s:foreground, s:background ]]

" Normal
let s:p.normal.left =      [[ s:blue, s:darkgrey ], [ s:blue, s:black ], [ s:blue, s:black ]]
let s:p.normal.middle =    [[ s:blue, s:black ],    [ s:blue, s:black ], [ s:blue, s:black ]]
let s:p.normal.right =     [[ s:blue, s:darkgrey ], [ s:blue, s:black ], [ s:blue, s:black ]]
let s:p.normal.error =     [[ s:blue, s:darkgrey ]]
let s:p.normal.warning =   [[ s:black, s:yellow ]]

" Inactive
let s:p.inactive.left =    [[ s:blue, s:darkgrey ], [ s:blue, s:black ], [ s:blue, s:black ]]
let s:p.inactive.middle =  [[ s:blue, s:black ], [ s:blue, s:black ], [ s:blue, s:black ]]
let s:p.inactive.right =   [[ s:blue, s:darkgrey ], [ s:blue, s:black ], [ s:blue, s:black ]]

" Insert
let s:p.insert.left =      [[ s:yellow, s:darkgrey ], [ s:blue, s:black ], [ s:blue, s:black ]]
let s:p.insert.middle =    [[ s:blue, s:black ],    [ s:blue, s:black ], [ s:blue, s:black ]]
let s:p.insert.right =     [[ s:blue, s:darkgrey ], [ s:blue, s:black ], [ s:blue, s:black ]]

" Replace
let s:p.replace.left =     [[ s:red, s:darkgrey ], [ s:blue, s:black ], [ s:blue, s:black ]]
let s:p.replace.middle =   [[ s:blue, s:black ],    [ s:blue, s:black ], [ s:blue, s:black ]]
let s:p.replace.right =    [[ s:blue, s:darkgrey ], [ s:blue, s:black ], [ s:blue, s:black ]]

" Visual
let s:p.visual.left =      [[ s:green, s:darkgrey ], [ s:blue, s:black ], [ s:blue, s:black ]]
let s:p.visual.middle =    [[ s:blue, s:black ],    [ s:blue, s:black ], [ s:blue, s:black ]]
let s:p.visual.right =     [[ s:blue, s:darkgrey ], [ s:blue, s:black ], [ s:blue, s:black ]]

" Tabs
let s:p.tabline.left =     [[ s:blue, s:black ]]
let s:p.tabline.tabsel =   [[ s:blue, s:darkgrey ]]
let s:p.tabline.middle =   [[ s:blue, s:black ]]
let s:p.tabline.right =    [[ s:blue, s:black ]]


let g:lightline#colorscheme#simple#palette = lightline#colorscheme#flatten(s:p)
