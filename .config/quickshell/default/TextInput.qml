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
  property int margin: HyprlandConfig.gaps_out

  property alias textField: text

  implicitHeight: 2 * margin + fontScale * GState.font_size

  Rectangle {
    anchors.fill: parent

    color: GState.theme.background
    border.color: GState.theme.backgroundBorder
    border.width: 4
    radius: height / 2

    TextField {
      id: text

      background: Item {}

      anchors.fill: parent
      anchors.leftMargin: root.margin
      anchors.rightMargin: root.margin
      // anchors.margins: root.margin // used to use with TextInput

      font.family: GState.default_font_family
      font.pixelSize: root.fontScale * GState.font_size

      selectionColor: GState.theme.primary
      cursorVisible: root.cursorVisible && activeFocus

      color: GState.theme.text
      placeholderTextColor: GState.theme.unimportant_text

      Component.onCompleted: {
        if (root.startFocused)
          forceActiveFocus();
      }
    }
  }
}
