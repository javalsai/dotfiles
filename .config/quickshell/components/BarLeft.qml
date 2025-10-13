pragma ComponentBehavior: Bound

import Quickshell.Hyprland

import QtQuick
import QtQuick.Layouts

import qs
import qs.default as Default
import qs.components.bar as Bar

Default.DLayout {
  id: root

  required property HyprlandMonitor hyprlandMonitor

  Default.Button {
    backgroundColor: GState.distro_color
    backgroundOpacity: hovered ? 0.3 : 0

    leftPadding: 3
    onClicked: GState.vertical_layout = !GState.vertical_layout

    clickable: true

    Layout.alignment: Qt.AlignCenter

    Default.Text {
      font.family: GState.icon_font_family
      color: GState.distro_color
      text: GState.distro_icon
    }
  }

  Repeater {
    model: Hyprland.workspaces

    Bar.WsButton {
      Layout.alignment: Qt.AlignCenter
      thisMonitor: root.hyprlandMonitor
    }
  }
}
