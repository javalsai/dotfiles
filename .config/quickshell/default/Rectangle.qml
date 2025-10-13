import QtQuick

Rectangle {
    radius: 2

    Behavior on opacity {
      NumberAnimation {
        duration: 200
        easing.type: Easing.OutCubic
      }
    }
  }
