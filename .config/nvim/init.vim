" ┓ ┳o┏┏┓┳━┓┏━┓
" ┃┏┛┃┃┃┃ ┃┳┛┃
" ┗┛ ┇┛ ┇┇┗┛┗━┛

let configs = [
\  'general',
\  'commands',
\  'plugins',
\]

for file in configs
  let x = expand('~/.config/nvim/config/'.file.'.vim')
  if filereadable(x)
    execute 'source' x
  endif
endfor
