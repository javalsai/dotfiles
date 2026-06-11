pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland

import qs
import qs.default as Default
import qs.components.reusable as Reusable

Scope {
  id: root

  property string title: ""
  property HyprlandMonitor targetMonitor
  property ObjectModel toplevels
  property var callbackData: null

  // address: string|undefined
  function close(address: var) {
    if (address !== undefined)
      ipc.windowPicked(address);
    else
      ipc.windowPicked(null);

    pickerLoader.active = false;
    title = "";
    toplevels = null;
  }

  Loader {
    id: pickerLoader
    active: false

    sourceComponent: pickerComponent
  }

  Component {
    id: pickerComponent

    PanelWindow {
      id: pickerWindow

      WlrLayershell.layer: WlrLayer.Overlay
      exclusionMode: ExclusionMode.Ignore

      Component.onCompleted: {
        screen = Quickshell.screens.find(s => Hyprland.monitorFor(s).id == root.targetMonitor.id);
      }
      aboveWindows: true

      anchors {
        left: true
        top: true
        right: true
        bottom: true
      }

      color: "transparent"

      MouseArea {
        anchors.fill: parent

        onClicked: () => {
          root.close();
        }
      }

      Keys.onEscapePressed: {
        root.close();
      }

      Rectangle {
        anchors.centerIn: parent

        radius: HyprlandConfig.rounding
        border.width: 1
        border.color: GState.theme.backgroundBorder
        color: GState.theme.background

        implicitWidth: layout.implicitWidth + 4 * HyprlandConfig.gaps_out
        implicitHeight: layout.implicitHeight + 3 * HyprlandConfig.gaps_out

        ColumnLayout {
          id: layout

          property int columns: 3
          spacing: HyprlandConfig.gaps_out

          anchors.centerIn: parent

          Default.Text {
            Layout.alignment: Qt.AlignHCenter

            text: root.title
            font.pixelSize: GState.font_size * 2
          }

          Repeater {
            model: Math.ceil(root.toplevels.values.length / layout.columns)

            RowLayout {
              id: row

              required property int modelData
              readonly property int chunkIndex: modelData
              readonly property int elemIndex: chunkIndex * layout.columns

              spacing: HyprlandConfig.gaps_out
              Layout.alignment: Qt.AlignHCenter

              Repeater {
                model: root.toplevels.values.slice(row.elemIndex, row.elemIndex + layout.columns)

                Default.Button {
                  id: wsButton
                  required property HyprlandToplevel modelData

                  Layout.alignment: Qt.AlignVCenter

                  backgroundColor: GState.theme.hover_color
                  backgroundOpacity: hovered ? GState.hover_opac : 0

                  onClicked: {
                    root.close('0x' + modelData.address);
                  }

                  clickable: true

                  property int margin: HyprlandConfig.gaps_out
                  implicitWidth: tl.implicitWidth + margin
                  // so with a given height I get big button which I think is better for clickability
                  implicitHeight: Math.max(300, tl.implicitHeight + margin)

                  content: Item {
                    implicitWidth: tl.implicitWidth
                    implicitHeight: tl.implicitHeight

                    anchors.centerIn: parent

                    Reusable.TopLevelView {
                      id: tl
                      anchors.centerIn: parent

                      toplevel: wsButton.modelData.wayland
                      live: true
                      constraintWidth: constraintHeight * GState.phi
                      constraintHeight: 250

                      radius: HyprlandConfig.rounding
                      spacing: HyprlandConfig.gaps_out
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  IpcHandler {
    id: ipc
    target: "picker"

    signal windowPicked(windowAddress: string)

    // TODO: add formatting and title
    function chooseWindowInWorkspace(workspace: string) {
      if (pickerLoader.active)
        root.close();

      // Display in focused monitor
      root.targetMonitor = Hyprland.focusedMonitor;

      // And the chosen monitors
      let ws = Hyprland.workspaces.values.find(ws => ws.name === workspace);
      if (!ws)
        throw new Error("No such workspace");
      root.toplevels = ws.toplevels;

      // Pretty title
      root.title = `Workspace ${workspace}`;

      pickerLoader.active = true;
    }
  }
}
