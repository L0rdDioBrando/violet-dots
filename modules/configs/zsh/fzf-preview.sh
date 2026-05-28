#!/usr/bin/env bash

printf "\033_Ga=d,d=i,i=99,q=2;\033\\"

send_chunked() {
    first="y"
    while IFS= read -r chunk; do
        metadata=""; [ "$first" = "y" ] && { metadata="a=T,f=100,i=99,q=2,"; first="n"; }
        printf "\033_G%sm=1;%s\033\\" "${metadata}" "${chunk}"
    done
    [ "$first" = "n" ] && { printf "\033_Gm=0;\033\\"; return 0; }
    return 1
}

transmit_file() {
    { command base64 -w 4096 "$1" 2>/dev/null | send_chunked; } || \
    { command base64 -b 4096 "$1" 2>/dev/null | send_chunked; } || \
    { command openssl base64 -e -A -in "$1" | command sed '$a\' | command fold -b -w 4096 | send_chunked; }
}

if [ -z "$1" ]; then
    exit 0
fi

if [ -d "$1" ]; then
    ls -la --color=always "$1"
elif [ -f "$1" ]; then
    mime=$(file --mime-type -b "$1")
    
    if [ "$mime" = "image/png" ]; then
        transmit_file "$1"
    elif [[ "$mime" == image/* ]]; then
        if command -v magick >/dev/null 2>&1; then
            tmp_img=$(mktemp)
            magick "$1[0]" -resize '800x800>' png:"$tmp_img"
            transmit_file "$tmp_img"
            rm -f "$tmp_img"
        elif command -v convert >/dev/null 2>&1; then
            tmp_img=$(mktemp)
            convert "$1[0]" -resize '800x800>' png:"$tmp_img"
            transmit_file "$tmp_img"
            rm -f "$tmp_img"
        else
            echo "Для предпросмотра $mime форматов нужно установить ImageMagick."
            echo "(Утилиты 'magick' или 'convert' не найдены)"
        fi
    elif [[ "$mime" == text/* ]] || [ "$mime" = "application/json" ]; then
        cat "$1" 2>/dev/null
    else
        echo "Предпросмотр недоступен для типа: $mime"
    fi
fi
