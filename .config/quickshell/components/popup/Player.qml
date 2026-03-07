import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

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

    Default.Text {
      color: GState.theme.unimportant_text
      text: GState.current_player.identity
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

        Default.Text {
          Layout.fillWidth: true
          horizontalAlignment: Text.AlignLeft
          text: GState.current_player.trackTitle
          wrapMode: Text.Wrap
        }

        Default.Text {
          Layout.fillWidth: true
          horizontalAlignment: Text.AlignLeft
          text: GState.current_player.trackArtist || "<unknown artist>"
          font.pixelSize: GState.font_size * 0.75
          color: GState.theme.unimportant_text
          wrapMode: Text.Wrap
        }

        // "soft" spacer
        Default.Text { text: "" }

        Default.Text {
          Layout.fillWidth: true
          horizontalAlignment: Text.AlignLeft
          text: GState.current_player.trackAlbum || "<unknown album>"
          font.pixelSize: GState.font_size * 0.75
          wrapMode: Text.Wrap
        }
      }
    }

    Util.Spacer {}

    RowLayout {
      Layout.fillWidth: true

      Default.Text {
        id: position_text
        text: fmtTime(GState.current_player.position)
      }

      Slider {
        id: control

        from: 0
        to: GState.current_player.length
        value: GState.current_player.position
        enabled: GState.current_player.canSeek && GState.current_player.positionSupported
        onMoved: GState.current_player.position = value

        Layout.fillWidth: true
        // implicitWidth: (500 - GState.popup_padding * 2) - position_text.width - length_text.width

        background: Rectangle {
          x: control.leftPadding
          y: control.topPadding + control.availableHeight / 2 - height / 2
          implicitWidth: 200
          implicitHeight: 4
          width: control.availableWidth
          height: implicitHeight
          radius: 2
          color: GState.theme.primary
        }

        handle: Rectangle {
          x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
          y: control.topPadding + control.availableHeight / 2 - height / 2
          implicitWidth: 12
          implicitHeight: 12
          radius: 6
          color: control.pressed ? GState.theme.accent : GState.theme.primary
        }
      }

      Default.Text {
        id: length_text
        text: fmtTime(GState.current_player.length)
      }

      FrameAnimation {
        running: GState.current_player.playbackState == MprisPlaybackState.Playing && root.visible
        onTriggered: GState.current_player.positionChanged()
      }
    }

    /// loadable images

    Component {
      id: compGif

      AnimatedImage {
        readonly property string chosen_gif: GState.gifsList[Math.floor(Math.random() * GState.gifsList.length)]
        // Component.onCompleted: console.log(chosen_gif)

        anchors.centerIn: parent

        width: Math.min(150, sourceSize.width * 150 / sourceSize.height)
        height: Math.min(150, sourceSize.height * 150 / sourceSize.width)

        source: `../../assets/${chosen_gif}`
      }
    }

    Component {
      id: compArt

      Image {
        cache: true
        height: root.maxImageSize
        width: root.maxImageSize
        source: GState.current_player?.trackArtUrl
      }
    }
  }
}
