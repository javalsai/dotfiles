pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Quickshell.Services.Mpris

import qs
import qs.util as Util
import qs.default as Default
import qs.components.reusable

Default.PopupWindow {
  id: root

  required property MprisPlayer player

  implicitHeight: 250
  implicitWidth: 500

  readonly property int maxImageSize: 150
  readonly property bool is_playerctld: player.dbusName == Constants.playerctldDbusName

  function fmtTime(raw_time) {
    let time = Math.round(raw_time);
    let seconds = time % 60;
    let minutes = Math.floor(time / 60);

    return `${minutes}:${seconds.toString().padStart(2, '0')}`;
  }

  ColumnLayout {
    anchors.centerIn: parent
    height: parent.height - (GState.popup_padding * 2)
    width: parent.width - (GState.popup_padding * 2)

    // ❮ ❯
    // ⟨ ⟩
    RowLayout {
      Layout.fillWidth: true

      PlayerProcessButton {
        active: root.is_playerctld
        command: ['playerctld', 'unshift']
        text: '⟨'
      }

      Util.Spacer {}

      Default.Text {
        color: GState.theme.unimportant_text
        text: `${root.player.identity} · ${GState.mprisPlayerStateNames[root.player.playbackState]}`
      }

      Util.Spacer {}

      PlayerProcessButton {
        active: root.is_playerctld
        command: ['playerctld', 'shift']
        text: '⟩'
      }
    }

    Util.Spacer {}

    RowLayout {
      Layout.fillWidth: true
      spacing: 20

      SafeLoadedImage {
        maxWidth: root.maxImageSize
        maxHeight: maxWidth
        radius: 10

        readonly property string chosen_gif: {
          root.player.length;
          GState.gifsList[Math.floor(Math.random() * GState.gifsList.length)]
        }
        source: root.player.trackArtUrl || Qt.resolvedUrl(`${Constants.assetsUrl}${chosen_gif}`)
        playing: root.player.isPlaying

        function chooseGif() {
          return GState.gifsList[Math.floor(Math.random() * GState.gifsList.length)];
        }
      }

      ColumnLayout {
        Layout.fillWidth: true

        Default.WrapText {
          text: root.player.trackTitle
        }

        Default.WrapText {
          text: root.player.trackArtist || "<unknown artist>"
          font.italic: !root.player.trackArtist
          font.pixelSize: GState.font_size * 0.75
          color: GState.theme.unimportant_text
        }

        // "soft" spacer
        Default.Text {
          text: ""
        }

        Default.WrapText {
          text: root.player.trackAlbum || "<unknown album>"
          font.italic: !root.player.trackAlbum
          font.pixelSize: GState.font_size * 0.75
        }
      }
    }

    Util.Spacer {}

    RowLayout {
      Layout.fillWidth: true

      Default.Text {
        id: position_text
        text: root.fmtTime(root.player.position) + ' '
      }

      Slider {
        id: control

        property int rt_position: 0

        from: 0
        to: root.player.length + 1
        value: root.player.position
        enabled: root.player.canSeek && root.player.positionSupported
        onMoved: rt_position = value
        onPressedChanged: if (!pressed)
          root.player.position = rt_position

        touchDragThreshold: 50

        Layout.fillWidth: true

        background: Rectangle {
          x: control.leftPadding
          y: control.topPadding + control.availableHeight / 2 - height / 2
          width: control.availableWidth
          height: 4
          radius: 2
          color: GState.theme.primary

          HoverHandler {
            id: slider_hover

            enabled: control.enabled
            acceptedDevices: PointerDevice.All
            cursorShape: Qt.PointingHandCursor
          }
        }

        handle: Rectangle {
          x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
          y: control.topPadding + control.availableHeight / 2 - height / 2
          implicitWidth: 12
          implicitHeight: 12
          radius: 6
          color: (control.pressed || slider_hover.hovered) ? GState.theme.accent : GState.theme.primary
        }
      }

      Default.Text {
        id: length_text
        text: ' ' + root.fmtTime(root.player.length)
      }

      FrameAnimation {
        running: root.player.playbackState == MprisPlaybackState.Playing && root.visible && !control.pressed
        onTriggered: root.player.positionChanged()
      }
    }
  }
}
