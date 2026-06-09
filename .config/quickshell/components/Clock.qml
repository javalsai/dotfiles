pragma ComponentBehavior: Bound

import QtQuick

import Quickshell

import qs.components.clock as Clock

Rectangle {
  id: root

  required property int daySeconds

  required property int r
  radius: r

  implicitWidth: radius * 2
  implicitHeight: radius * 2

  color: "transparent"

  border.width: 4
  border.color: "#c0c0c0"

  Repeater {
    model: 60

    Rectangle {
      required property int index

      width: index % 5 === 0 ? 3 : 1
      height: index % 5 === 0 ? 10 : 5

      readonly property real angle: index * Math.PI / 30

      readonly property real r: root.width / 2 - 10

      x: root.width / 2 + Math.sin(angle) * r - width / 2
      y: root.height / 2 - Math.cos(angle) * r - height / 2

      rotation: index * 6

      color: "#555"
    }
  }

  Clock.Hand {
    thickness: 6
    length: root.width * 0.22
    angle: (root.daySeconds % 43200) * 360 / 43200
  }

  Clock.Hand {
    thickness: 3
    length: root.width * 0.35
    angle: (root.daySeconds % 3600) * 360 / 3600
  }

  Clock.Hand {
    thickness: 1
    length: root.width * 0.4
    angle: (root.daySeconds % 60) * 360 / 60
  }
}
