pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Quickshell

import qs
import qs.util as Util
import qs.default as Default
import qs.components as Components

Default.PopupWindow {
  id: root

  required property SystemClock clock
  property int daySeconds: (((clock.hours * 60) + clock.minutes) * 60) + clock.seconds

  implicitWidth: content.implicitWidth + 4 * HyprlandConfig.gaps_out
  implicitHeight: content.implicitHeight + 3 * HyprlandConfig.gaps_out
  alignment: Qt.AlignCenter

  function ordinal(n) {
    if (n % 100 >= 11 && n % 100 <= 13)
      return n + "th";

    switch (n % 10) {
    case 1:
      return n + "st";
    case 2:
      return n + "nd";
    case 3:
      return n + "rd";
    default:
      return n + "th";
    }
  }

  RowLayout {
    id: content

    anchors.centerIn: parent
    spacing: HyprlandConfig.gaps_out * 2

    ColumnLayout {
      Layout.alignment: Qt.AlignVCenter
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

    ColumnLayout {
      id: calendarChooser

      Layout.alignment: Qt.AlignVCenter
      spacing: HyprlandConfig.gaps_out

      readonly property date currentDate: new Date(root.clock.date.getFullYear(), root.clock.date.getMonth(), root.clock.date.getDate())

      property date date
      Component.onCompleted: {
        let copyDate = new Date(currentDate.getFullYear(), currentDate.getMonth());
        date = copyDate;
      }

      Default.Text {
        Layout.fillWidth: true
        horizontalAlignment: Qt.AlignLeft
        font.pixelSize: GState.font_size * 1.75
        text: `${Qt.formatDate(calendarChooser.currentDate, "MMMM")} ${root.ordinal(calendarChooser.currentDate.getDate())}`
      }

      Default.Text {
        Layout.fillWidth: true
        text: Qt.formatDate(calendarChooser.date, "MMMM yyyy")
      }

      Item {
        implicitWidth: calendarView.implicitWidth
        implicitHeight: calendarView.implicitHeight

        Components.Calendar {
          id: calendarView

          anchors.fill: parent

          today: calendarChooser.currentDate
          startMonthDate: calendarChooser.date
        }

        MouseArea {
          anchors.fill: parent

          acceptedButtons: Qt.AllButtons
          onPressed: mouse => {
            if (mouse.button === Qt.MiddleButton) {
              // reset date
              calendarChooser.date = new Date(calendarChooser.currentDate.getFullYear(), calendarChooser.currentDate.getMonth());
              mouse.accepted = true;
            }
            calendarChooser.date = new Date(calendarChooser.currentDate.getFullYear(), calendarChooser.currentDate.getMonth(), 1);
          }

          scrollGestureEnabled: true
          onWheel: wheel => {
            let isBigStep = wheel.modifiers & Qt.ControlModifier;

            if (wheel.angleDelta.y > 0) {
              // up
              if (isBigStep) {
                calendarChooser.date = new Date(calendarChooser.date.getFullYear() - 1, calendarChooser.date.getMonth());
              } else {
                calendarChooser.date = new Date(calendarChooser.date.getFullYear(), calendarChooser.date.getMonth() - 1);
              }
              wheel.accepted = true;
            } else if (wheel.angleDelta.y < 0) {
              // down
              if (isBigStep) {
                calendarChooser.date = new Date(calendarChooser.date.getFullYear() + 1, calendarChooser.date.getMonth());
              } else {
                calendarChooser.date = new Date(calendarChooser.date.getFullYear(), calendarChooser.date.getMonth() + 1);
              }
              wheel.accepted = true;
            }
          }
        }
      }
    }
  }
}
