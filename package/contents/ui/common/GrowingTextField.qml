import QtQuick 2.7
import QtQuick.Controls 2.0

TextField {
    id: textField
    implicitWidth: Math.min(300, Math.max(30, hiddenTextInput.contentWidth + 16))
    horizontalAlignment: TextInput.AlignHCenter

    TextInput {
        id: hiddenTextInput
        visible: false
        text: textField.text
    }
}
