import QtQuick

import qs
import qs.default as Default

Row {
  id: root
  // property PwNodeAudio pw_audio
  property var pw_audio // also need undefined and no fancy type system

  readonly property list<string> icon_set: GState.volume_icons

  readonly property bool is_muted: pw_audio?.muted ?? false
  readonly property real vol_over_one: Number.isNaN(pw_audio?.volume) ? 0 : (pw_audio?.volume ?? 0)
  readonly property real vol_over_one_clamped: Math.min(vol_over_one, 1) // I'm not sure it cannot be +100%
  readonly property int vol_perc: Math.round(vol_over_one * 100)

  readonly property string vol_icon: is_muted ? GState.volume_muted_icon : icon_set[Math.max(Math.ceil(vol_over_one_clamped * icon_set.length) - 1, 0)]

  readonly property color vol_color: if (is_muted) {
    GState.theme.negative_red;
  } else
    GState.theme.text

  Default.Text {
    color: root.vol_color

    font.family: GState.icon_font_family
    text: `${root.vol_icon}`
  }

  Default.Text {
    color: root.vol_color
    visible: !GState.vertical_layout

    text: ` ${root.vol_perc} %`
  }
}
