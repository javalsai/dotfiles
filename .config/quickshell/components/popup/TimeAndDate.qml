pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Quickshell

import qs
import qs.default as Default
import qs.components as Components

Default.PopupWindow {
  id: root

  required property SystemClock clock
  property int daySeconds: (((clock.hours * 60) + clock.minutes) * 60) + clock.seconds

  implicitWidth: content.implicitWidth + 2 * HyprlandConfig.gaps_out
  implicitHeight: content.implicitHeight + 2 * HyprlandConfig.gaps_out
  alignment: Qt.AlignCenter

  RowLayout {
    id: content

    anchors.centerIn: parent
    spacing: HyprlandConfig.gaps_out * 2

    ColumnLayout {
      spacing: HyprlandConfig.gaps_out

      Components.Clock {
        daySeconds: root.daySeconds
        r: 100
      }

      Default.Text {
        Layout.alignment: Qt.AlignHCenter
        text: `Day is ${(root.daySeconds * 100 / 86400).toFixed(2)}% over`
      }
    }

    Default.Text {
      text: "TODO calendar"
    }
  }
}
