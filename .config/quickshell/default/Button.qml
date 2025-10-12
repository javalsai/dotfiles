import QtQuick
import QtQuick.Controls

import qs;

Button {
  id: button

  property int implicits: GState.font_size * 1.5
  property real backgroundOpacity: 1
  property color backgroundColor
  required property bool clickable
  required default property Item content

  padding: 0

  contentItem: content

  background: Rectangle {
    implicitWidth: button.implicits
    implicitHeight: button.implicits

    opacity: button.backgroundOpacity // button.hovered ? .3 : 0
    color: button.backgroundColor
    radius: 2

    Behavior on opacity {
      NumberAnimation {
        duration: 200
        easing.type: Easing.OutCubic
      }
    }
  }

  // TODO: if onClicked
  HoverHandler {
    enabled: button.clickable
    acceptedDevices: PointerDevice.All | PointerDevice.Stylus
    cursorShape: Qt.PointingHandCursor
  }
}
