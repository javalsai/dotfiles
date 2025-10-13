import QtQuick
import Quickshell.Hyprland

import qs;
import qs.default as Default;

Item {
  id: root

  required property HyprlandWorkspace modelData
  required property HyprlandMonitor thisMonitor

  property HyprlandWorkspace workspace: modelData

  readonly property bool isSpecial: workspace.name.startsWith('special:')
  readonly property bool isMain: workspace.id == thisMonitor.activeWorkspace?.id
  readonly property bool isActive: workspace.active
  readonly property bool isFocused: workspace.focused

  readonly property string mappedName: if (isSpecial) {
    GState.special_ws_name;
  } else
    workspace.name

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  Default.Button {
    id: button

    backgroundOpacity: button.hovered ? .3 : 0
    backgroundColor: GState.theme.primary
    onClicked: root.workspace.activate()
    clickable: true

    Default.Text {
      font.underline: root.isFocused
      color: if (root.isActive) {
        GState.theme.primary;
      } else if (root.isSpecial) {
        GState.theme.accent;
      } else
        GState.theme.text

      text: if (root.isMain) {
        `「${root.mappedName}」`;
      } else
        root.mappedName
    }
  }
}
