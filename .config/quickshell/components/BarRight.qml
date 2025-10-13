import Quickshell.Services.UPower
import Quickshell.Services.Pipewire

import QtQuick
import QtQuick.Layouts

import qs
import qs.default as Default
import qs.components.bar as Bar

Default.DLayout {
  id: rightLayout

  Bar.Group {
    color: GState.theme.volume_group

    Layout.alignment: Qt.AlignCenter

    Bar.Volume {
      pw_audio: Pipewire.defaultAudioSink?.audio
    }
  }

  Bar.Group {
    id: bat_group
    readonly property list<UPowerDevice> devices: UPower.devices.values //.filter(b => b.isLaptopBattery)

    Layout.alignment: Qt.AlignCenter

    color: GState.theme.battery_group
    visible: devices.length > 0

    Repeater {
      model: bat_group.devices

      Bar.Battery {
        required property UPowerDevice modelData
        battery: modelData
      }
    }
  }

  // TODO: fix frozen
  AnimatedImage {
    sourceSize.width: GState.vertical_layout ? GState.bar_width : 0
    sourceSize.height: GState.vertical_layout ? 0 : GState.bar_height

    Layout.alignment: Qt.AlignCenter

    // asynchronous: true
    source: "../assets/bongocat.gif"
  }
}
