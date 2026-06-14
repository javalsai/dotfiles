pragma ComponentBehavior: Bound

import QtQuick

import Quickshell.Services.UPower

import qs
import qs.screens.bar.component as BarComponent

import qs.features.battery

Loader {
  id: root
  active: true

  required property bool vertical
  required property bool summaryGroups
  required property int alignment

  sourceComponent: BarComponent.GroupLayout {
    vertical: root.vertical
    color: Global.theme.groupBattery

    Repeater {
      model: UPower.devices.values.filter(b => b.type !== UPowerDeviceType.LinePower)

      BatteryButton {
        required property UPowerDevice modelData

        vertical: root.vertical
        summaryGroups: root.summaryGroups
        alignment: root.alignment

        device: modelData
      }
    }
  }
}
