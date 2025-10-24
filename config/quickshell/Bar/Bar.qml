import Quickshell
import QtQuick
import QtQuick.Layouts

import qs
import qs.Bar.Widgets

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            property var modelData
            screen: modelData
            color: Config.barBackground
            implicitHeight: Config.barHeight

            anchors {
                left: true
                right: true
                top: true
            }

            RowLayout {
                id: bar

                RowLayout {
                    Layout.alignment: Qt.AlignLeft
                    SystemMenuWidget {                    
                        Layout.leftMargin: 20
                    }

                    ActiveWindowWidget {}
                }

                RowLayout {
                    Layout.alignment: Qt.AlignRight
                    CalendarWidget {}
                    ClockWidget {
                    }
                }
            }
        }
    }
}
