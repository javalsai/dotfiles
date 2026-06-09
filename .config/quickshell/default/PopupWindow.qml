import Quickshell

import QtQml
import QtQuick

import qs

PopupWindow {
  id: root

  required property Item anchored
  required property int alignment // Qt.Alignment

  property int anchorYOffset: anchored.height / 2
  property int anchorXOffset: anchored.width / 2

  // TODO: I think I prefer always center but shifting into the screen if out though
  // IF vertical layout
  property int offsetY: alignment & Qt.AlignTop ? -root.height : alignment & Qt.AlignVCenter ? -root.height / 2 : 0
  // IF horizontal layout
  property int offsetX: alignment & Qt.AlignLeft ? -root.width : alignment & Qt.AlignHCenter ? -root.width / 2 : 0

  visible: false

  grabFocus: true

  color: "transparent"

  anchor {
    item: anchored

    rect.y: GState.vertical_layout ? root.anchorYOffset + root.offsetY : (GState.bar_height + HyprlandConfig.gaps_out)
    rect.x: GState.vertical_layout ? (GState.bar_width + HyprlandConfig.gaps_out) : root.anchorXOffset + root.offsetX
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
