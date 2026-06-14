import QtQml
import QtQuick

import Quickshell

import qs.style as Style

PopupWindow {
  id: root

  required property bool vertical
  required property Item anchored
  required property int alignment // Qt.Alignment

  required property int gap

  property int anchorYOffset: anchored.height / 2
  property int anchorXOffset: anchored.width / 2

  // TODO: I think I prefer always center but shifting into the screen if out though
  readonly property int offsetY: alignment & Qt.AlignTop ? -root.height : alignment & Qt.AlignVCenter ? -root.height / 2 : 0
  readonly property int offsetX: alignment & Qt.AlignLeft ? -root.width : alignment & Qt.AlignHCenter ? -root.width / 2 : 0

  visible: false
  grabFocus: true
  color: "transparent"

  anchor {
    item: anchored

    rect.y: vertical ? root.anchorYOffset + root.offsetY : (root.anchorYOffset + gap)
    rect.x: vertical ? (root.anchorXOffset + gap) : root.anchorXOffset + root.offsetX
  }

  // default property alias contents: rectangle.data

  Style.SurfaceRectangle {
    anchors.fill: parent
  }
}
