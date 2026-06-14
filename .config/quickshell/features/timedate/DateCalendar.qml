pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs
import qs.style as Style

import "../../modules/dateUtil.js" as DateUtil

GridLayout {
  id: root

  columns: 7
  rows: 5

  rowSpacing: Global.theme.fontSize * 1.25 / 4
  columnSpacing: Global.theme.fontSize * 1.25 / 2

  property list<string> weekDayLetters: ["l", "m", "x", "j", "v", "s", "d"]

  property date todayHighlight
  required property date startMonthDate

  property date startGridDate

  function updateStartGridDate() {
    let searchDate = DateUtil.copyDateDay(startMonthDate);

    let weekday = (searchDate.getDay() + 6) % 7;
    while (weekday != 0) {
      searchDate = DateUtil.addDays(searchDate, -1);
      weekday = (searchDate.getDay() + 6) % 7;
    }

    startGridDate = searchDate;
  }

  Component.onCompleted: if (!isNaN(startMonthDate.getTime()))
    updateStartGridDate()
  onStartMonthDateChanged: if (!isNaN(startMonthDate.getTime()))
    updateStartGridDate()

  Repeater {
    model: root.weekDayLetters

    Style.Text {
      Layout.fillWidth: true
      required property string modelData

      text: modelData
      color: Global.theme.primary
    }
  }

  Repeater {
    model: root.rows * root.columns

    Style.Text {
      Layout.fillWidth: true
      required property int modelData

      readonly property date dayDate: DateUtil.addDays(root.startGridDate, modelData)

      property bool isToday: root.todayHighlight && DateUtil.sameDay(root.todayHighlight, dayDate)
      readonly property color dayColor: if (isToday)
        Global.theme.primary
      else if (dayDate.getMonth() == root.startMonthDate.getMonth())
        Global.theme.text
      else
        Global.theme.unimportantText

      text: dayDate.getDate()
      color: dayColor
      elide: Text.ElideNone
    }
  }
}
