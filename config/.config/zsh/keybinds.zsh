# Emcs like
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^L" clear-screen
bindkey "^R" history-incremental-search-backward
bindkey "^U" kill-whole-line
bindkey "^W" backward-kill-word

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd '^E' edit-command-line
#bindkey '^E' edit-command-line

# Autocompletion
bindkey -v '^N' autosuggest-accept

# Last parametr
bindkey -s '^g' '!*'

# Rebind clear screen for tmux
bindkey '^x' clear-screen

# Fix backspace, C+h and DEL key
bindkey -v '^?' backward-delete-char
bindkey '^H' backward-delete-char
bindkey -M vicmd "^[[3~" delete-char
bindkey "^[[3~" delete-char

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '^[[Z' reverse-menu-complete
