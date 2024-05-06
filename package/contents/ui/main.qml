import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import org.kde.kquickcontrolsaddons 2.0
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid

import org.kde.plasma.doityourselfbar 1.0

import 'applet'

PlasmoidItem {
    id: root

    BlockButtonTooltip { id: tooltip }
    
    fullRepresentation: Container { id: container }
    preferredRepresentation: fullRepresentation

    property QtObject config: Plasmoid.configuration

    property bool isTopLocation: Plasmoid.location == PlasmaCore.Types.TopEdge
    property bool isVerticalOrientation: Plasmoid.formFactor == PlasmaCore.Types.Vertical

    DoItYourselfBar {
        id: backend

        cfg_DBusInstanceId: config.DBusInstanceId
        cfg_StartupScriptPath: config.StartupScriptPath
    }

    Connections {
        target: backend

        // Because plasmoid.nativeInterface is unavailable for this kind
        // of a plugin (must be a Plasma::Applet library or something),
        // a hack is needed to be able to detect the success in the config
        // dialog, so I use an additional config property and update it
        // with a value received from the C++ backend. This causes the config
        // dialog to read this property and show D-Bus service status.
        function onDbusSuccessChanged() {
            config.DBusSuccess = dbusSuccess
        }

        function onInvalidDataFormatDetected() {
            // Plasmoid.fullRepresentationItem.addErrorBlockButton()
            container.addErrorBlockButton()
        }

        function onBlockInfoListSent() {
            // Plasmoid.fullRepresentationItem.update(blockInfoList)
            container.update(blockInfoList)
        }
    }
}
