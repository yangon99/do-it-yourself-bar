import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import org.kde.kirigami as Kirigami

import "../common" as UICommon

Kirigami.Icon {
    roundToIconSize: false
    Layout.maximumWidth: 20
    Layout.maximumHeight: 20

    source: "help-contextual"

    property string tooltipText

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }

    Label{}
    // UICommon.TextTooltip {
    //     target: parent
    //     visible: mouseArea.containsMouse
    //     content: tooltipText
    // }
}
