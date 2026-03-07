import QtQuick

import qs
import qs.default as Default
import qs.components.popup as Popup

Default.PopupButton {
  // visible: GState.current_player?.isPlaying ?? false

  readonly property string name: GState.current_player?.identity ?? ""
  readonly property var extra_data: GState.known_player_data[name] || [GState.player_icon, GState.theme.primary]

  id: root

  implicitWidth: player.implicitWidth + (GState.button_h_spacing * 2)
  implicitHeight: player.implicitHeight + (GState.button_v_spacing * 2)

  Item {
    implicitWidth: player.implicitWidth
    implicitHeight: player.implicitHeight

    Row {
      id: player
      anchors.centerIn: parent

      Default.Icon {
        color: root.extra_data[1]
        text: root.extra_data[0]
        anchors.verticalCenter: parent.verticalCenter
      }
    }
  }

  popup_window: Popup.Player { anchored: root }
}
