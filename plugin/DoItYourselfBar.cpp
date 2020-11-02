#include "DoItYourselfBar.hpp"

#include <QDBusConnection>
#include <QDebug>
#include <QVariantList>

#include "BlockInfo.hpp"

DoItYourselfBar::DoItYourselfBar(QObject* parent) :
        QObject(parent),
        dbusService(parent),
        dbusInstanceId(0),
        cfg_DBusInstanceId(0) {

    QObject::connect(&dbusService, &DBusService::dataPassed,
                     this, &DoItYourselfBar::handlePassedData);
}

void DoItYourselfBar::cfg_DBusInstanceIdChanged() {
    auto sessionBus = QDBusConnection::sessionBus();
    sessionBus.registerService(SERVICE_NAME);

    if (dbusInstanceId != 0) {
        QString path = "/id_" + QString::number(dbusInstanceId);
        sessionBus.unregisterObject(path, QDBusConnection::UnregisterTree);
    }

    bool dbusSuccess = false;

    if (cfg_DBusInstanceId != 0) {
        QString path = "/id_" + QString::number(cfg_DBusInstanceId);
        if (sessionBus.registerObject(path, QString(SERVICE_NAME),
                                      &dbusService, QDBusConnection::ExportAllSlots)) {
            dbusSuccess = true;
            dbusInstanceId = cfg_DBusInstanceId;
        }
    }

    emit dbusSuccessChanged(dbusSuccess);
}

void DoItYourselfBar::handlePassedData(QString data) {
    QVariantList blockInfoList;

    BlockInfo blockInfo;
    int separatorCount = 0;

    for (int i = 0; i < data.length(); i++) {
        QChar character = data.at(i);

        if (character == QChar('|')) {
            separatorCount++;

            if (separatorCount == 5) {
                blockInfo.style = blockInfo.style.trimmed();
                blockInfo.labelText = blockInfo.labelText.trimmed();
                blockInfo.tooltipText = blockInfo.tooltipText.trimmed();
                blockInfo.commandToExecOnClick = blockInfo.commandToExecOnClick.trimmed();

                blockInfoList << blockInfo.toQVariantMap();

                blockInfo = BlockInfo();

                separatorCount = 0;
            }

            continue;
        }

        if (separatorCount == 1) {
            blockInfo.style += character;
        } else if (separatorCount == 2) {
            blockInfo.labelText += character;
        } else if (separatorCount == 3) {
            blockInfo.tooltipText += character;
        } else if (separatorCount == 4) {
            blockInfo.commandToExecOnClick += character;
        } else {
            separatorCount = -1;
        }
    }
}
