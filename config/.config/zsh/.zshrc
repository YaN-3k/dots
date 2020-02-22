#             _
#   ____ ___ | |__
#  |_  // __|| '_ \
#   / / \__ \| | | |
#  /___||___/|_| |_|

# Load shell-agnostic configs
[ -f "$HOME/.config/shortcutrc" ] && source ~/.config/shortcutrc
[ -f "$HOME/.config/aliasrc" ] && source ~/.config/aliasrc

export HISTFILE="$HOME/.config/zsh/.zsh_history"
source "${HOME}/.zgen/zgen.zsh"

autoload -U compinit promptinit colors
compinit
promptinit
colors
setopt prompt_subst
setopt AUTO_CD
setopt CORRECT
setopt completealiases
setopt append_history
setopt share_history
setopt hist_verify
setopt hist_ignore_all_dups

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
setopt complete_aliases
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Zgen, need to 'zgen reset' after changing
if ! zgen saved; then

	zgen oh-my-zsh
	zgen oh-my-zsh plugins/git
	zgen oh-my-zsh plugins/command-not-found
	zgen oh-my-zsh plugins/alias-finder
	zgen oh-my-zsh plugins/common-aliases
	zgen load zsh-users/zsh-syntax-highlighting
	zgen load zsh-users/zsh-autosuggestions

  zgen save
fi

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245'

# show available tmux sessions
if [[ -z $TMUX ]]; then
    sessions=$( tmux ls 2> /dev/null | awk '! /attached/ { sub(":", "", $1); print $1; }' | xargs echo )
    if [[ ! -z $sessions ]]; then
        echo "==> Available tmux sessions: $sessions"
    fi
    unset sessions
fi

# return_code="%(?..%F{red}%? ↵%f)"

# if [[ $UID -eq 0 ]]; then
#     user_host='%B%F{red}%n@%m %f%b'
#     user_symbol='#'
# else
#     user_host='%B%F{green}%n@%m %f%b'
#     user_symbol='$'
# fi

# current_dir='%B%F{blue}%~ %b%f'
# git_branch='$(git_prompt_info)'

# ZSH_THEME_GIT_PROMPT_PREFIX='%F{yellow}‹'
# ZSH_THEME_GIT_PROMPT_SUFFIX='%F{yellow}%b›%f'
# ZSH_THEME_GIT_PROMPT_DIRTY='%F{yellow}*%f'
# ZSH_THEME_GIT_PROMPT_UNTRACKED='%F{yellow}*%f'
# ZSH_THEME_GIT_PROMPT_CLEAN=''

# export PROMPT="╭─${user_host}${current_dir}${git_branch}
# ╰─%B${user_symbol}%b "
# export RPROMPT="%B${return_code}%b"

PROMPT="
%(?:%F{blue}»:%F{red}») %f"
RPROMPT="%B%{%F{240}%}%~%f%b"

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '^[[Z' reverse-menu-complete
bindkey -v '^n' autosuggest-accept

# Bind vim keys to searching in history
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# bindkey -v "^b"  history-beginning-search-backward-end
# bindkey -v "^f"  history-beginning-search-forward-end

bindkey "^p"  history-search-backward
bindkey "^f"  history-search-forward

# Better searching in command mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# Emcs like
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^L" clear-screen
bindkey "^R" history-incremental-search-backward
bindkey "^U" kill-whole-line
bindkey "^W" backward-kill-word
bindkey "^Y" yank

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line
bindkey '^v' edit-command-line
bindkey -s '^g' '!*'
bindkey '^x' clear-screen

# vi mode
bindkey -v '^?' backward-delete-char
bindkey -v '^h' backward-delete-char
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[6 q"
}
zle -N zle-line-init
echo -ne '\e[6 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[6 q' ;} # Use beam shape cursor for each new prompt.

# Multi-dot cd (...)
function expand-multiple-dots() {
    local MATCH
    if [[ $LBUFFER =~ '(^| )\.\.\.+' ]]; then
        LBUFFER=$LBUFFER:fs%\.\.\.%../..%
    fi
}
function expand-multiple-dots-then-expand-or-complete() {
    zle expand-multiple-dots
    zle expand-or-complete
}
function expand-multiple-dots-then-accept-line() {
    zle expand-multiple-dots
    zle accept-line
}
zle -N expand-multiple-dots
zle -N expand-multiple-dots-then-expand-or-complete
zle -N expand-multiple-dots-then-accept-line
bindkey '^I' expand-multiple-dots-then-expand-or-complete
bindkey '^M' expand-multiple-dots-then-accept-line

# Load fzf keybindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Autostart tmux
# if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#     tmux
# fi
