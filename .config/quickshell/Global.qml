pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Services.Mpris

import qs.style as Style
import qs.widgets as Widgets
import qs.services as Services

import "modules/util.js" as Util

Singleton {
  id: root

  readonly property Services.Services services: Services.Services {
    id: services
  }

  readonly property var constants: QtObject {
    readonly property real phi: (1 + Math.sqrt(5)) / 2

    readonly property string playerctldDbusName: 'org.mpris.MediaPlayer2.playerctld'
    readonly property url assetsUrl: Qt.resolvedUrl('./assets/')
    readonly property url shadersUrl: Qt.resolvedUrl('./shaders/')

    readonly property var mprisPlayerStateNames: ({
        [MprisPlaybackState.Playing]: "playing",
        [MprisPlaybackState.Paused]: "paused",
        [MprisPlaybackState.Stopped]: "stopped"
      })
  }

  readonly property var attrs: QtObject {
    readonly property Widgets.FontIcon distroIcon: Widgets.FontIcon {
      text: ""
      color: "#88bbff"
      fontType: root.theme.nerdFontMono
    }

    readonly property string specialWsPrettyName: "な"

    function getMprisPlayerData(identity: string): list<string> {
      return knownMprisPlayers[identity] || ["", root.theme.primary];
    }

    readonly property var knownMprisPlayers: ({
        // based on .identity (from mpris)
        ["Spotify"]: ["", "#1DB954"],
        ["mpv"]: ["", "#420042"],
        ["Mozilla firefox"]: ["", "#E66000"],
        ["Mozilla librewolf"]: ["", "#07ACFB"] // I mean, its firefox based
        ,
        ["Haruna"]: ["", "#E5E5E5"] // can't do better and really want this indicator
      })

    // lateral or vertical margins depending on layout
    readonly property int leftBarEdgeMargins: root.services.hyprlandConfig.rounding - root.theme.buttonRounding
  }

  property list<Style.Theme> themes: [
    Style.Theme {
      primary: "#dd5555"
      accent: "#dddd55"

      surfaceRounding: root.services.hyprlandConfig.rounding
      surfaceBackground: "#101010"
      surfaceBorderColor: "#404040"

      barHeight: 35
      barWidth: 50
      barSpacing: 4

      text: "#eeeeee"
      unimportantText: "#888888"
      backgroundText: "#555555"

      hoverColor: "#eeeeee"

      semanticPositiveGreen: "#229944"
      semanticNegativeRed: "#dd5555"

      groupRounding: 2
      groupBattery: Util.lowerColorOpac(semanticPositiveGreen)
      groupVolume: Util.lowerColorOpac(primary)

      buttonRounding: 2
      buttonHoverOpac: 0.3
      buttonHPadding: 6
      buttonVPadding: 2

      fontSize: 17
      defaultFont: "Cascadia Code"
      nerdFont: "Hack Nerd Font"

      animationSpeed: root.services.hyprlandConfig.animationSpeed
      outEasing: Easing.OutExpo
    }
  ]

  property Style.Theme theme: themes[0]
}
