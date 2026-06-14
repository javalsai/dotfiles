pragma ComponentBehavior: Bound

import QtQuick

import Quickshell.Hyprland

import qs
import qs.style as Style
import qs.widgets as Widgets

import "../../modules/util.js" as Util

Loader {
  id: root

  required property HyprlandWorkspace modelData
  required property HyprlandMonitor thisMonitor

  property HyprlandWorkspace workspace: modelData

  // TODO: I think I might disregard isFocused as I dont care that much, use underlining for activeness and just use white for text.

  readonly property bool isSpecial: workspace.name.startsWith('special:')
  readonly property bool isMain: workspace.id == root.thisMonitor.activeWorkspace?.id
  readonly property bool isActive: workspace.active
  readonly property bool isFocused: workspace.focused

  active: !Util.isEmpty(modelData)

  sourceComponent: Style.IconButton {
    id: button

    property bool inverted: root.isMain

    backgroundColor: Global.theme.primary
    backgroundOpacity: inverted ? 0.5 : implicitBackgroundOpacity

    clickable: !root.isSpecial
    onClicked: if (clickable)
      root.workspace.activate()

    Widgets.FontIcon {
      fontType: Global.theme.defaultFont
      iconScale: 1

      font.underline: root.isFocused

      text: root.isSpecial ? Global.attrs.specialWsPrettyName : root.workspace.name
      color: root.isActive ? Global.theme.primary : root.isSpecial ? Global.theme.accent : Global.theme.text
      opacity: button.inverted ? (1 - button.implicitBackgroundOpacity) : 1
    }
  }
}
