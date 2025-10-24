pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs

Item {
    id: root
    property string text
    property string icon

    property color color: Config.widgetBackground
    property color textColor: Config.textColor
    property font font: Config.baseFont

    implicitHeight: rec.implicitHeight
    implicitWidth: rec.implicitWidth

    Rectangle {
        id: rec
        color: root.color
        anchors.centerIn: parent
        implicitHeight: Config.barHeight
        implicitWidth: layout.implicitWidth + 15

        RowLayout {
            id: layout
            anchors.fill: parent
            spacing: 10

            Text {
                text: root.text
                color: root.textColor
                font: root.font
                Layout.alignment: Qt.AlignVCenter
                Layout.leftMargin: 15
            }
        }
    }
}
