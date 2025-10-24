pragma Singleton

import Quickshell
import Quickshell.Wayland

Singleton {
    readonly property var activeWindowTitle: {
        const active = ToplevelManager.activeToplevel;

        if (active != undefined && active.activated) {
            return active.title;
        }

        return "";
    }
}
