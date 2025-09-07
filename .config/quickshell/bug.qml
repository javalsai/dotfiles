import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

ShellRoot {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: window
      required property var modelData
      screen: modelData

      property HyprlandMonitor hyprlandMonitor: Hyprland.monitorFor(screen)
      property HyprlandWorkspace hyprlandWorkspace: hyprlandMonitor.activeWorkspace
      property int tilingWindowCount: hyprlandWorkspace?.toplevels?.values?.filter(toplevel => !toplevel.lastIpcObject.floating)?.length ?? 1
      property bool floatingBar: tilingWindowCount != 1
      property int margin: floatingBar ? 12 : 0
      onMarginChanged: console.log(`${screen.name} margin is ${margin}`)

      implicitHeight: 30

      anchors {
        top: true
        left: true
        right: true
      }

      margins {
        top: margin
        left: margin
        right: margin
      }
    }
  }

  Connections {
    target: Hyprland
    function onRawEvent() {
      Hyprland.refreshMonitors();
      Hyprland.refreshWorkspaces();
      Hyprland.refreshToplevels();
    }
  }
}
