pragma Singleton

import QtQuick
import Quickshell

Singleton {
    readonly property string playerctldDbusName: 'org.mpris.MediaPlayer2.playerctld'
    readonly property url assetsUrl: Qt.resolvedUrl('./assets/')
}
