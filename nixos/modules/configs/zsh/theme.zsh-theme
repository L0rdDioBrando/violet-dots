setopt prompt_subst
autoload -Uz add-zsh-hook

SEP=""

function build_prompt() {
  local p=""
  local cur_bg="#363a4f"
  p+="%F{$cur_bg}░▒▓%f"

  p+="%K{$cur_bg}%F{#b7bdf8}  %f"

  local branch=$(git branch --show-current 2>/dev/null)
  if [[ -n $branch ]]; then
    local next_bg="#494d64"
    p+="%K{$next_bg}%F{$cur_bg}$SEP%f"
    p+="%K{$next_bg}%F{#eed49f}  $branch %f"
    cur_bg=$next_bg
  fi

  local dir_bg="#b7bdf8"
  p+="%K{$dir_bg}%F{$cur_bg}$SEP%f"
  p+="%K{$dir_bg}%F{#24273a}   %3~ %f"
  cur_bg=$dir_bg

  p+="%f%k%F{$cur_bg}$SEP%f"
  echo "$p"
}

typeset -g _prompt_first_run=1
function _prompt_newline_hook() {
  if [[ $_prompt_first_run -eq 1 ]]; then
    _prompt_first_run=0
  else
    print ""
  fi
}
add-zsh-hook precmd _prompt_newline_hook

PS1='$(build_prompt)
%F{#b7bdf8}❯ '
