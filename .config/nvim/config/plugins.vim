" ┳━┓┳  ┳ ┓┏━┓o┏┓┓┓━┓
" ┃━┛┃  ┃ ┃┃ ┳┃┃┃┃┗━┓
" ┇  ┇━┛┇━┛┇━┛┇┇┗┛━━┛

" setup vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	echo 'Downloading junegunn/vim-plug to manage plugins...'
	silent call system('mkdir -p ~/.config/nvim/{autoload,bundle,cache/{cache,undo,backups,swaps}}')
	silent call system('pip3 install --user pynvim msgpack')
	silent call system('curl -flo ~/.config/nvim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
	execute 'source  ~/.config/nvim/autoload/plug.vim'
	augroup plugsetup
		au!
		autocmd VimEnter * PlugInstall
	augroup end
endif

call plug#begin('~/.config/nvim/bundle')

" programming
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-clangx'
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'deoplete-plugins/deoplete-zsh'
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
Plug 'sebastianmarkow/deoplete-rust'

Plug 'dense-analysis/ale'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'sheerun/vim-polyglot'
Plug 'mattn/emmet-vim'

" stylize
Plug 'lilydjwg/colorizer'
"Plug 'scrooloose/nerdtree'
Plug 'isa/vim-matchit'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Goyo' }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

" features
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vimwiki/vimwiki'
Plug 'kien/ctrlp.vim'
Plug 'matze/vim-move'
Plug 'simeji/winresizer'
"Plug '~/.zgen/junegunn/fzf-master'
"Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" ALE - Asynchronous Lint Engine
let g:ale_linters = {
\   'c': ['gcc'],
\   'cpp': ['g++'],
\   'javascript': ['eslint'],
\   'php': ['php'],
\   'python': ['pyls', 'flake8'],
\   'sh': ['shellcheck'],
\   'zsh': ['shell'],
\   'rust': ['cargo'],
\}

let g:ale_fixers = {
\   '*': ['trim_whitespace', 'remove_trailing_lines'],
\   'c': ['clang-format'],
\   'cpp': ['clang-format'],
\   'rust': ['rustfmt'],
\   'css': ['prettier'],
\   'go': ['gofmt'],
\   'html': ['prettier'],
\   'javascript': ['prettier'],
\   'json': ['prettier'],
\   'php': ['prettier'],
\   'python': ['black'],
\   'sh': ['shfmt'],
\   'zsh': ['shfmt'],
\   'scss': ['prettier'],
\   'yaml': ['prettier'],
\}

" linting
let g:ale_completion_enabled = 0
let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 1
let g:ale_open_list = 0
let g:ale_lint_on_text_changed = 'never'

map <Leader>af :ALEFix<cr>
map <Leader>an :ALENext<cr>
map <Leader>aN :ALEPrevious<cr>
map <Leader>ad :ALEDetail<cr>
map <Leader>ag :ALEGoToDefinitionInSplit<cr>
map <Leader>aG :ALEGoToDefinition<cr>

" fzf colors
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Statement'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Function'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Visual'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'ErrorMsg'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" default fzf layout
let g:fzf_layout = { 'down': '~50%' }

" distraction free writing mode
let g:limelight_conceal_ctermfg = 8
function! s:goyo_enter()
	Limelight
	noremap ZZ :Goyo\|x!<cr>
	noremap ZQ :Goyo\|q!<cr>
	call deoplete#disable()
	silent !tmux set status off
	silent !tmux list-panes -F '\#F' | grep -q Z | tmux resize-pane -Z
	set noshowmode
	set noshowcmd
	set wrap
	set scrolloff=999
endfunction

function! s:goyo_leave()
	Limelight!
	unmap ZZ
	unmap ZQ
	silent !tmux set status on
	silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
	set showmode
	set showcmd
	set nowrap
	set scrolloff=0
endfunction

augroup goyoactions
	au!
	autocmd! User GoyoEnter nested call <SID>goyo_enter()
	autocmd! User GoyoLeave nested call <SID>goyo_leave()
augroup end

map <leader>w :Goyo<cr>

" Enable Goyo by default for mutt writting
augroup muttwrite
	au!
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<cr>
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<cr>
augroup end

" Ensure files are read as what I want:
map <leader>v :VimwikiIndex<CR>
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_list = [{'path': '~/dox/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
augroup vimwiki
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex
augroup end

" python paths, needed for virtualenvs
let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog = '/usr/bin/python2'

" syntax highlighting
let g:python_highlight_all = 1

" ignore whitspace
let g:better_whitespace_filetypes_blacklist=['<filetype1>', '<filetype2>', '<etc>',  'diff', 'gitcommit', 'unite', 'qf', 'help']

" gitgutter
let g:gitgutter_max_signs = 1500
let g:gitgutter_diff_args = '-w'

" custom symbols
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = ':'

" maping
map <Leader>gt :GitGutterToggle<cr>
nmap gn <Plug>(GitGutterNextHunk)
nmap gN <Plug>(GitGutterPrevHunk)
nmap gs <Plug>(GitGutterStageHunk)
nmap gu <Plug>(GitGutterUndoHunk)
nmap gp <Plug>(GitGutterPreviewHunk)

" resize split
let g:winresizer_horiz_resize = 1
let g:winresizer_vert_resize = 2

" Start screen
let g:ascii = [
	\ '    ████     ██                           ██            ',
	\ '   ░██░██   ░██                          ░░             ',
	\ '   ░██░░██  ░██  █████   ██████  ██    ██ ██ ██████████ ',
	\ '   ░██ ░░██ ░██ ██░░░██ ██░░░░██░██   ░██░██░░██░░██░░██',
	\ '   ░██  ░░██░██░███████░██   ░██░░██ ░██ ░██ ░██ ░██ ░██',
	\ '   ░██   ░░████░██░░░░ ░██   ░██ ░░████  ░██ ░██ ░██ ░██',
	\ '   ░██    ░░███░░██████░░██████   ░░██   ░██ ███ ░██ ░██',
	\ '   ░░      ░░░  ░░░░░░  ░░░░░░     ░░    ░░ ░░░  ░░  ░░ ',
	\]
let g:startify_custom_header = g:ascii

let g:startify_lists = [
	\ { 'type': 'bookmarks', 'header': ['   Dotfiles'] },
	\ ]

let g:startify_bookmarks = [
	\ { 'bs': '~/.config/bspwm/bspwmrc' },
	\ { 'sx': '~/.config/sxhkd/sxhkdrc' },
	\ { 'pp': '~/.config/polybar/config' },
	\ { 'al': '~/.config/alacritty/alacritty.yml' },
	\ { 'ds': '~/.config/dunst/dunstrc' },
	\ { 'nc': '~/.config/ncmpcpp/config' },
	\ { 'nb': '~/.config/ncmpcpp/bindings' },
	\ { 'bb': '~/.config/qutebrowser/config.py' },
	\ { 'mn': '~/.config/mutt/muttrc' },
	\ { 'za': '~/.config/zathura/zathurarc' },
	\ { 'pi': '~/.config/picom.conf' },
	\ { 'tm': '~/.tmux.conf' },
	\ { 'vv': '~/.config/nvim' },
	\ { 'vf': '~/.config/vifm/vifmrc' },
	\ { 'zz': '~/.config/zsh' },
	\ { 'sh': '~/.config/shell' },
	\ { 'zp': '~/.zprofile' },
	\ { 'bi': '~/.local/bin/' },
	\ { 'ra': '~/.config/ranger' },
	\ ]

" emmet settings
let g:user_emmet_mode='a'
let g:user_emmet_leader_key=','
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" completion with tab
inoremap <expr><silent><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><silent><S-tab> pumvisible() ? "\<c-p>" : "\<tab>"

"inoremap <tab> <c-n>
"inoremap <S-tab> <c-p>

" real tab
inoremap <A-tab> <tab>

" omnifuncs
augroup omnifuncs
	au!
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
	autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
augroup end

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1

call deoplete#custom#source('ultisnips', 'rank', 1000)

" ignore case
call deoplete#custom#option('smart_case', v:false)

" disable preview
set completeopt-=preview

" the delay for completion after input, measured in milliseconds
call deoplete#custom#option('auto_complete_delay', 100)

" enable zsh autocompletion in sh buffers
call deoplete#custom#source('zsh', 'filetypes', ['sh', 'zsh'])

" candidate list item number limit
call deoplete#custom#option('max_list', 30)

" the number of processes used for the deoplete parallel feature
call deoplete#custom#option('num_processes', 16)

" go - $ go get -u github.com/stamblerre/gocode
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'

" racer for rust code autocompletion
let g:deoplete#sources#rust#racer_binary = $CARGO_HOME.'/bin/racer'

" rust source code
let g:deoplete#sources#rust#rust_source_path = $XDG_DATA_HOME.'/rust/rust/src'

" if you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit='vertical'

" enable/disable deoplete
map <Leader>d :call deoplete#toggle()<cr>

" fzf, fuzzy finder
"let g:fzf_preview_window = 'right:60%'
"nnoremap <C-p> :Files<cr>
"nnoremap <C-g> :GFiles<cr>
"let g:fzf_action = {
"  \ 'ctrl-t': 'tab split',
"  \ 'ctrl-x': 'split',
"  \ 'ctrl-v': 'vsplit' }

" CtrlP
let g:ctrlp_show_hidden = 1
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_map = '<c-p>'
map <C-i> :CtrlPBufTag<cr>

" UltiSnips
let g:UltiSnipsExpandTrigger='<C-z>'
let g:UltiSnipsJumpForwardTrigger='<C-s>'
let g:UltiSnipsJumpBackwardTrigger='<C-g>'

" UndoTree
nnoremap <F5> :UndotreeToggle<cr>
