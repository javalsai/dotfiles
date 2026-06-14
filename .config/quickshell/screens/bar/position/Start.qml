pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Quickshell.Hyprland

import qs
import qs.style as Style
import qs.widgets as Widgets
import qs.features.player
import qs.features.workspaces

Widgets.DirectionLayout {
  id: root

  spacing: Global.theme.barSpacing

  signal rotate
  signal switchSummaries

  required property HyprlandMonitor hyprMonitor

  Style.IconButton {
    Layout.alignment: Qt.AlignCenter

    contentIcon: Global.attrs.distroIcon
    onClicked: root.rotate()
    onRightClicked: mouse => {
      root.switchSummaries();
      mouse.accepted = true;
    }
  }

  Repeater {
    model: Hyprland.workspaces.values.filter(item => item !== null)

    WorkspaceButton {
      Layout.alignment: Qt.AlignCenter
      thisMonitor: root.hyprMonitor
    }
  }

  Loader {
    active: !!Global.services.mpris.player

    sourceComponent: PlayerButton {
      Layout.alignment: Qt.AlignCenter
      player: Global.services.mpris.player
      isPlayerctld: Global.services.mpris.isPlayerctld
      vertical: root.vertical
      alignment: Qt.AlignRight | Qt.AlignBottom
    }
  }
}
