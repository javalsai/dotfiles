import QtQuick
import Quickshell

import qs;
import qs.default as Default;

Default.Text {
  id: horizontal

  font.pixelSize:  GState.font_size * (GState.vertical_layout ? 1.4 : 1)

  required property SystemClock clock
  text: Qt.formatDateTime(clock.date, GState.vertical_layout ? "hh\nmm\nss" :  "yyyy-MM-dd hh:mm:ss")
}
