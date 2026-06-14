import QtQuick
import QtQuick.Layouts

import Quickshell

import qs
import qs.style as Style

import qs.features.timedate
import qs.features.timedate.analogue as AnalogueClock
import qs.features.timedate.picker as TimeDatePicker
import "../../modules/util.js" as Util
import "../../modules/dateUtil.js" as DateUtil

RowLayout {
  id: root

  required property SystemClock clock
  property int daySeconds: (((clock.hours * 60) + clock.minutes) * 60) + clock.seconds

  spacing: Global.theme.fontSize

  ColumnLayout {
    Layout.alignment: Qt.AlignVCenter
    spacing: Global.theme.fontSize

    AnalogueClock.AnalogueClock {
      daySeconds: root.daySeconds
      r: Global.theme.fontSize * 5.5

      mainColor: Global.theme.text
      minuteMarkerColor: Global.theme.backgroundText
    }

    Style.Text {
      Layout.alignment: Qt.AlignHCenter
      text: `Day is ${(root.daySeconds * 100 / 86400).toFixed(2)}% over`
    }
  }

  ColumnLayout {
    id: calendar

    Layout.alignment: Qt.AlignVCenter
    spacing: Global.theme.fontSize / 2

    readonly property date currentDate: DateUtil.copyDateDay(root.clock.date)

    Style.Text {
      Layout.fillWidth: true
      horizontalAlignment: Qt.AlignLeft

      em: 1.75
      text: `${Qt.formatDate(calendar.currentDate, "MMMM")} ${Util.ordinal(calendar.currentDate.getDate())}`
    }

    Style.Text {
      Layout.fillWidth: true
      text: Qt.formatDate(monthPicker.pickedDate, "MMMM yyyy")
    }

    Item {
      implicitWidth: calendarGrid.implicitWidth
      implicitHeight: calendarGrid.implicitHeight

      TimeDatePicker.Month {
        id: monthPicker
        anchors.fill: parent

        initialDate: DateUtil.copyDateMonth(calendar.currentDate)
      }

      DateCalendar {
        id: calendarGrid
        todayHighlight: calendar.currentDate
        startMonthDate: monthPicker.pickedDate
      }
    }
  }
}
