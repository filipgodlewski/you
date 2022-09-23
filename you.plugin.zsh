#! /usr/bin/env zsh

[[ -z "$YOU_PLUG" ]] && export YOU_PLUG="${${(%):-%x}:a:h}"

for config_file ("$YOU_PLUG"/lib/**/*.zsh); do
    source "$config_file"
done
unset config_file
