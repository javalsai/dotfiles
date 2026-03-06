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
    backgroundOpacity: hovered ? GState.hover_color_opac : 0

    onClicked: GState.vertical_layout = !GState.vertical_layout

    clickable: true

    implicitWidth: GState.font_size * 1.7
    implicitHeight: GState.font_size * 1.7

    Layout.alignment: Qt.AlignCenter

    Default.Icon {
      id: logo
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
