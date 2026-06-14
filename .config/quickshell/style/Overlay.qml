pragma ComponentBehavior: Bound

import QtQuick

import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

import qs
import qs.style as Style

Loader {
  id: root
  active: false

  signal closed

  function open() {
    root.active = true;
  }

  function silentClose() {
    root.active = false;
  }

  function close() {
    root.active = false;
    root.closed();
  }

  required property HyprlandMonitor monitor
  default property Component content

  sourceComponent: PanelWindow {
    WlrLayershell.layer: WlrLayer.Overlay
    exclusionMode: ExclusionMode.Ignore
    aboveWindows: true

    color: "transparent"
    focusable: true

    Component.onCompleted: {
      screen = Quickshell.screens.find(s => Hyprland.monitorFor(s).id == root.monitor.id);
    }

    anchors {
      left: true
      top: true
      right: true
      bottom: true
    }

    MouseArea {
      anchors.fill: parent

      onClicked: () => {
        root.close();
      }
    }

    Item {
      anchors.centerIn: parent

      implicitWidth: content.implicitWidth + 4 * Global.services.hyprlandConfig.gaps_out
      implicitHeight: content.implicitHeight + 3 * Global.services.hyprlandConfig.gaps_out

      Style.SurfaceRectangle {
        anchors.fill: parent
      }

      Item {
        id: content

        anchors.centerIn: parent

        implicitWidth: loadedContent.implicitWidth
        implicitHeight: loadedContent.implicitHeight

        Loader {
          id: loadedContent
          sourceComponent: root.content
        }
      }
    }
  }
}
