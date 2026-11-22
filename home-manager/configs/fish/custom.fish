if status is-interactive
    set -g fish_greeting
    set -g fish_prompt_pwd_dir_length 3
    set -g done_min_duration 10000

    # Fastfetch
    fastfetch

    # Syntax highlighting
    set -g fish_color_autosuggestion 5b6078
    set -g fish_color_command 8aadf4
    set -g fish_color_comment a5adcb --italics
    set -g fish_color_keyword c6a0f6
    set -g fish_color_end 8bd5ca
    set -g fish_color_error ed8796 --bold
    set -g fish_color_escape 7dc4e4
    set -g fish_color_history_current --bold
    set -g fish_color_host b7bdf8
    set -g fish_color_host_remote 7dc4e4
    set -g fish_color_normal --reset
    set -g fish_color_operator 7dc4e4
    set -g fish_color_param cad3f5
    set -g fish_color_option 8bd5ca
    set -g fish_color_quote a6da95
    set -g fish_color_redirection 8bd5ca --bold
    set -g fish_color_search_match cad3f5 --bold
    set -g fish_color_selection cad3f5 --bold
    set -g fish_color_status ed8796
    set -g fish_color_user 8bd5ca
    set -g fish_color_valid_path f4dbd6
    set -g fish_pager_color_description b7bdf8 --italics
    set -g fish_pager_color_prefix --bold --underline
    set -g fish_pager_color_progress a5adcb --bold
    set -g fish_pager_color_selected_background --reverse

    # Aliases
    alias eza 'command eza --git --icons=auto -l --modified --time-style="+%d %B %H:%M" --no-permissions --group-directories-first --header'
    abbr -a ls eza
    abbr -a cat bat
    abbr -a df duf
    abbr -a du dust

    # Fzf
    fzf --fish | source
    set -gx FZF_DEFAULT_COMMAND "fd -H -L -E '.git' -E '.npm*' -E '.nix*'"
    set -gx FZF_DEFAULT_OPTS "\
        --header='CTRL-E Edit | CTRL-C Copy | CTRL-/ Preview | CTRL-Q/ESC Quit' \
        --layout=reverse \
        --multi \
        --marker=▌ \
        --style=full \
        --color=bg:#24273a,bg+:#363a4f,selected-bg:#363a4f \
        --color=fg:#cad3f5,fg+:#b7bdf8,selected-fg:#c6a0f6 \
        --color=hl:#ed8796,hl+:#ed8796 \
        --color=header:#6e738d \
        --color=border:#5b6078,label:#cad3f5 \
        --color=info:#b7bdf8,marker:#c6a0f6,pointer:#b7bdf8,prompt:#b7bdf8,spinner:#c6a0f6 \
        --preview '[ -d {} ] && eza --icons=auto --tree --level=2 --color=always {} || bat --style=numbers --color=always --line-range :500 {}' \
        --bind 'ctrl-c:execute-silent(realpath {} | wl-copy)' \
        --bind 'ctrl-e:execute(nvim {})' \
    "
    set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
    set -gx FZF_CTRL_T_OPTS "--preview-window=hidden"
    set -gx FZF_ALT_C_COMMAND "fd -t d -H -L -E '.git'"
    set -gx FZF_ALT_C_OPTS "--preview-window=hidden"
    set -gx FZF_CTRL_R_OPTS "--preview-window=hidden"

    # Zoxide
    zoxide init fish --cmd cd | source
end

# Custom promt
function fish_prompt
    echo
    set -l base "#24273a"
    set -l surface0 "#363a4f"
    set -l surface1 "#494d64"
    set -l lavender "#b7bdf8"
    set -l yellow "#eed49f"
    set -l sep ""

    set_color $surface0
    echo -n "░▒▓"

    set_color -b $surface0 $lavender
    echo -n "  "

    set -l branch (git branch --show-current 2>/dev/null)
    if test -n "$branch"
        set_color -b $surface1 $surface0
        echo -n $sep
        set_color -b $surface1 $yellow
        echo -n "  $branch "
        set_color -b $lavender $surface1
    else
        set_color -b $lavender $surface0
    end

    echo -n $sep
    set_color -b $lavender $base
    echo -n "   "(prompt_pwd)" "

    set_color -b normal $lavender
    echo -n $sep
    set_color normal

    echo ""
    set_color $lavender
    echo -n "❯ "
    set_color normal
end

# Disable right promt
function fish_right_prompt
end
