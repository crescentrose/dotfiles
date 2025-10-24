pragma Singleton

import QtQuick
import Quickshell

Singleton {
    readonly property color barBackground: Qt.rgba(0.094, 0.098, 0.149, 0.9) // catppuccin: crust
    readonly property color textColor: "#cad3f5" // catppuccin: text 
    readonly property color widgetBackground: "transparent"
    readonly property int fontSize: 14
    // readonly property var widgetBackground: "#24273a" // catppuccin: base

    readonly property int barHeight: 30

    readonly property font baseFont: ({
        family: "Inter",
        pixelSize: fontSize
    })

    readonly property font boldFont: ({
        family: "Inter",
        pixelSize: fontSize,
        bold: true,
    })
}
