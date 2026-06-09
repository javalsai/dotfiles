pragma ComponentBehavior: Bound

import QtQuick

Rectangle {
  id: hand

  required property int thickness
  required property int length

  required property real angle

  width: thickness
  height: length
  radius: width / 2
  color: "#ddd"

  anchors.bottom: parent.verticalCenter
  anchors.horizontalCenter: parent.horizontalCenter

  y: -height + hand.radius

  transform: Rotation {
    origin.x: hand.width / 2
    origin.y: hand.height - hand.radius
    angle: hand.angle
  }
}
