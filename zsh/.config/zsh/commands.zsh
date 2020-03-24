# autostart tmux
#if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#    tmux
#fi

# basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)  # Include hidden files.

# show available tmux sessions
if [[ -z $TMUX ]]; then
    sessions=$( tmux ls 2> /dev/null | awk '! /attached/ { sub(":", "", $1); print $1; }' | xargs echo )
    if [[ -n $sessions ]]; then
        echo "==> Available tmux sessions: $sessions"
    fi
    unset sessions
fi

# vi mode
bindkey -v
export KEYTIMEOUT=1

# change cursor shape for different vi modes.
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
