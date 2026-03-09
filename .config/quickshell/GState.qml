pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import Quickshell.Services.Mpris

// TODO!: 95% of this is not actual state and can be moved to proper state or constants
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
  readonly property var known_player_data: ({
      // based on .identity (from mpris)
      ["Spotify"]: ["", "#1DB954"],
      ["mpv"]: ["", "#420042"],
      ["Mozilla librewolf"]: ["", "#07ACFB"] // I mean, its firefox based
    })
  readonly property var mprisPlayerStateNames: ({
      [MprisPlaybackState.Playing]: "playing",
      [MprisPlaybackState.Paused]: "paused",
      [MprisPlaybackState.Stopped]: "stopped"
    })
  readonly property string player_icon: ""

  readonly property string special_ws_name: "な"

  readonly property string default_font_family: "Cascadia Code"
  // IMPORTANT MONO, will make icons char size BUT they will be aligned, consequently requires scaling font size up
  readonly property string icon_font_family: "Hack Nerd Font Mono"

  readonly property int popup_padding: 20

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

  // var = MprisPlayer | undefined
  property var current_player: {
    const playerctld = Mpris.players.values.find(player => player.dbusName == Constants.playerctldDbusName);

    if (playerctld != null) {
      playerctld
    } else {
      Mpris.players.values.filter(player => player.canTogglePlaying).sort((a, b) => b.isPlaying - a.isPlaying)[0]
    }
  }

  FileView {
    path: Qt.resolvedUrl("./config.json")

    watchChanges: true
    onFileChanged: reload()
    onAdapterUpdated: writeAdapter()

    JsonAdapter {
      id: config
      property bool vertical_layout: false
    }
  }

  readonly property list<string> gifsList: gifsListFile.text().trim().split(' ')
  FileView {
    id: gifsListFile
    path: Qt.resolvedUrl("./assets/gifs.list")
    blockLoading: true
  }

  property Theme theme: Theme {
    primary: "#dd5555"
    accent: "#dddd55"
    background: "#101010"
    text: "#eeeeee"
    unimportant_text: "#888888"

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
