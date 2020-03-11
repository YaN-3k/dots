#  ██                        ██
# ░██                       ░██
# ░██       ██████    ██████░██
# ░██████  ░░░░░░██  ██░░░░ ░██████
# ░██░░░██  ███████ ░░█████ ░██░░░██
# ░██  ░██ ██░░░░██  ░░░░░██░██  ░██
# ░██████ ░░████████ ██████ ░██  ░██
# ░░░░░    ░░░░░░░░ ░░░░░░  ░░   ░░

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load shell-agnostic configs
[ -f ~/.config/aliasrc ] && source ~/.config/aliasrc
[ -f ~/.config/shortcutrc ] && source ~/.config/shortcutrc

# History file
export HISTFILE="$HOME/.config/zsh/.bash_history"

# Vim mode
set -o vi

#Bash prompt
#if [[ $UID -eq 0 ]]; then
#    user_host='\033[1;31m\u@\h \033[0m'
#    user_symbol='#'
#else
#    user_host='\033[1;32m\u@\h \033[0m'
#    user_symbol='$'
#fi

#PS1="╭─${user_host}in \033[1;34m\w\n\033[1;37m╰─${user_symbol}\033[0m "
#PS1='$(printf "%*b\r%b" $(( COLUMNS + 10 )) "\033[1;34m\w\033[0m" "\033[0;34m»\033[0m ")'
PS1="
\033[0;34m» \033[0m"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
