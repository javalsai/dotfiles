import QtQuick
import QtQuick.Controls

import qs
import qs.default as Default

Button {
  id: button

  property int implicits: GState.font_size * 1.5
  property real backgroundOpacity: 1
  property color backgroundColor
  required property bool clickable
  default required property Item content

  padding: 0

  contentItem: content

  background: Default.Rectangle {
    implicitWidth: button.content.implicitWidth
    implicitHeight: button.content.implicitHeight

    opacity: button.backgroundOpacity
    color: button.backgroundColor
  }

  HoverHandler {
    enabled: button.clickable
    acceptedDevices: PointerDevice.All
    cursorShape: Qt.PointingHandCursor
  }
}
