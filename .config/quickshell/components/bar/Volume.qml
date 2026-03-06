import QtQuick

import qs
import qs.default as Default

Default.PopupButton {
  id: root
  // property PwNodeAudio pw_audio
  property var pw_audio // also need undefined and no fancy type system

  implicitWidth: volume.implicitWidth + (GState.button_h_spacing * 2)
  implicitHeight: volume.implicitHeight + (GState.button_v_spacing * 2)

  Item {
    implicitWidth: volume.implicitWidth
    implicitHeight: volume.implicitHeight

    Row {
      id: volume
      anchors.centerIn: parent

      readonly property list<string> icon_set: GState.volume_icons

      readonly property bool is_muted: root.pw_audio?.muted ?? false
      readonly property real vol_over_one: Number.isNaN(root.pw_audio?.volume) ? 0 : (root.pw_audio?.volume ?? 0)
      readonly property real vol_over_one_clamped: Math.min(vol_over_one, 1) // I'm not sure it cannot be +100%
      readonly property int vol_perc: Math.round(vol_over_one * 100)

      readonly property string vol_icon: is_muted ? GState.volume_muted_icon : icon_set[Math.max(Math.ceil(vol_over_one_clamped * icon_set.length) - 1, 0)]

      readonly property color vol_color: if (is_muted) {
        GState.theme.negative_red;
      } else
        GState.theme.text

      Default.Icon {
        color: volume.vol_color
        text: volume.vol_icon
        anchors.verticalCenter: parent.verticalCenter
      }

      Default.Text {
        color: volume.vol_color
        visible: !GState.vertical_layout

        text: ` ${volume.vol_perc} %`
        anchors.verticalCenter: parent.verticalCenter
      }
    }
  }

  popup_window: Default.PopupWindow {
    anchored: root

    height: 100
    width: 100

    Default.Text {
      text: "test"
    }
  }
}
