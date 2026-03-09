import QtQuick

import Quickshell.Services.Mpris

import qs
import qs.default as Default
import qs.components.popup as Popup

Default.PopupButton {
  id: root

  required property MprisPlayer player

  readonly property string name: player.identity
  readonly property var extra_data: GState.known_player_data[name] || [GState.player_icon, GState.theme.primary]

  implicitWidth: player_button.implicitWidth + (GState.button_h_spacing * 2)
  implicitHeight: player_button.implicitHeight + (GState.button_v_spacing * 2)

  Item {
    implicitWidth: player_button.implicitWidth
    implicitHeight: player_button.implicitHeight

    Row {
      id: player_button
      anchors.centerIn: parent

      Default.Icon {
        color: root.extra_data[1]
        text: root.extra_data[0]
        anchors.verticalCenter: parent.verticalCenter
      }
    }
  }

  popup_window: Popup.Player { player: root.player; anchored: root }
}
