#                 ██
#                ░██
#  ██████  ██████░██
# ░░░░██  ██░░░░ ░██████
#    ██  ░░█████ ░██░░░██
#   ██    ░░░░░██░██  ░██
#  ██████ ██████ ░██  ░██
# ░░░░░░ ░░░░░░  ░░   ░░

PLUG_DIR="$ZDOTDIR/plugs/"

# clone plugins
[ ! -d "$ZDOTDIR/plugs" ] && {
	mkdir -p "$PLUG_DIR"
	cd "$PLUG_DIR"
	git clone https://github.com/tarjoilija/zgen
	git clone https://github.com/zsh-users/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions
	git clone --depth 1 https://github.com/junegunn/fzf
	"$PLUG_DIR/fzf/install" --no-bash --no-fish --xdg --all
}

# load plugins
. "$PLUG_DIR"/zsh-autosuggestions/zsh-autosuggestions.zsh
. "$PLUG_DIR"/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
. "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# load config
. "$ZDOTDIR/shortcutrc"
. "$ZDOTDIR/aliasrc"
. "$ZDOTDIR/prompt.zsh"
. "$ZDOTDIR/env.zsh"
. "$ZDOTDIR/commands.zsh"
. "$ZDOTDIR/syntax.zsh"
. "$ZDOTDIR/keybinds.zsh"
