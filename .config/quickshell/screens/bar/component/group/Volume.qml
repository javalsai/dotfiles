pragma ComponentBehavior: Bound

import QtQuick

import Quickshell.Services.Pipewire

import qs
import qs.screens.bar.component as BarComponent

import qs.features.volume

Loader {
  id: root

  required property bool vertical
  required property bool summaryGroups
  required property int alignment

  property PwNodeAudio pwAudio: Pipewire.defaultAudioSink?.audio ?? null
  active: !!pwAudio

  sourceComponent: BarComponent.GroupLayout {
    vertical: root.vertical
    color: Global.theme.groupVolume

    VolumeButton {
      vertical: root.vertical
      summaryGroups: root.summaryGroups
      alignment: root.alignment

      pwAudio: root.pwAudio
    }
  }
}
