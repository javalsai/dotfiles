import QtQuick
import QtQuick.Controls

import qs

Item {
  id: root

  property alias text: text.text
  property alias placeholderText: text.placeholderText

  property bool cursorVisible: true
  property bool startFocused: true

  property int fontScale: 1
  property int margin: 8 // TODO

  property alias textField: text

  implicitHeight: 2 * margin + fontScale * Global.theme.fontSize

  Rectangle {
    anchors.fill: parent

    // TODO: idk if these 2 colors are the ones
    color: Global.theme.surfaceBackground
    border.color: Global.theme.surfaceBorderColor
    border.width: 4 // TODO: qualify
    radius: height / 2

    TextField {
      id: text

      background: Item {}

      anchors.fill: parent
      anchors.leftMargin: root.margin
      anchors.rightMargin: root.margin
      // anchors.margins: root.margin // used to use with TextInput

      font.family: Global.theme.defaultFont
      font.pixelSize: root.fontScale * Global.theme.fontSize

      selectionColor: Global.theme.primary
      cursorVisible: root.cursorVisible && activeFocus

      color: Global.theme.text
      placeholderTextColor: Global.theme.unimportantText

      Component.onCompleted: {
        if (root.startFocused)
          forceActiveFocus();
      }
    }
  }
}

