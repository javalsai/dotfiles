import QtQuick

import qs

Rectangle {
  radius: GState.button_radius

  Behavior on opacity {
    NumberAnimation {
      duration: 200
      easing.type: Easing.OutCubic
    }
  }
}
