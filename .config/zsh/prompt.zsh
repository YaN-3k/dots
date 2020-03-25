ICO_DIRTY="*"
ICO_AHEAD="+"
ICO_BEHIND="-"
ICO_DIVERGED="!"

COLOR_ROOT="%F{red}"
COLOR_USER="%F{blue}"
COLOR_NORMAL="%F{white}"
PROMPT_STYLE="classic"

#█▓▒░ allow functions in the prompt
setopt PROMPT_SUBST
autoload -Uz colors && colors

#█▓▒░ colors for permissions
[ "$EUID" -ne "0" ] &&
	USER_LEVEL="${COLOR_USER}" ||
	USER_LEVEL="${COLOR_ROOT}"

#█▓▒░ git prompt
GIT_PROMPT() {
	test=$(git rev-parse --is-inside-work-tree 2> /dev/null)
	[ ! "$test" ] && return

	ref=$(git rev-parse --abbrev-ref HEAD)

	changes=$(git diff --shortstat 2> /dev/null | tail -n1)
	[ "$changes" ] &&
		dirty=$ICO_DIRTY ||
		dirty=""

	stat=$(git status | sed -n 2p)

	case "$stat" in
	*ahead*)
		stat=$ICO_AHEAD
	;;
	*behind*)
		stat=$ICO_BEHIND
	;;
	*diverged*)
		stat=$ICO_DIVERGED
	;;
	*)
		stat=""
	;;
	esac
	echo "${USER_LEVEL}─[${COLOR_NORMAL}"${ref}${dirty}${stat}"${USER_LEVEL}]"
}

if [ "$PROMPT_STYLE" = "dual" ]; then
PROMPT='${USER_LEVEL}┌[${COLOR_NORMAL}%~${USER_LEVEL}]$(GIT_PROMPT)
${USER_LEVEL}└─ ─ %f'
else
PROMPT='${USER_LEVEL}[${COLOR_NORMAL}%~${USER_LEVEL}]$(GIT_PROMPT)── ─ %f'
fi
