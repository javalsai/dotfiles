pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland

import QtQuick

import qs
import qs.default as Default
import qs.util as Util

Scope {
  id: root

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: bar

      required property var modelData

      screen: modelData
      aboveWindows: GState.vertical_layout

      property HyprlandMonitor hyprlandMonitor: Hyprland.monitorFor(screen)
      property HyprlandWorkspace hyprlandWorkspace: hyprlandMonitor.activeWorkspace
      // filter non uninitialized ipc toplevels
      property list<var> toplevels: (hyprlandWorkspace?.toplevels?.values ?? []).filter(toplevel => "floating" in toplevel.lastIpcObject)
      property int tilingWindowCount: toplevels.filter(toplevel => !toplevel.lastIpcObject.floating).length ?? 1
      property bool floatingBar: tilingWindowCount != 1

      property int margin: floatingBar ? HyprlandConfig.gaps_out : 0

      anchors {
        top: true
        left: true
        right: !GState.vertical_layout
        bottom: GState.vertical_layout
      }

      margins {
        top: margin
        left: margin
        right: GState.vertical_layout ? 0 : margin
        bottom: GState.vertical_layout ? margin : 0
      }

      implicitHeight: GState.bar_height
      implicitWidth: GState.bar_width

      color: "transparent"

      Rectangle {
        anchors.fill: parent
        radius: bar.floatingBar ? HyprlandConfig.rounding : 0

        Behavior on radius {
          NumberAnimation {
            duration: 200
            easing.type: Easing.OutCubic
          }
        }

        clip: true
        color: GState.theme.background

        BarCenter {
          anchors.centerIn: parent
        }

        Default.DLayout {
          anchors.fill: parent

          rowSpacing: 0
          columnSpacing: 0

          BarLeft {
            hyprlandMonitor: bar.hyprlandMonitor
          }

          Util.Spacer {}

          BarRight {}
        }
      }
    }
  }
}
