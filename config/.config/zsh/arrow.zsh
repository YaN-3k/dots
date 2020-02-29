if [[ $UID -eq 0 ]]; then
    color='%F{yellow}'
else
    color='%F{blue}'
fi

export PROMPT="
%(?:$color»:%F{red}») %f"
export RPROMPT="%B%{%F{blue}%}%~%f%b"
