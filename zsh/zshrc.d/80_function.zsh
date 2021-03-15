### Function ###
function mkcd() {
    mkdir -p "$@" && cd $_
}

function peco-history-selection() {
    BUFFER=`history -n 1 | tac  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^H' peco-history-selection

function peco-repos () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    # peco$B$GA*BrCf(B, Enter $B$r2!$7$?=V4V$K<B9T$9$k(B
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-repos
bindkey '^R' peco-repos
