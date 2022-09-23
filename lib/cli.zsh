#! /usr/bin/env zsh

function _you::help {
  cat >&2 <<EOF
you -- A very simple and personal set of wrappers.

USAGE:
    you <SUBCOMMAND>

OPTIONS:
    -h, --help                        Show this message.

SUBCOMMANDS:
    go <QUERY>                        Open directory in a new tmux session, or attach.
EOF
  return 0
}
function you {
  ((${#@} == 0 && $#help)) && {_$0::help; return 0}
  (($# > 0 && $+functions[_$0::$1])) || {_$0::help; return 1}

  local cmd="$1"; shift
  (($#help)) && _$0::$cmd "$@" --help || _$0::$cmd "$@"
}
