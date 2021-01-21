#       ---
#   zsh settings
#       ---
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# automaticly escape urls special characters
autoload -Uz url-quote-magic bracketed-paste-magic
zle -N self-insert url-quote-magic
zle -N bracketed-paste bracketed-paste-magic

# prompt
export PROMPT='%F{%(?.4.1)}>%f ' # minimal
export PROMPT2="%_%F{blue}>%f "

#setopt correct_all      # autocorrect commands
setopt auto_menu        # automatically use menu completion
setopt always_to_end    # move cursor to end if word had one match
setopt complete_in_word # completion from both ends
autoload -Uz compinit && compinit -u
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' ignored-patterns '.'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
_comp_options+=(globdots)

#     ---
#   vi mode
#     ---
bindkey -v
export KEYTIMEOUT=1
local cursor_insert="\e[4 q"
local cursor_normal="\e[2 q"

# change cursor shape for different vi modes.
function zle-keymap-select() {
	if [[ $KEYMAP == vicmd || $1 == 'block' ]]; then
		print -n $cursor_normal
	elif [[ $KEYMAP == main || $KEYMAP == viins || -z $KEYMAP || $1 == 'beam' ]]; then
		print -n $cursor_insert
	fi
}

function zle-line-init() {
	zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -v` has been set elsewhere)
	print -n $cursor_insert
}

zle -N zle-keymap-select
zle -N zle-line-init

print -n $cursor_insert # use beam shape cursor on startup.
function preexec() { print -n $cursor_insert; } # use beam shape cursor for each new prompt.

#       ---
#   keybindings
#       ---

# use vim keys in tab complete menu:
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# emacs like editing
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^k" kill-line
bindkey "^u" backward-kill-line
bindkey "^w" backward-kill-word
bindkey "^[d" kill-word
bindkey "^_" undo
bindkey '^b' backward-char
bindkey '^f' forward-char
bindkey "^[f" forward-word
bindkey "^[b" backward-word
bindkey '^p' up-line-or-search
bindkey '^n' down-line-or-search
bindkey '^[^M' self-insert-unmeta
bindkey '^[[Z' reverse-menu-complete
bindkey '^x^e' edit-command-line
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char
bindkey '^[#' pound-insert
bindkey '^y' yank
bindkey '^[y' yank-pop

#     ---
#   aliases
#     ---
alias sudo='sudo '
alias grep='grep --color=auto'
alias cp='cp -vri'
alias mv='mv -vi'
alias mkd='mkdir -pv'
alias rm='rm -v'
alias diff='diff --color -u'
alias ls='ls -CF --group-directories-first  --color=auto'
alias ll='ls -lA -h --group-directories-first --color=auto'

alias ab='abook -C ~/.config/abook/abookrc --datafile ~/.config/abook/addressbook'
alias gdb='gdb -q -x ~/.config/gdb/gdbinit'
alias irssi='irssi --home ~/.config/irssi'
alias ir='irssi'
alias nc='ncmpcpp -q'
alias nm='neomutt'
alias vim='nvim'
alias vf='vifm'
alias tmux='tmux -f ~/.config/tmux/tmux.conf'

alias yt-dl='youtube-dl -o "%(title)s.%(ext)s"'
alias yt-video='yt-dl -f bestvideo'
alias yt-audio='yt-dl -f bestaudio --audio-quality 0 -x'
alias yt-mp3='yt-audio --audio-format mp3'
alias yt-flac='yt-audio --audio-format flac'

alias out='pkill -kill -u $USER'
alias open='setsid xdg-open'
alias fuck='pkill -9'
alias clip="xclip -sel clip"

autoload -Uz run-help  # search for help / manual pages
(( $+aliases[run-help] )) && unalias run-help
alias help='run-help'

#      -------
#   miscellaneous
#      -------
set -k               # allows comments in interactive shell
setopt auto_cd       # cd by just typing the directory name
setopt extendedglob  # additional syntax for filename generation
[ ! -f $ZDOTDIR/sc.sh ] && shortcuts
source $ZDOTDIR/sc.sh

function command_not_found_handler() {
	print -P "not found: %F{red}$0%f" >&2
	return 127
}

#     ---
#   plugins
#     ---
# fzf
if [ ! -d ~/.config/fzf ]; then
	git clone --depth 1 https://github.com/junegunn/fzf ~/.config/fzf
	~/.config/fzf/install --no-bash --no-fish --xdg --all
fi

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# syntax highlighting
if [ ! -d ~/.config/zsh-syntax-highlighting ]; then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.config/zsh-syntax-highlighting
fi
source ~/.config/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]='fg=blue'
ZSH_HIGHLIGHT_STYLES[assign]='none'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue'
ZSH_HIGHLIGHT_STYLES[command]='fg=blue'
ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
ZSH_HIGHLIGHT_STYLES[default]='none'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=green'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=blue'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=green'
ZSH_HIGHLIGHT_STYLES[links]='none'
ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[path_approx]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=blue'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=blue'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=green'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
