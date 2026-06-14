pragma ComponentBehavior: Bound

import QtQuick

import Quickshell

import qs
import qs.style as Style

import qs.features.timedate

Style.Button {
  id: root

  required property bool vertical
  required property SystemClock clock
  required property int alignment

  implicitWidth: innerText.implicitWidth + Global.theme.buttonHPadding * 2
  implicitHeight: innerText.implicitHeight + Global.theme.buttonVPadding * 2

  Style.Text {
    id: innerText
    em: root.vertical ? 1.4 : 1

    text: Qt.formatDateTime(root.clock.date, root.vertical ? "hh\nmm\nss" : "yyyy-MM-dd hh:mm:ss")
  }

  popupWindow: Style.PopupWindow {
    id: popup

    vertical: root.vertical
    alignment: root.alignment
    anchored: root
    content: timedateCenter

    TimeDateCenter {
      id: timedateCenter
      anchors.centerIn: parent

      clock: root.clock
    }
  }
}
