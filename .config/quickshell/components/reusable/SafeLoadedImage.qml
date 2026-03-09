/// Image that preserves ratio just fitting within X bounds and allows border radius
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Widgets

Rectangle {
  id: root

  required property int maxWidth
  required property int maxHeight
  property int radius: 0

  required property bool playing
  required property url source

  implicitWidth: maxWidth
  implicitHeight: maxHeight

  color: "transparent"

  ClippingRectangle {
    anchors.centerIn: parent

    implicitWidth: image.paintedWidth
    implicitHeight: image.paintedHeight

    clip: true
    radius: root.radius
    color: "transparent"

    AnimatedImage {
      id: image

      readonly property int sourceWidth: sourceSize.width
      readonly property int sourceHeight: sourceSize.height

      width: root.maxWidth
      height: root.maxHeight
      fillMode: Image.PreserveAspectFit
      anchors.centerIn: parent

      // cache: true
      playing: root.playing
      source: root.source
    }
  }
}
