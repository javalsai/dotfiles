import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Services.Pipewire

PanelWindow {
    id: window
    height: 30

    readonly property PwNode sink: Pipewire.preferredDefaultAudioSink

    readonly property list<MprisPlayer> list: Mpris.players.values
    readonly property MprisPlayer player: window.list.find(p => p.isPlaying) ?? window.list.find(p => p.indentity == 'Spotify') ?? window.list[0] ?? null

    anchors {
        left: true
        right: true
        top: true
    }

    Rectangle {
        anchors.fill: parent
        color: GState.theme.background
    }

    Rectangle {
        anchors {
            bottomMargin: 2
            topMargin: 2
            top: parent.top
            bottom: parent.bottom
        }

        width: player_indicator.width

        color: "transparent"
        radius: 3

        RowLayout {
            id: player_indicator
            height: parent.height
            spacing: 5

            Image {
                Layout.fillHeight: true
                Layout.preferredWidth: this.height * paintedWidth / paintedHeight

                // TODO: fallback image
                source: window.player.trackArtUrl
                fillMode: Image.PreserveAspectFit
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter

                text: window.player.identity + " - " + window.sink.id
                color: GState.theme.text
            }
        }
    }

    AnimatedImage {
        height: parent.height - 5
        // Layout.fillHeight: true
        // Layout.preferredWidth: this.height * paintedWidth / paintedHeight

        anchors.bottom: parent.bottom
        anchors.right: parent.right

        sourceSize.width: width
        sourceSize.height: height

        playing: visible
        asynchronous: true
        speed: 0.7
        source: "/tmp/shell/assets/kurukuru.gif"
    }
}
