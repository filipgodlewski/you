#! /usr/bin/env zsh

function _you::go::help {
  cat >&2 <<EOF
USAGE:
    ${(j: :)${(s.::.)0#_}% help} [QUERY]

    Open queried directory in either a new tmux session, if it doesn't exist,
    or attach to an existing one. Uses zoxide to query.

ARGS:
    <QUERY>      Either the name of the directory or something that will let zoxide find it.

OPTIONS:
    -h, --help                        Show this message.
EOF
  return 0
}
function _you::go {
  trap "unset help" EXIT ERR INT QUIT STOP CONT
  zparseopts -D -F -K -- {h,-help}=help

  (($#help)) && {$0::help; return 0}
  (($#)) && local dir_name=$(zoxide query "$@") || local dir_name=$(zoxide query -l | fzf)
  (($#dir_name)) || {echo "No results for the query '$@'.\nMaybe zoxide did not index this directory yet."; return 1}
  local session_name=$(basename $dir_name | sed 's/\./_/')

  [[ $(pgrep tmux) ]] || {tmux new-session -s $session_name -c $dir_name; return 0}
  tmux has -t "$session_name" 2> /dev/null
  (($? == 1)) && tmux new-session -d -s $session_name -c $dir_name
  [[ $TMUX ]] && tmux switch-client -t $session_name || tmux attach-session -t $session_name -c $reslt
}
