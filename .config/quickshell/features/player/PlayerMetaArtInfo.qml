import QtQuick
import QtQuick.Layouts

import Quickshell.Services.Mpris

import qs
import qs.style as Style

ColumnLayout {
  id: root
  required property MprisPlayer player

  Style.Text {
    Layout.fillWidth: true
    horizontalAlignment: Text.AlignLeft
    wrapMode: Text.Wrap

    text: root.player.trackTitle
    maximumLineCount: 3
  }

  Style.Text {
    Layout.fillWidth: true
    horizontalAlignment: Text.AlignLeft
    wrapMode: Text.Wrap
    em: 0.75

    text: root.player.trackArtist || "<unknown artist>"
    font.italic: !root.player.trackArtist
    color: Global.theme.unimportantText
    maximumLineCount: 4
  }

  // "soft" spacer
  Style.Text {
    text: ""
  }

  Style.Text {
    Layout.fillWidth: true
    horizontalAlignment: Text.AlignLeft
    wrapMode: Text.Wrap
    em: 0.75

    text: root.player.trackAlbum || "<unknown album>"
    font.italic: !root.player.trackAlbum
    maximumLineCount: 4
  }
}
