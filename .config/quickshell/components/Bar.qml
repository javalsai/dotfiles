pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland

import QtQuick
import QtQuick.Layouts

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
      aboveWindows: true

      property HyprlandMonitor hyprlandMonitor: Hyprland.monitorFor(screen)
      property HyprlandWorkspace hyprlandWorkspace: hyprlandMonitor.activeWorkspace
      // filter non uninitialized ipc toplevels
      property list<var> toplevels: (hyprlandWorkspace?.toplevels?.values ?? []).filter(toplevel => "floating" in toplevel.lastIpcObject)
      property int tilingWindowCount: toplevels.filter(toplevel => !toplevel.lastIpcObject.floating).length ?? 1

      // or EVEN better, see if the workspace has any fullscreen so it also works if other window is partially fullscreen and not focused
      property bool workspaceIsFullscreen: !!toplevels.find(toplevel => toplevel.lastIpcObject.fullscreen != 0) ?? false

      property bool floatingBar: tilingWindowCount != 1 && !workspaceIsFullscreen

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
            duration: GState.theme.animationSpeed
            easing.type: GState.theme.outEasing
          }
        }

        clip: true
        color: GState.theme.background
        border.width: bar.floatingBar ? 1 : 0
        border.color: GState.theme.backgroundBorder

        Rectangle {
          visible: !GState.vertical_layout && !bar.floatingBar
          anchors.bottom: parent.bottom
          width: parent.width
          height: 1
          color: GState.theme.backgroundBorder
        }

        Rectangle {
          visible: GState.vertical_layout && !bar.floatingBar
          anchors.right: parent.right
          width: 1
          height: parent.height
          color: GState.theme.backgroundBorder
        }

        BarCenter {
          anchors.centerIn: parent
        }

        Default.DLayout {
          readonly property int outer_margin: HyprlandConfig.rounding - GState.button_radius

          anchors {
            fill: parent
            leftMargin: GState.vertical_layout ? 0 : outer_margin
            rightMargin: anchors.leftMargin
            topMargin: GState.vertical_layout ? outer_margin : 0
            bottomMargin: anchors.topMargin
          }

          BarLeft {
            hyprlandMonitor: bar.hyprlandMonitor
            Layout.alignment: Qt.AlignCenter
          }

          Util.Spacer {}

          BarRight {
            Layout.alignment: Qt.AlignCenter
          }
        }
      }
    }
  }
}
