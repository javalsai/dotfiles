import QtQuick

import qs

Rectangle {
  radius: GState.button_radius

  Behavior on opacity {
    NumberAnimation {
      duration: GState.theme.fastAnimationSpeed
      easing.type: GState.theme.outEasing
    }
  }
}
