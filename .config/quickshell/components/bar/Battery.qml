import QtQuick
import Quickshell.Services.UPower

import qs
import qs.default as Default

Row {
  id: root
  required property UPowerDevice battery

  readonly property bool charging: battery.timeToFull !== 0
  readonly property list<string> icon_set: charging ? GState.charging_battery_icons : GState.battery_icons

  readonly property int bat_perc: Math.round(battery.percentage * 100)
  readonly property int bat_warn: 30

  readonly property string bat_icon: icon_set[Math.max(Math.ceil(battery.percentage * icon_set.length) - 1, 0)]

  readonly property string opt_type_icon: battery.isLaptopBattery ? GState.laptop_icon : GState.bat_type_icon[battery.type] || '?'
  readonly property string opt_braced_type_icon: opt_type_icon

  readonly property color charge_color: if (charging > 0) {
    GState.theme.positive_green;
  } else if (bat_perc <= bat_warn) {
    GState.theme.negative_red;
  } else
    GState.theme.text

  Default.Text {
    color: root.charge_color

    font.family: GState.icon_font_family
    text: `${root.bat_icon}·${root.opt_type_icon}`
  }

  Default.Text {
    color: root.charge_color
    visible: !GState.vertical_layout

    text: ` ${root.bat_perc} %`
  }
}
