import QtQuick
import Quickshell

import qs
import qs.default as Default
import qs.components.popup as Popup

Default.PopupButton {
  id: root

  required property SystemClock clock

  implicitWidth: horizontal.implicitWidth + (GState.button_h_spacing * 2)
  implicitHeight: horizontal.implicitHeight + (GState.button_v_spacing * 2)

  Default.Text {
    id: horizontal

    font.pixelSize: GState.font_size * (GState.vertical_layout ? 1.4 : 1)

    text: Qt.formatDateTime(root.clock.date, GState.vertical_layout ? "hh\nmm\nss" : "yyyy-MM-dd hh:mm:ss")
  }

  popup_window: Popup.TimeAndDate {
    clock: root.clock
    anchored: root
  }
}
