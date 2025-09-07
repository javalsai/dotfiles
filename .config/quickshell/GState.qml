pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: singleton

  readonly property string distro_icon: " "
  readonly property color distro_color: "#8bf"

  readonly property string special_ws_name: "な"

  readonly property string default_font_family: "Cascadia Code"
  readonly property string icon_font_family: "Hack Nerd Font"

  readonly property int font_size: 16
  readonly property int bar_height: 30
  readonly property int bar_width: 50

  property bool vertical_layout: false
  readonly property int bounding_length: vertical_layout ? bar_width : bar_height

  readonly property SystemClock clock: SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }

  property Theme theme: Theme {
    primary: "#dd5555"
    accent: "#dddd55"
    background: "#101010"
    text: "#eee"
  }
}
