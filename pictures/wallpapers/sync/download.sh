#!/usr/bin/env bash
set -euo pipefail

LIST=${1:-src.list}

while read -r line; do
    line=${line//\#*/}
    [[ -n "$line" ]] || continue

    read -r out url <<<"$line"
    curl -sL "$url" -o "$out"
    printf "Downloaded \x1b[34m'%s' \x1b[35m'%s'\x1b[0m\n" "$out" "$url"
done <"$LIST"
