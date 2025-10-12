import Quickshell
import Quickshell.Services.UPower
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs;
import qs.default as Default;
import qs.components.bar as Bar;

Scope {
  id: root

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: bar

      required property var modelData

      screen: modelData
      aboveWindows: GState.vertical_layout

      property HyprlandMonitor hyprlandMonitor: Hyprland.monitorFor(screen)
      property HyprlandWorkspace hyprlandWorkspace: hyprlandMonitor.activeWorkspace
      property int tilingWindowCount: hyprlandWorkspace?.toplevels?.values?.filter(toplevel => !toplevel.lastIpcObject.floating)?.length ?? 1
      property bool floatingBar: tilingWindowCount != 1

      property int margin: floatingBar ? HyprlandConfig.gaps_out : 0

      anchors {
        top: true
        left: true
        right: !GState.vertical_layout
        bottom: GState.vertical_layout
      }

      margins {
        top: margin
        left: margin
        right: GState.vertical_layout ? 0 : margin
        bottom: GState.vertical_layout ? margin : 0
      }

      implicitHeight: GState.bar_height
      implicitWidth: GState.bar_width

      color: "transparent"

      Rectangle {
        anchors.fill: parent
        radius: bar.floatingBar ? HyprlandConfig.rounding : 0

        Behavior on radius {
          NumberAnimation {
            duration: 200
            easing.type: Easing.OutCubic
          }
        }

        clip: true
        color: GState.theme.background

        Default.DLayout {
          id: layout

          spacing: 3

          anchors.leftMargin: GState.vertical_layout ? 0 : HyprlandConfig.rounding
          anchors.topMargin: GState.vertical_layout ? HyprlandConfig.rounding : 0
          anchors.left: parent.left
          anchors.top: parent.top
          anchors.bottom: GState.vertical_layout ? undefined : parent.bottom
          anchors.right: GState.vertical_layout ? parent.right : undefined

          Default.Button {
            backgroundColor: GState.distro_color
            backgroundOpacity: hovered ? 0.3 : 0

            leftPadding: 3
            onClicked: GState.vertical_layout = !GState.vertical_layout

            clickable: true

            Layout.alignment: Qt.AlignCenter

            Default.Text {
              font.family: GState.icon_font_family
              color: GState.distro_color
              text: GState.distro_icon
            }
          }

          Repeater {
            model: Hyprland.workspaces

            Bar.WsButton {
              Layout.alignment: Qt.AlignCenter
              thisMonitor: hyprlandMonitor
            }
          }
        }

        Bar.Time {
          clock: GState.clock
          anchors.centerIn: parent
          anchors.verticalCenterOffset: 0.30
        }

        Default.DLayout {
          id: rightLayout

          spacing: 3

          anchors.rightMargin: GState.vertical_layout ? 0 : HyprlandConfig.rounding
          anchors.bottomMargin: GState.vertical_layout ? HyprlandConfig.rounding : 0
          anchors.left: GState.vertical_layout ? parent.left : undefined
          anchors.top: GState.vertical_layout ? undefined : parent.top
          anchors.bottom: parent.bottom
          anchors.right: parent.right

          Loader {
            readonly property var battery: UPower.devices.values.find(b => b.isLaptopBattery)
            source: battery ? "BarBattery.qml" : false
          }

          AnimatedImage {
            sourceSize.width: GState.vertical_layout ? GState.bar_width : undefined
            sourceSize.height: GState.vertical_layout ? undefined : GState.bar_height

            Layout.alignment: Qt.AlignCenter

            asynchronous: true
            source: "../assets/bongocat.gif"
          }
        }
      }
    }
  }
}
