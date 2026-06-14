pragma ComponentBehavior: Bound

import QtQuick

import Quickshell
import Quickshell.Hyprland

import qs
import qs.style as Style
import qs.screens.bar as Bar

import "../modules/util.js" as Util

Scope {
  id: root

  required property bool vertical
  required property bool summaryGroups

  signal rotate
  signal switchSummaries

  required property int barWidth
  required property int barHeight

  required property int floatingGap

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: bar

      required property var modelData

      screen: modelData
      aboveWindows: true

      readonly property bool vertical: root.vertical

      readonly property HyprlandMonitor monitor: Hyprland.monitorFor(screen)
      readonly property HyprlandWorkspace activeWs: monitor.activeWorkspace
      readonly property list<HyprlandToplevel> toplevels: (activeWs?.toplevels?.values ?? []).filter(ws => !Util.isEmpty(ws.lastIpcObject))

      readonly property int tilingWindowCount: toplevels.filter(toplevel => !toplevel.lastIpcObject.floating).length
      readonly property bool workspaceIsFullscreen: toplevels.some(toplevel => toplevel.lastIpcObject.fullscreen != 0)

      readonly property bool floatingBar: tilingWindowCount != 1 && !workspaceIsFullscreen
      readonly property int activeGap: floatingBar ? root.floatingGap : 0

      anchors {
        top: true
        left: true
        right: !vertical
        bottom: vertical
      }

      implicitWidth: root.barWidth
      implicitHeight: root.barHeight

      color: "transparent"

      margins {
        top: activeGap
        left: activeGap
        right: vertical ? 0 : activeGap
        bottom: vertical ? activeGap : 0
      }

      Rectangle {
        anchors.fill: parent
        radius: bar.floatingBar ? Global.theme.surfaceRounding : 0

        Behavior on radius {
          Style.Animation {}
        }

        clip: true
        color: Global.theme.surfaceBackground
        border.width: bar.floatingBar ? 1 : 0
        border.color: Global.theme.surfaceBorderColor

        // Following 2 rectangles behave like single-edge borders when !floatingBar

        Rectangle {
          visible: !bar.vertical && !bar.floatingBar
          anchors.bottom: parent.bottom
          width: parent.width
          height: 1
          color: Global.theme.surfaceBorderColor
        }

        Rectangle {
          visible: bar.vertical && !bar.floatingBar
          anchors.right: parent.right
          width: 1
          height: parent.height
          color: Global.theme.surfaceBorderColor
        }
      }

      Bar.Contents {
        anchors.fill: parent

        vertical: root.vertical
        summaryGroups: root.summaryGroups
        hyprMonitor: bar.monitor

        onRotate: root.rotate()
        onSwitchSummaries: root.switchSummaries()
      }
    }
  }
}
