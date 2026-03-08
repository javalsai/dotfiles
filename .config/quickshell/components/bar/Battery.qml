import QtQuick
import Quickshell.Services.UPower

import qs
import qs.default as Default

Default.PopupButton {
  id: root
  required property UPowerDevice battery

  implicitWidth: battery.implicitWidth + (GState.button_h_spacing * 2)
  implicitHeight: battery.implicitHeight + (GState.button_v_spacing * 2)

  Item {
    implicitWidth: battery.implicitWidth
    implicitHeight: battery.implicitHeight

    Row {
      id: battery
      anchors.centerIn: parent

      spacing: GState.spacing

      readonly property bool charging: battery.change_rate > 0
      readonly property list<string> icon_set: charging ? GState.charging_battery_icons : GState.battery_icons

      readonly property int bat_perc: Math.round(root.battery.percentage * 100)
      readonly property int bat_warn: 30

      readonly property string bat_icon: icon_set[Math.max(Math.ceil(root.battery.percentage * icon_set.length) - 1, 0)]

      readonly property string opt_type_icon: root.battery.isLaptopBattery ? GState.laptop_icon : GState.bat_type_icon[root.battery.type] || '?'
      readonly property string opt_braced_type_icon: opt_type_icon

      readonly property color charge_color: if (charging > 0) {
        GState.theme.positive_green;
      } else if (bat_perc <= bat_warn) {
        GState.theme.negative_red;
      } else
        GState.theme.text

      Default.Icon {
        color: battery.charge_color
        text: battery.bat_icon
        tall_icon: true
        anchors.verticalCenter: parent.verticalCenter
      }

      Default.Icon {
        color: battery.charge_color
        text: battery.opt_type_icon
        tall_icon: true
        anchors.verticalCenter: parent.verticalCenter
      }

      Default.Text {
        color: battery.charge_color
        visible: !GState.vertical_layout

        text: ` ${battery.bat_perc} %`
        anchors.verticalCenter: parent.verticalCenter
      }
    }
  }

  popup_window: Default.PopupWindow {
    anchored: root

    implicitHeight: 100
    implicitWidth: 100

    Default.Text {
      text: "test"
    }
  }
}
