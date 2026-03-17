import datetime
import subprocess
from kitty.fast_data_types import Screen, get_options
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    TabBarData,
    as_rgb,
    draw_tab_with_powerline,
)
from kitty.utils import color_as_int

opts = get_options()

timer_id = None

SEP_RIGHT = ""
SEP_LEFT = ""

BAR_BG = as_rgb(color_as_int(opts.tab_bar_background if opts.tab_bar_background else opts.color0))
CLOCK_FG = 0
CLOCK_BG = as_rgb(color_as_int(opts.color0))

def draw_right_status(screen: Screen) -> int:
    cells = []
    
    music_text = get_music_info()
    if music_text:
        cells.append((as_rgb(0x181926), as_rgb(0xb7bdf8), music_text))
    
    time_str = datetime.datetime.now().strftime(" %H:%M ")
    cells.append((as_rgb(0x181926), as_rgb(0xcad3f5), time_str))

    total_right_length = 0
    for i, cell in enumerate(cells):
        is_last_cell = (i == len(cells) - 1)
        total_right_length += len(cell[2]) + (1 if is_last_cell else 2)

    draw_spaces = screen.columns - screen.cursor.x - total_right_length
    if draw_spaces > 0:
        screen.cursor.bg = BAR_BG
        screen.draw(" " * draw_spaces)

    for i, (fg, bg, text) in enumerate(cells):
        is_last_cell = (i == len(cells) - 1)

        screen.cursor.fg = bg
        screen.cursor.bg = BAR_BG
        screen.draw(SEP_RIGHT)

        screen.cursor.fg = fg
        screen.cursor.bg = bg
        screen.draw(text)

        if not is_last_cell:
            screen.cursor.fg = bg
            screen.cursor.bg = BAR_BG
            screen.draw(SEP_LEFT)
    
    return screen.cursor.x



TARGET_PLAYER = "spotify" 

def get_music_info():
    try:
        status = subprocess.check_output(
            ["playerctl", "-p", TARGET_PLAYER, "status"], 
            stderr=subprocess.DEVNULL, 
            text=True
        ).strip()
        
        if not status:
            return None
         
        icon = "󰐊" if status == "Paused" else "󰏤"

        metadata = subprocess.check_output(
            ["playerctl", "-p", TARGET_PLAYER, "metadata", "--format", "{{ artist }} - {{ title }}"],
            stderr=subprocess.DEVNULL,
            text=True
        ).strip()

        if not metadata or metadata == " - ":
            return None

        max_len = 45
        display_text = (metadata[:max_len] + "..") if len(metadata) > max_len else metadata
        
        return f" {icon} {display_text} "
    except Exception:
        return None



def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    draw_tab_with_powerline(
        draw_data, screen, tab, before, max_title_length, index, is_last, extra_data
    )

    if is_last:
        draw_right_status(screen)
        
    return screen.cursor.x
