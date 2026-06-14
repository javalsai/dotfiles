pragma ComponentBehavior: Bound

import QtQuick

import Quickshell.Services.UPower

import qs
import qs.style as Style
import qs.widgets as Widgets

import qs.features.battery

import "../../modules/util.js" as Util

// TODO: Icons suckass and too big and too many semantics.
// I think I will drop the battery icon sets completely.
// Represent the percentage by maybe a completed circle, like my phone, I prefer it there.
// Charging status is enough with color.
// And idk about battery type, that's certainly useful but I have to properly manage different proportion icons.
Item {
  id: root

  required property bool vertical
  required property bool summaryGroups
  required property int alignment

  required property UPowerDevice device

  readonly property list<string> normalBatteryIcons: ["󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"]
  readonly property list<string> chargingBatteryIcons: ["󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅"]

  readonly property string laptopIcon: "󰌢"
  readonly property var batTypeIcon: ({
      [UPowerDeviceType.Phone]: "",
      [UPowerDeviceType.Headphones]: "󰋋",
      [UPowerDeviceType.Mouse]: ""
    })

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  readonly property int batPerc: Math.round(device.percentage * 100)
  readonly property int batWarn: 30

  readonly property bool charging: device.state == UPowerDeviceState.Charging
  readonly property color color: if (charging > 0) {
    Global.theme.semanticPositiveGreen;
  } else if (batPerc <= batWarn) {
    Global.theme.semanticNegativeRed;
  } else
    Global.theme.text

  readonly property list<string> iconSet: charging ? chargingBatteryIcons : normalBatteryIcons
  readonly property string iconBatType: device.isLaptopBattery ? laptopIcon : batTypeIcon[device.type] || "󰂑"
  readonly property string iconCharPerc: Util.grabFromSet(device.percentage, iconSet)

  Style.CompositeButton {
    id: button
    vertical: root.vertical
    summaryGroups: root.summaryGroups

    virtualFocus: popup.visible

    anchors.fill: parent

    Widgets.FontIcon {
      text: root.iconBatType
      color: root.color
      fontType: Global.theme.nerdFontMono
      iconScale: 1.0
    }

    description: Style.Text {
      text: `${root.batPerc.toFixed(0)} %`
      color: root.color
    }

    popupWindow: Style.PopupWindow {
      id: popup

      vertical: root.vertical
      alignment: root.alignment
      anchored: root
      content: volumeCenter

      BatteryCenter {
        id: volumeCenter
        anchors.centerIn: parent
      }
    }
  }
}
