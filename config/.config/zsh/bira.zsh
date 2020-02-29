autoload -U compinit promptinit colors
compinit
promptinit
colors

return_code="%(?..%F{red}%? ↵%f)"

if [[ $UID -eq 0 ]]; then
    user_host='%B%F{red}%n@%m %f%b'
    user_symbol='#'
else
    user_host='%B%F{green}%n@%m %f%b'
    user_symbol='$'
fi

current_dir='%B%F{blue}%~ %b%f'
git_branch='$(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX='%F{yellow}‹'
ZSH_THEME_GIT_PROMPT_SUFFIX='%F{yellow}%b›%f'
ZSH_THEME_GIT_PROMPT_DIRTY='%F{yellow}*%f'
ZSH_THEME_GIT_PROMPT_UNTRACKED='%F{yellow}*%f'
ZSH_THEME_GIT_PROMPT_CLEAN=''

export PROMPT="╭─${user_host}${current_dir}${git_branch}
╰─%B${user_symbol}%b "
export RPROMPT="%B${return_code}%b"
