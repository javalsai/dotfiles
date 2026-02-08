#!/usr/bin/env sh

[ -z "$LANG" ] && export LANG=es_ES.UTF-8

unipicker \
    --command 'vicinae dmenu 2> /dev/null' \
    --copy-command cat | tail -n +2
