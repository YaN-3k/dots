#             _
#   ____ ___ | |__
#  |_  // __|| '_ \
#   / / \__ \| | | |
#  /___||___/|_| |_|

source "${HOME}/.zgen/zgen.zsh"

# tetris
autoload -Uz tetriscurses
alias tetris="tetriscurses"

# Zgen, need to 'zgen reset' after changing
if ! zgen saved; then

	zgen oh-my-zsh
	zgen oh-my-zsh plugins/git
	zgen oh-my-zsh plugins/command-not-found
	zgen oh-my-zsh plugins/alias-finder
	zgen oh-my-zsh plugins/common-aliases
	zgen load zsh-users/zsh-syntax-highlighting
	zgen load zsh-users/zsh-autosuggestions
	zgen load junegunn/fzf
	"$HOME"/.zgen/junegunn/fzf-master/install --all

  zgen save
fi

# Plug config
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245'
bindkey -v '^N' autosuggest-accept

# Load shell-agnostic configs
source ~/.config/shortcutrc
source ~/.config/aliasrc

# Load config
source $ZDOTDIR/arrow.zsh
source $ZDOTDIR/config.zsh
source $ZDOTDIR/completion.zsh
source $ZDOTDIR/keybinds.zsh

[ -f ~/.fzf.bash ] && source ~/.fzf.zsh
