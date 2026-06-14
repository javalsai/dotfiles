import QtQuick
import QtQuick.Controls

Slider {
  id: control

  required property color color
  required property color highlight

  required property real barHeight
  required property real handleRadius

  property int rtPosition: 0
  signal update(newPosition: int)

  onMoved: rtPosition = value
  onPressedChanged: if (!pressed)
    update(rtPosition)

  from: 0
  touchDragThreshold: 50

  background: Rectangle {
    x: control.leftPadding
    y: control.topPadding + control.availableHeight / 2 - height / 2
    width: control.availableWidth
    height: control.barHeight
    radius: control.barHeight / 2
    color: control.color

    HoverHandler {
      id: slider_hover

      enabled: control.enabled
      acceptedDevices: PointerDevice.All
      cursorShape: Qt.PointingHandCursor
    }
  }

  handle: Rectangle {
    property bool activeInAnyWay: control.pressed || slider_hover.hovered

    x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
    y: control.topPadding + control.availableHeight / 2 - height / 2
    implicitWidth: control.handleRadius * 2
    implicitHeight: control.handleRadius * 2
    radius: control.handleRadius
    color: activeInAnyWay ? control.highlight : control.color
  }
}
