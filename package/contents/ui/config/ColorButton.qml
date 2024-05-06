import QtQuick 2.7
import QtQuick.Controls 2.15
import QtQuick.Dialogs

Button {
    id: button
    enabled: false
    implicitWidth: 25
    implicitHeight: 20
    opacity: enabled ? 1 : 0.3

    property string color
    property var colorAcceptedCallback

    style: ButtonStyle {
        background: Rectangle {
            radius: 4
            border.width: 1
            color: button.color
            border.color: "gray"
        }
    }

    ColorDialog {
        id: dialog
        title: "Choose a color"
        showAlphaChannel: true
        visible: false
        onAccepted: {
            button.color = color;
            colorAcceptedCallback(color);
            dialog.visible = false;
        }
    }

    onClicked: dialog.visible = true

    Component.onCompleted: dialog.color = color
}
