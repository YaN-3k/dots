#       ---
#   zsh settings
#       ---
setopt PROMPT_SUBST # allow functions in the prompt
autoload -Uz vcs_info
precmd_functions+=(vcs_info)
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:git:*' stagedstr '|&'
zstyle ':vcs_info:git:*' unstagedstr '|*'
zstyle ':vcs_info:git:*' formats "%F{blue}─[%F{white}%b%c%u%F{blue}]"
zstyle ':vcs_info:git:*' actionformats "%F{blue}─[%F{white}%b%c%u%F{blue}]-[%F{white}%a%F{blue}]"
zstyle ':vcs_info:git*+set-message:*' hooks git-remote-status git-modified git-added
zstyle ':vcs_info:*+*:*' debug false

function +vi-git-remote-status() {
    local ahead behind branch_status
    behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
    (( behind )) && branch_status+="|-$behind"
    ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
    (( ahead )) && branch_status+="|+$ahead"
    hook_com[branch]+=$branch_status
}

function +vi-git-modified() {
    local modified=$(git diff --name-only | wc -l)
    (( modified )) && hook_com[unstaged]+=$modified
}

function +vi-git-added() {
    local added=$(git diff --name-only --cached | wc -l)
    (( added )) && hook_com[staged]+=$added
}

function +virtual-env() {
  [[ -n $VIRTUAL_ENV ]] && virtual_env_msg="%F{blue}-[%F{white}${VIRTUAL_ENV:t}%F{blue}]"
}
precmd_functions+=(+virtual-env)

#export PROMPT="%F{blue}[%F{white}%~%F{blue}]\${vcs_info_msg_0_}\${virtual_env_msg}── ─ %f" # oneline
#export PROMPT="%F{blue}┌[%F{white}%~%F{blue}]\${vcs_info_msg_0_}\${virtual_env_msg}"$'\n'"%F{blue}└─ ─ %f" # dual
#export RPROMPT="%(?..%F{red}%?%f) %F{blue}─ ──[%F{white}%n@%M%F{blue}]"
#export PROMPT2="%F{blue}[%f%_%F{blue}]%f "
PROMPT='%F{%(?.4.1)}>%f ' # minimal
export PROMPT2="%_%F{blue} >%f "

setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

setopt auto_menu        # automatically use menu completion
#setopt correct_all      # autocorrect commands
setopt always_to_end    # move cursor to end if word had one match
setopt complete_in_word # completion from both ends
autoload -Uz compinit && compinit -u
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' ignored-patterns '.'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*' # case-insensitive completion
_comp_options+=(globdots) # include hidden files.

# use vim keys in tab complete menu:
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# vi mode
bindkey -v
export KEYTIMEOUT=1
local cursor_insert="\e[4 q"
local cursor_normal="\e[2 q"

# change cursor shape for different vi modes.
function zle-keymap-select() {
  if [[ $KEYMAP == vicmd || $1 = 'block' ]]; then
    print -n $cursor_normal
  elif [[ $KEYMAP == main || $KEYMAP == viins || -z $KEYMAP || $1 = 'beam' ]]; then
    print -n $cursor_insert
  fi
}
zle -N zle-keymap-select

