import Quickshell

import QtQuick

import qs

PopupWindow {
  required property Item anchored
  visible: false

  // only after `dca6523`, still only in `-git` as of rn
  grabFocus: true

  color: "transparent"

  anchor {
    item: anchored

    rect.y: GState.vertical_layout ? 0 : (GState.bar_height + HyprlandConfig.gaps_out)
    rect.x: GState.vertical_layout ? (GState.bar_width + HyprlandConfig.gaps_out) : 0
  }

  default property alias contents: rectangle.data

  Rectangle {
    id: rectangle

    anchors.fill: parent
    radius: HyprlandConfig.rounding

    clip: true

    color: GState.theme.background
  }
}
