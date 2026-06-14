import QtQuick
import QtQuick.Layouts

import Quickshell.Services.Mpris

import qs
import qs.style as Style

import qs.features.player

ColumnLayout {
  id: root

  readonly property int fontSize: Global.theme.fontSize

  required property MprisPlayer player
  required property bool isPlayerctld

  function previous() {
    if (isPlayerctld)
      Global.services.mpris.playerctldUnshift();
  }

  function next() {
    if (isPlayerctld)
      Global.services.mpris.playerctldShift();
  }

  // ❮ ❯
  // ⟨ ⟩
  spacing: fontSize * 0.75

  Style.Selector {
    Layout.fillWidth: true

    color: Global.theme.unimportantText
    text: `${root.player.identity} · ${Global.constants.mprisPlayerStateNames[root.player.playbackState]}`
    enable: root.isPlayerctld

    onPrevious: root.previous()
    onNext: root.next()
  }

  RowLayout {
    Layout.fillWidth: true
    spacing: root.fontSize

    PlayerImage {
      playing: root.player.isPlaying
      trackArtUrl: root.player.trackArtUrl
      changeGifOnUpdateOf: root.player.length
    }

    PlayerMetaArtInfo {
      player: root.player
      Layout.maximumWidth: 300
    }
  }

  PlayerProgress {
    Layout.fillWidth: true
    player: root.player
  }
}
