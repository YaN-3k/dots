#  ██                        ██
# ░██                       ░██
# ░██       ██████    ██████░██
# ░██████  ░░░░░░██  ██░░░░ ░██████
# ░██░░░██  ███████ ░░█████ ░██░░░██
# ░██  ░██ ██░░░░██  ░░░░░██░██  ░██
# ░██████ ░░████████ ██████ ░██  ░██
# ░░░░░    ░░░░░░░░ ░░░░░░  ░░   ░░

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# load shell-agnostic configs
[ -f ~/.config/aliasrc ] && source ~/.config/shell/aliasrc
[ -f ~/.config/shortcutrc ] && source ~/.config/shell/shortcutrc

# history file
export HISTFILE="$HOME/.cache/bash_history"

# vim mode
set -o vi

# bash prompt
PS1='\033[0;34m[\033[0m\w\033[0;34m]── ─ \033[0m'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
