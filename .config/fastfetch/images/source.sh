#!/usr/bin/env bash
set -euo pipefail

ffmpegw() {
    ffmpeg -y -nostdin -hide_banner -loglevel error "$@"
}

err() {
    printf "\x1b[1;31m%s\x1b[0m\n" "$1"
    exit 1
}

FILE=${1:-sources.list}
[ -e "$FILE" ] || err "'$FILE' doesn't exist"

while read -r line; do
    declare -a curlopts=()
    echo "$line"
    #shellcheck disable=SC2001
    line=$(sed 's/#.*//' <<<"$line")
    [ "$line" != "end" ] || break
    [ -n "$line" ] || continue

    read -r name ext url opt <<<"$line"
    if [ "$opt" == "useragent" ]; then
        # punish for dickheads
        curlopts+=(-A "FuckYouBot/1.0 (compatible; totally-a-browser)")
    fi

    filename=$name.$ext
    curl "${curlopts[@]}" -sLo "$filename" "$url"
    if ! [ "$opt" == "raw" ]; then
        magick "$filename" -crop "$(
            magick "$filename" -trim -format '%wx%h%O' info:
        )" +repage "$filename"

        if [ "$ext" != "png" ]; then
            ffmpegw -i "$filename" -vf "colorkey=black:2e-02:0" -c:v png -preset slow "$name.png"
        fi
    fi
done <"$FILE" | lolcat
