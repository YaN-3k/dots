" setup vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	echo 'Downloading junegunn/vim-plug to manage plugins...'
	silent call system('mkdir -p ~/.config/nvim/{autoload,bundle,cache,undo,backups,swaps}')
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
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
Plug 'Shougo/deoplete-clangx'
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'deoplete-plugins/deoplete-zsh'
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}

Plug 'dense-analysis/ale'
" Plug 'ntpeters/vim-better-whitespace'
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'sheerun/vim-polyglot'
Plug 'mattn/emmet-vim'

" stylize
Plug 'lilydjwg/colorizer'
Plug 'scrooloose/nerdtree'
Plug 'isa/vim-matchit'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Goyo' }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

" features
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'kien/ctrlp.vim'
Plug 'matze/vim-move'
"Plug '~/.zgen/junegunn/fzf-master'
"Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()
