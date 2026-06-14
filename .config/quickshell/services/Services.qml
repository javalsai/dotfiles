import QtQuick

import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire

import qs
import qs.services.connections as Connections

Scope {
  id: root

  readonly property alias mpris: mpris
  readonly property alias sysInfo: sysInfo
  readonly property alias persistentConfig: persistentConfig
  readonly property alias hyprlandConfig: hyprlandConfig

  readonly property SystemClock clock: SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }

  FileView {
    path: Qt.resolvedUrl("../config.json")

    watchChanges: true
    onFileChanged: reload()
    onAdapterUpdated: writeAdapter()

    JsonAdapter {
      id: persistentConfig
      property bool verticalLayout: false
      property bool summarizeGroups: true
    }
  }

  readonly property list<string> gifsList: gifsListFile.text().trim().split(' ')
  FileView {
    id: gifsListFile
    path: Qt.resolvedUrl(`${Global.constants.assetsUrl}/gifs.list`)
    blockLoading: true
  }

  HyprlandConfig {
    id: hyprlandConfig
  }

  Connections.HyprlandIpc {
    onConfigReloaded: hyprlandConfig.reload()
  }

  Connections.Mpris {
    id: mpris
  }

  Connections.Pipewire {
    objects: [Pipewire.defaultAudioSink]
  }

  Connections.SystemInfo {
    id: sysInfo
  }
}
