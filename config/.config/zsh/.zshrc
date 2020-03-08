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

# tty color
if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0161821" #black
    echo -en "\e]P822262e" #darkgrey
    echo -en "\e]P1e27878" #darkred
    echo -en "\e]P9e27878" #red
    echo -en "\e]P2b4be82" #darkgreen
    echo -en "\e]PAc0ca8e" #green
    echo -en "\e]P3e2a478" #darkyellow
    echo -en "\e]PBe9b189" #yellow
    echo -en "\e]P484a0c6" #darkblue
    echo -en "\e]PC91acd1" #blue
    echo -en "\e]P5a093c7" #darkmagenta
    echo -en "\e]PDada0d3" #magenta
    echo -en "\e]P689b8c2" #darkcyan
    echo -en "\e]PE95c4ce" #cyan
    echo -en "\e]P7c6c8d1" #lightgrey
    echo -en "\e]PFd2d4de" #white
    clear #for background artifacting
fi
