pragma ComponentBehavior: Bound

import QtQuick

import Quickshell.Services.Pipewire

import qs
import qs.style as Style
import qs.widgets as Widgets

import qs.features.volume

import "../../modules/util.js" as Util

Item {
  id: root

  required property bool vertical
  required property bool summaryGroups
  required property int alignment

  required property PwNodeAudio pwAudio

  readonly property bool isMuted: pwAudio?.muted ?? false
  readonly property real volUnit: Number.isNaN(pwAudio?.volume) ? 0 : (pwAudio?.volume ?? 0)

  readonly property list<string> volumeIcons: ["", "", ""]
  readonly property string volumeMutedIcon: ""

  readonly property string iconChar: isMuted ? volumeMutedIcon : Util.grabFromSet(volUnit, volumeIcons)
  readonly property color color: if (isMuted) {
    Global.theme.semanticNegativeRed;
  } else
    Global.theme.text

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  MouseArea {
    anchors.fill: parent

    scrollGestureEnabled: true
    onWheel: wheel => {
      // let isBigStep = wheel.modifiers & Qt.ControlModifier; // ?
      let step = 0.04;

      if (wheel.angleDelta.y > 0) {
        root.pwAudio.volume += step;
        wheel.accepted = true;
      } else if (wheel.angleDelta.y < 0) {
        root.pwAudio.volume -= step;
        wheel.accepted = true;
      }
    }
  }

  Style.CompositeButton {
    id: button
    vertical: root.vertical
    summaryGroups: root.summaryGroups

    virtualFocus: popup.visible

    anchors.fill: parent

    Widgets.FontIcon {
      text: root.iconChar
      color: root.color
      fontType: Global.theme.nerdFontMono
    }

    description: Style.Text {
      text: `${(root.volUnit * 100).toFixed(0)} %`
      color: root.color
    }

    popupWindow: Style.PopupWindow {
      id: popup

      vertical: root.vertical
      alignment: root.alignment
      anchored: root
      content: volumeCenter

      VolumeCenter {
        id: volumeCenter
        anchors.centerIn: parent
      }
    }
  }
}
