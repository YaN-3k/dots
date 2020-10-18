#       ---
#   environment
#    variables
#      -----
export PATH="$PATH:$HOME/.config/fzf/bin/:$(du $HOME/.local/bin | cut -f2 | paste -sd ':')"
fpath+=(~/.config/zsh/autoload/**/)

export HISTSIZE=1000
export SAVEHIST=1000
export HISTFILE=~/.config/zsh/.zsh_history

export EDITOR="nvim"
export TERMINAL="st"
export READER="zathura"
export FILE="vf"
export BROWSER="qutebrowser"
export DMENU="dmenu -w 225 -x 10 -y 30 -i"
export DMENU_RUN=${DMENU/dmenu/dmenu_run}

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export INPUTRC="$ZDOTDIR/inputrc"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export LESSHISTFILE="-"

export SUDO_ASKPASS="$HOME/.local/bin/scripts/utils/menupass"
export VIRTUAL_ENV_DISABLE_PROMPT=1
export SUDO_PROMPT=$'\e[34m'[$'\e[0m'sudo$'\e[34m']$'\e[0m'' password for '$'\e[1;34m''%p'$'\e[0m'': '
export SPROMPT="%F{blue}[%fzsh%F{blue}]%f correct %F{red}%R%f to %F{blue}%r%f [nyae]: "

export PAGER=less
export LESS=-R
export LESS_TERMCAP_mb=$'\e[1;34m'
export LESS_TERMCAP_md=$'\e[1;34m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[0;44;30m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[0;32m'

export FZF_DEFAULT_OPTS='
--color fg:7,hl:4,fg+:15,bg+:0,hl+:3
--color pointer:1,info:8,spinner:3,header:8,prompt:4,marker:8
--info=inline
--height 60%
--cycle
--reverse
--pointer=" "
'
export FZF_PREVIEW_COMMAND='preview {}'
export FZF_DEFAULT_COMMAND="find . -mindepth 1 2>/dev/null"
export FZF_ALT_C_COMMAND="find . -mindepth 1 -type d 2>/dev/null"
export FZF_ALT_C_OPTS="$FZF_DEFAULT_OPTS --preview 'preview {}'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS --preview 'preview {}'"

export SXHKD_SHELL="/bin/sh"
export MPD_HOST="password@$HOME/.config/mpd/socket"
export GOPATH="$HOME/dox/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export LS_COLORS="di=34:ln=36:pi=42:ex=33:tw=0:ow=0:st=0:*.tar=31:*.gz=31:"\
"*.xz=31:*.zip=31:*.mp3=35:*.flac=35:*.png=35:*.jpg=35:*.mkv=35:*.mp4=35"
