# pyright: reportMissingImports=false

from subprocess import STDOUT, check_output
import sys
import re

from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    Formatter,
    TabBarData,
    as_rgb,
    draw_attributed_string,
    draw_tab_with_powerline,
)

timer_id = None

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
    global timer_id

    if timer_id is None:
        timer_id = add_timer(_redraw_tab_bar, 10.0, True)

    draw_tab_with_powerline(
        draw_data, screen, tab, before, max_title_length, index, is_last, extra_data
    )
    if is_last:
        draw_right_status(draw_data, screen)
    return screen.cursor.x


def draw_right_status(draw_data: DrawData, screen: Screen) -> None:
    # The tabs may have left some formats enabled. Disable them now.
    draw_attributed_string(Formatter.reset, screen)
    cells = create_cells()

    # Drop cells that wont fit
    while True:
        if not cells:
            return

        padding = screen.columns - screen.cursor.x - sum(len(c) + 3 for c in cells)
        if padding >= 0:
            break
        cells = cells[1:]

    if padding:
        screen.draw(" " * padding)

    tab_bg = as_rgb(int(draw_data.inactive_bg))
    tab_fg = as_rgb(int(draw_data.inactive_fg))
    default_bg = as_rgb(int(draw_data.default_bg))

    for cell in cells:
        # Draw the separator
        if cell == cells[0]:
            screen.cursor.fg = tab_bg
            screen.draw("")
        else:
            screen.cursor.fg = default_bg
            screen.cursor.bg = tab_bg
            screen.draw("")
        screen.cursor.fg = tab_fg
        screen.cursor.bg = tab_bg
        screen.draw(f" {cell} ")


def create_cells() -> list[str]:
    cells = [
        _get_kube_context(),
        _get_batt(),
        _get_cpu(),
    ]

    return [c for c in cells if c]

def _get_kube_context() -> str:
    try:
        out = check_output(["/opt/homebrew/bin/kubectl", "config", "current-context"], stderr=STDOUT, timeout=2).decode(sys.stdout.encoding).strip()
    except Exception as e:
        return ""

    if out == "minikube" or out == "colima":
        return ""

    if out.startswith("gke"):
        parts = out.split("_") # gke_project_region_name
        return f"☁️ {parts[1]}"

    return out

batt_re = re.compile('(\d+)\%\;')
def _get_batt() -> str:
    try:
        out = check_output(["/usr/bin/pmset", "-g", "batt"], stderr=STDOUT, timeout=2).decode(sys.stdout.encoding).strip()
    except Exception as e:
        return ""

    batt = batt_re.search(out)

    if batt is not None:
        return f"󰄌 {batt.group(1)}%"

    return ""

cpu_re = re.compile(r"load averages: ([0-9\.]+)")
def _get_cpu() -> str:
    try:
        out = check_output(["/usr/bin/uptime"], stderr=STDOUT, timeout=2).decode(sys.stdout.encoding).strip()
    except Exception as e:
        return ""

    load = cpu_re.search(out)

    if load is not None:
        return f" {load.group(1)}"

    return ""


def _redraw_tab_bar(timer_id):
    for tm in get_boss().all_tab_managers:
        tm.mark_tab_bar_dirty()
