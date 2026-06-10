pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs
import qs.default as Default

GridLayout {
  id: root

  columns: 7
  rowSpacing: HyprlandConfig.gaps_out / 2
  columnSpacing: HyprlandConfig.gaps_out

  function sameDayDate(a, b) {
    return a.getDate() == b.getDate() && a.getMonth() == b.getMonth() && a.getYear() == b.getYear();
  }

  required property date today

  required property date startMonthDate
  property date startGridDate
  onStartMonthDateChanged: () => {
    let searchDate = new Date(startMonthDate.getFullYear(), startMonthDate.getMonth(), startMonthDate.getDate());

    let weekday = (searchDate.getDay() + 6) % 7;
    while (weekday != 0) {
      searchDate = new Date(searchDate.getFullYear(), searchDate.getMonth(), searchDate.getDate() - 1);
      weekday = (searchDate.getDay() + 6) % 7;
    }

    startGridDate = searchDate;
  }

  Repeater {
    model: ["l", "m", "x", "j", "v", "s", "d"]

    Default.Text {
      Layout.fillWidth: true
      required property string modelData
      text: modelData
      color: GState.theme.primary
    }
  }

  Repeater {
    model: 5 * 7

    Default.Text {
      Layout.fillWidth: true
      required property int modelData

      readonly property date dayDate: new Date(root.startGridDate.getFullYear(), root.startGridDate.getMonth(), root.startGridDate.getDate() + modelData)

      text: dayDate.getDate()
      color: root.sameDayDate(dayDate, root.today) ? GState.theme.primary : dayDate.getMonth() == root.startMonthDate.getMonth() ? GState.theme.text : GState.theme.unimportant_text
    }
  }
}
