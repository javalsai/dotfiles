import QtQuick
import Quickshell.Hyprland

import qs
import qs.default as Default

Default.Button {
  id: root

  required property HyprlandWorkspace modelData
  required property HyprlandMonitor thisMonitor

  property HyprlandWorkspace workspace: modelData

  readonly property bool isSpecial: workspace.name.startsWith('special:')
  readonly property bool isMain: workspace.id == thisMonitor.activeWorkspace?.id
  readonly property bool isActive: workspace.active
  readonly property bool isFocused: workspace.focused

  // TODO: I think I might disregard isFocused as I dont care that much, use underlining for activeness and just use white for text.

  property bool inverted: isMain

  backgroundColor: GState.theme.primary
  backgroundOpacity: inverted ? 0.5 : (hovered ? GState.hover_color_opac : 0)

  onClicked: root.workspace.activate()
  clickable: true

  implicitWidth: GState.font_size * 1.7
  implicitHeight: GState.font_size * 1.7

  Default.Text {
    anchors.centerIn: parent

    font.underline: root.isFocused

    color: root.isActive ? GState.theme.primary : root.isSpecial ? GState.theme.accent : GState.theme.text
    opacity: root.inverted && root.hovered ? (1 - GState.hover_color_opac) : 1

    text: root.isSpecial ? GState.special_ws_name : root.workspace.name
  }
}
