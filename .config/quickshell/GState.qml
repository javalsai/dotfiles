pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower

Singleton {
  id: singleton

  readonly property list<string> volume_icons: ["", "", ""]
  readonly property string volume_muted_icon: ""

  readonly property list<string> battery_icons: ["󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"]
  readonly property list<string> charging_battery_icons: ["󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅"]

  readonly property string laptop_icon: "󰌢"
  readonly property var bat_type_icon: ({
      [UPowerDeviceType.Phone]: "",
      [UPowerDeviceType.Headphones]: "󰋋",
      [UPowerDeviceType.Mouse]: ""
    })

  readonly property string distro_icon: ""
  readonly property color distro_color: "#88bbff"

  readonly property string special_ws_name: "な"

  readonly property string default_font_family: "Cascadia Code"
  // IMPORTANT MONO, will make icons char size BUT they will be aligned, consequently requires scaling font size up
  readonly property string icon_font_family: "Hack Nerd Font Mono"

  readonly property int font_size: 17
  readonly property int bar_height: 35
  readonly property int bar_width: 50
  readonly property int spacing: 4

  readonly property int button_h_spacing: 8
  readonly property int button_v_spacing: 2

  readonly property real hover_opac: 0.2
  readonly property real hover_color_opac: 0.3

  readonly property int button_radius: 2

  property alias vertical_layout: config.vertical_layout

  readonly property SystemClock clock: SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }

  FileView {
    path: ".config/quickshell/config.json"

    watchChanges: true
    onFileChanged: reload()
    onAdapterUpdated: writeAdapter()

    JsonAdapter {
      id: config
      property bool vertical_layout: false
    }
  }

  property Theme theme: Theme {
    primary: "#dd5555"
    accent: "#dddd55"
    background: "#101010"
    text: "#eeeeee"

    hover_color: "#eeeeee"

    positive_green: "#229944"
    negative_red: "#dd5555"

    battery_group: lowerOpac(positive_green)
    volume_group: lowerOpac(primary)

    function lowerOpac(color) {
      return Qt.rgba(color.r, color.g, color.b, 0.4);
    }
  }
}
