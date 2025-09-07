import QtQuick

DefaultText {
  id: horizontal

  font.pixelSize: GState.font_size * 1.4
  text: Qt.formatDateTime(clock.date, "hh\nmm\nss")
}
