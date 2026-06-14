import QtQuick
import QtQuick.Controls

Button {
  id: button

  property bool virtualFocus: false
  readonly property bool hasAnyFocus: virtualFocus || hovered

  required property bool clickable
  default required property Item content
  contentItem: content

  signal rightClicked(mouse: MouseEvent)

  padding: 0

  MouseArea {
    anchors.fill: parent
    acceptedButtons: Qt.RightButton

    onClicked: function (mouse) {
      if (mouse.button === Qt.RightButton) {
        button.rightClicked(mouse);
      }
    }

    cursorShape: Qt.PointingHandCursor
  }
}
