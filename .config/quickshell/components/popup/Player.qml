import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Services.Mpris

import qs
import qs.util as Util
import qs.default as Default

Default.PopupWindow {
  id: root

  implicitHeight: 250
  implicitWidth: 500

  readonly property int maxImageSize: 150

  readonly property bool is_playerctld: GState.current_player.dbusName == 'org.mpris.MediaPlayer2.playerctld'

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
        command: [ 'playerctld', 'unshift' ]
        text: '⟨'
      }

      Util.Spacer {}

      Default.Text {
        color: GState.theme.unimportant_text
        text: `${GState.current_player.identity} · ${GState.mprisPlayerStateNames[GState.current_player.playbackState]}`
      }

      Util.Spacer {}


      PlayerProcessButton {
        active: root.is_playerctld
        command: [ 'playerctld', 'shift' ]
        text: '⟩'
      }
    }

    Util.Spacer {}

    RowLayout {
      Layout.fillWidth: true
      spacing: 20

      ClippingRectangle {
        width: root.maxImageSize
        height: root.maxImageSize
        radius: 10
        clip: true

        color: "transparent"

        Loader {
          anchors.centerIn: parent

          sourceComponent: GState.current_player.trackArtUrl ? compArt : compGif
        }
      }

      ColumnLayout {
        Layout.fillWidth: true

        Default.WrapText {
          text: GState.current_player.trackTitle
        }

        Default.WrapText {
          text: GState.current_player.trackArtist || "<unknown artist>"
          font.italic: !GState.current_player.trackArtist
          font.pixelSize: GState.font_size * 0.75
          color: GState.theme.unimportant_text
        }

        // "soft" spacer
        Default.Text { text: "" }

        Default.WrapText {
          text: GState.current_player.trackAlbum || "<unknown album>"
          font.italic: !GState.current_player.trackAlbum
          font.pixelSize: GState.font_size * 0.75
        }
      }
    }

    Util.Spacer {}

    RowLayout {
      Layout.fillWidth: true

      Default.Text {
        id: position_text
        text: fmtTime(GState.current_player.position) + ' '
      }

      Slider {
        id: control

        property int rt_position: 0

        from: 0
        to: GState.current_player.length
        value: GState.current_player.position
        enabled: GState.current_player.canSeek && GState.current_player.positionSupported
        onMoved: rt_position = value
        onPressedChanged: if (!pressed) GState.current_player.position = rt_position

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
        text: ' ' + fmtTime(GState.current_player.length)
      }

      FrameAnimation {
        running: GState.current_player.playbackState == MprisPlaybackState.Playing && root.visible && !control.pressed
        onTriggered: GState.current_player.positionChanged()
      }
    }

    /// loadable images

    Component {
      id: compGif

      AnimatedImage {
        readonly property string chosen_gif: GState.gifsList[Math.floor(Math.random() * GState.gifsList.length)]
        Component.onCompleted: console.log(chosen_gif)

        anchors.centerIn: parent

        playing: GState.current_player.isPlaying

        width: Math.min(root.maxImageSize, sourceSize.width * root.maxImageSize / sourceSize.height)
        height: Math.min(root.maxImageSize, sourceSize.height * root.maxImageSize / sourceSize.width)

        source: `../../assets/${chosen_gif}`
      }
    }

    Component {
      id: compArt

      Image {
        cache: true
        width: Math.min(root.maxImageSize, sourceSize.width * root.maxImageSize / sourceSize.height)
        height: Math.min(root.maxImageSize, sourceSize.height * root.maxImageSize / sourceSize.width)
        source: GState.current_player?.trackArtUrl
      }
    }
  }
}
