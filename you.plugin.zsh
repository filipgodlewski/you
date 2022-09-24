#! /usr/bin/env zsh

0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

typeset -g YOU_BASE_DIR="${0:h}"

if [[ ${zsh_loaded_plugins[-1]} != */you && -z ${fpath[(r)${0:h}]} ]]; then
  fpath+=("${0:h}")
fi
autoload you
