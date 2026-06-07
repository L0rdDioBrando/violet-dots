#!/usr/bin/env bash

bar_size=21
full_char="━"
empty_char="─"

get_info() {
    status=$(playerctl -p spotify,strawberry,firefox,mpv,%any status 2>/dev/null)

    if [ "$status" = "Playing" ] || [ "$status" = "Paused" ]; then
        position=$(playerctl -p spotify,strawberry,firefox,mpv,%any metadata --format "{{ position }}")
        length=$(playerctl -p spotify,strawberry,firefox,mpv,%any metadata --format "{{ mpris:length }}")

        if [ -n "$length" ] && [ "$length" -gt 0 ]; then
            percent=$(( position * 100 / length ))
            filled=$(( percent * bar_size / 100 ))
            empty=$(( bar_size - filled ))

            bar=$(printf "%${filled}s" | sed "s/ /$full_char/g")
            bar+=$(printf "%${empty}s" | sed "s/ /$empty_char/g")
            
            pos_min=$(( (position / 1000000) / 60 ))
            pos_sec=$(( (position / 1000000) % 60 ))
            len_min=$(( (length / 1000000) / 60 ))
            len_sec=$(( (length / 1000000) % 60 ))
            time_info=$(printf "%d:%02d / %d:%02d" $pos_min $pos_sec $len_min $len_sec)
        else
            bar="Stream / Live"
            time_info=""
        fi

        artist=$(playerctl -p spotify,strawberry,firefox,mpv,%any metadata artist)
        title=$(playerctl -p spotify,strawberry,firefox,mpv,%any metadata title)
        
        if [ "$status" = "Playing" ]; then
            play_icon="          󰏤"
        else
            play_icon="          󰐊"
        fi

        display_title="${title:0:$bar_size}"
        display_artist="${artist:0:$bar_size}"

        tooltip="<span color='#b7bdf8'><b>$display_title</b></span>\n$display_artist\n\n$play_icon\n<span font='FiraCode Nerd Font Mono 11'>$bar</span>\n$time_info"
        panel_text=" $artist ~ $title "
        
        panel_text="${panel_text//\"/\\\"}"
        tooltip="${tooltip//\"/\\\"}"

        printf '{"text": "%s", "tooltip": "%s", "class": "%s"}\n' "$panel_text" "$tooltip" "$status"
    else
        printf '{"text": "", "tooltip": "Nothing playing", "class": "stopped"}\n'
    fi
}

get_info

playerctl -p spotify,strawberry,firefox,mpv,%any metadata --follow --format "{{status}}{{title}}{{artist}}{{position}}" | while read -r line; do
    get_info
done
