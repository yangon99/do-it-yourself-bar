import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ColumnLayout {
    spacing: 0

    property string text

    Item {
        height: 10
    }

    Label {
        font.pixelSize: theme.defaultFont.pixelSize + 4
        text: parent.text
    }

    Item {
        height: 1
    }
}