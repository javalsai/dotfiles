pragma ComponentBehavior: Bound

import QtQuick

import Quickshell.Services.Mpris

import qs
import qs.style as Style
import qs.widgets as Widgets
import qs.features.player

Item {
  id: root

  required property bool vertical
  required property int alignment

  required property MprisPlayer player
  required property bool isPlayerctld

  readonly property string identity: player.identity
  readonly property list<string> extraData: Global.attrs.getMprisPlayerData(identity)

  readonly property color color: player.isPlaying ? extraData[1] : Global.theme.unimportantText

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  // TODO: Or maybe have right click shift and mouse wheel change player volume only
  MouseArea {
    anchors.fill: parent

    scrollGestureEnabled: true
    onWheel: wheel => {
      if (wheel.angleDelta.y > 0) {
        miniplayer.previous();
        wheel.accepted = true;
      } else if (wheel.angleDelta.y < 0) {
        miniplayer.next();
        wheel.accepted = true;
      }
    }
  }

  Style.IconButton {
    id: button
    anchors.fill: parent

    Widgets.FontIcon {
      text: root.extraData[0]
      color: root.color
      fontType: Global.theme.nerdFontMono
    }

    popupWindow: Style.PopupWindow {
      vertical: root.vertical
      alignment: root.alignment
      anchored: root
      content: miniplayer

      PlayerMiniplayer {
        id: miniplayer
        anchors.centerIn: parent
        player: root.player
        isPlayerctld: root.isPlayerctld
      }
    }
  }
}
