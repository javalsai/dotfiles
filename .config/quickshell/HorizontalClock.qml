import QtQuick

DefaultText {
  id: horizontal

  text: Qt.formatDateTime(clock.date, "yyyy-MM-dd hh:mm:ss")
}