function zle-line-init() {
  zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -v` has been set elsewhere)
  print -n $cursor_insert
}
zle -N zle-line-init

print -n $cursor_insert # use beam shape cursor on startup.
function preexec() { print -n $cursor_insert; } # use beam shape cursor for each new prompt.

# fzf
[ ! -d ~/.config/fzf ] && {
  git clone --depth 1 https://github.com/junegunn/fzf ~/.config/fzf
  ~/.config/fzf/install --no-bash --no-fish --xdg --all
}
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# syntax highlighting
[ ! -d ~/.config/zsh-syntax-highlighting ] &&
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.config/zsh-syntax-highlighting
source ~/.config/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

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

# miscellaneous
set -k               # allows comments in interactive shell
setopt auto_cd       # cd by just typing the directory name
setopt extendedglob  # additional syntax for filename generation
unsetopt flowcontrol # disable ctrl-s and ctrl-q
[ ! -f $ZDOTDIR/sc.sh ] && shortcuts
source $ZDOTDIR/sc.sh

# load functions
autoload -Uz ~/.config/zsh/autoload/**/*
source ~/.config/zsh/autoload/trash

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
autoload -Uz zed # text editor that is better than nano
autoload -Uz sticky-note # notes
zstyle :sticky-note notefile $ZDOTDIR/.zsticky
zstyle :sticky-note theme bg ''
autoload -Uz ztodo # todo list
zstyle ':ztodo:*' cache-file $ZDOTDIR/.ztodo
autoload -Uz zmv # replacement for cp, mv and ln
autoload -Uz run-help # search for help / manual pages
(( $+aliases[run-help] )) && unalias run-help

# automaticly escape urls special characters
#autoload -Uz url-quote-magic bracketed-paste-magic
#zle -N self-insert url-quote-magic
#zle -N bracketed-paste bracketed-paste-magic

function command_not_found_handler() {
  print -P "not found: %F{red}$0%f" >&2
  return 127
}

#       ---
#   keybindings
#       ---
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^k" kill-line
bindkey "^l" clear-screen
bindkey "^u" kill-whole-line
bindkey "^w" backward-kill-word
bindkey "^y" yank
bindkey "^_" undo
bindkey '^p' up-line-or-search
bindkey '^n' down-line-or-search
bindkey '^[^M' self-insert-unmeta
bindkey '^[[Z' reverse-menu-complete

# fix backspace and ctrl-h
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

# edit command line in vim
autoload -Uz edit-command-line; zle -N edit-command-line
bindkey -M vicmd '^e' edit-command-line
bindkey -M viins '^e' edit-command-line

autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -M viins '^k' up-line-or-beginning-search
bindkey -M viins '^j' down-line-or-beginning-search
bindkey -M vicmd 'k' up-line-or-beginning-search
bindkey -M vicmd 'j' down-line-or-beginning-search
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward
bindkey -M vicmd '^r' fzf-history-widget

#     ---
#   aliases
#     ---
alias sudo='sudo '

alias grep='grep --color=auto'
alias cp='cp -vri'
alias mv='mv -vi'
alias zcp='zmv -C -o -rvi'
alias zmv='zmv -M -o -vi'
alias zln='zmv -L -o -vi'

alias mkd='mkdir -pv'
mc() { mkdir -p $1 && cd $1 }

#alias rm='rm -vi'
alias rm='trash-put'
alias trp='trash-put'
alias trl='trash-list'
alias tre='trash-restore-interactive'
alias trm='trash-remove-interactive'
alias cleanup='trash-find -mtime +7 -exec rm -vrf {} \;'

alias ls='ls -CF --group-directories-first  --color=auto'
alias la='ls -ACF -h --group-directories-first --color=auto'
alias ll='ls -lA -h --group-directories-first --color=auto'
alias lt='tree'

#alias ls='exa --group-directories-first'
#alias la='exa -a --group-directories-first'
#alias ll='exa -al --group-directories-first'
#alias lt='exa -aT --group-directories-first'

alias ir='irssi --home ~/.config/irssi'
alias nc='ncmpcpp -q'
alias ra='ranger'
alias nm='neomutt'
alias ab='abook -C ~/.config/abook/abookrc --datafile ~/.config/abook/addressbook'
alias ss="sudo systemctl"
alias gdb='gdb -q -x ~/.config/gdb/gdbinit'

alias g='git'
alias ga='git add'
alias gd='git diff'
alias gp='git push'
alias gs='git status'
alias gc='git commit'
alias gl='git log --all --decorate --graph'

alias tr-remote='transmission-remote'
alias tr-daemon='transmission-daemon'
alias tr-show='transmission-show'
alias tr-cli='transmission-cli'
alias tr-edit='transmission-edit'
alias tr-create='transmission-create'

alias tmux='tmux -f ~/.config/tmux/tmux.conf'
alias tm='tmux -f ~/.config/tmux/tmux.conf'

alias yt-dl='youtube-dl -o "%(title)s.%(ext)s"'
alias yt-video='yt-dl -f bestvideo'
alias yt-audio='yt-dl -f bestaudio'
alias yt-mp3='yt-audio --audio-quality 0 -x --audio-format mp3'
alias yt-flac='yt-audio --audio-quality 0 -x --audio-format flac'

alias mirror="sudo reflector -l 30 -n 10 -f 30 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector -l 50 -n 20 --sort score --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector -l 50 -n 20 --sort delay --verbose --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector -l 50 -n 20 --sort age   --verbose --save /etc/pacman.d/mirrorlist"

alias out='pkill -kill -u $USER'
alias open='xdg-open'
alias note='sticky-note'
alias todo='ztodo'
alias fuck='pkill -9'
alias help='run-help'
alias unlock='sudo rm /var/lib/pacman/db.lck'
alias clip="xclip -sel clip"
