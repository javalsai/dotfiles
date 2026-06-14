pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Quickshell.Services.Mpris

import qs.style as Style

import "../../modules/util.js" as Util

RowLayout {
  id: root

  required property MprisPlayer player

  Style.Text {
    id: position_text
    text: Util.formatDuration(root.player.position) + ' '
  }

  Style.Slider {
    id: control
    Layout.fillWidth: true

    property int rt_position: 0

    to: root.player.length + 1
    value: root.player.position
    enabled: root.player.canSeek && root.player.positionSupported
    onUpdate: newPosition => root.player.position = newPosition

    touchDragThreshold: 50
  }

  Style.Text {
    id: length_text
    text: ' ' + Util.formatDuration(root.player.length)
  }

  FrameAnimation {
    running: root.player.playbackState == MprisPlaybackState.Playing && root.visible && !control.pressed
    onTriggered: root.player.positionChanged()
  }
}
