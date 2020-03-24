#                 ██
#                ░██
#  ██████  ██████░██
# ░░░░██  ██░░░░ ░██████
#    ██  ░░█████ ░██░░░██
#   ██    ░░░░░██░██  ░██
#  ██████ ██████ ░██  ░██
# ░░░░░░ ░░░░░░  ░░   ░░

[ ! -d "$ZDOTDIR/.zgen" ] &&
	git clone https://github.com/tarjoilija/zgen "$ZDOTDIR/.zgen"

source "$ZDOTDIR/.zgen/zgen.zsh"

# tetris
autoload -Uz tetriscurses
alias tetris="tetriscurses"

# zgen, need to 'zgen reset' after changing
if ! zgen saved; then

	zgen load zsh-users/zsh-syntax-highlighting
	zgen load zsh-users/zsh-autosuggestions
	"$ZDOTDIR/.zgen/junegunn/fzf-master/install" --no-bash --no-fish --xdg --all
	zgen load junegunn/fzf

  zgen save
fi

# load config
source "$ZDOTDIR/shortcutrc"
source "$ZDOTDIR/aliasrc"
source "$ZDOTDIR/prompt.zsh"
source "$ZDOTDIR/env.zsh"
source "$ZDOTDIR/commands.zsh"
source "$ZDOTDIR/syntax.zsh"
source "$ZDOTDIR/keybinds.zsh"

# load fzf
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh
