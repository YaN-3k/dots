#                 ██
#                ░██
#  ██████  ██████░██
# ░░░░██  ██░░░░ ░██████
#    ██  ░░█████ ░██░░░██
#   ██    ░░░░░██░██  ░██
#  ██████ ██████ ░██  ░██
# ░░░░░░ ░░░░░░  ░░   ░░

source "${HOME}/.zgen/zgen.zsh"

# tetris
autoload -Uz tetriscurses
alias tetris="tetriscurses"

# zgen, need to 'zgen reset' after changing
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

# load shell-agnostic configs
source ~/.config/shortcutrc
source ~/.config/aliasrc

# load config
source $ZDOTDIR/prompt.zsh
source $ZDOTDIR/env.zsh
source $ZDOTDIR/commands.zsh
source $ZDOTDIR/syntax.zsh
source $ZDOTDIR/keybinds.zsh

# load fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.zsh
