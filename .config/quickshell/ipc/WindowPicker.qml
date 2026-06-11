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

  property HyprlandMonitor targetMonitor
  property ObjectModel toplevels
  property var callbackData: null
  property var nameFormatter

  function open() {
    pickerLoader.active = true;
  }

  // address: string|undefined
  function close(address: var) {
    if (address !== undefined)
      ipc.windowPicked(address);
    else
      ipc.windowPicked(null);

    pickerLoader.active = false;
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

      readonly property int tlCols: 3

      focusable: true
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

          property bool selectingTl: false
          property int selectedTlIdx: 0
          property var filteredToplevels: filter.text ? root.toplevels.values.filter(tl => {
            let extraInfo = '';
            if (tl.lastIpcObject.class) {
              extraInfo = `class:${tl.lastIpcObject.class} `;
            }
            let name = root.nameFormatter(tl);

            let searchString = extraInfo + name;
            return searchString.toLowerCase().indexOf(filter.text.toLowerCase()) != -1;
          }) : root.toplevels.values

          // if (selectingTl)
          //   filteredToplevels[selectedTlIdx]
          // else
          //   null

          // Euclidean mod
          function mod(n, m) {
            return ((n % m) + m) % m;
          }

          function selectNext(n: int) {
            selectingTl = true;
            selectedTlIdx += n;
            selectedTlIdx = mod(selectedTlIdx, filteredToplevels.length);
          }

          anchors.centerIn: parent
          spacing: HyprlandConfig.gaps_out

          Default.TextInput {
            id: filter

            Layout.preferredHeight: implicitHeight
            Layout.fillWidth: true
            Layout.minimumWidth: 300
            Layout.alignment: Qt.AlignHCenter

            startFocused: true

            text: ""
            placeholderText: "Search"
            onTextChanged: {
              layout.selectingTl = false;
              layout.selectedTlIdx = 0;
            }

            textField.Keys.onTabPressed: layout.selectNext(1)
            textField.Keys.onBacktabPressed: layout.selectNext(-1)
            textField.Keys.onReturnPressed: root.close('0x' + layout.filteredToplevels[layout.selectedTlIdx].address)

            textField.Keys.onUpPressed: layout.selectNext(-pickerWindow.tlCols)
            textField.Keys.onDownPressed: layout.selectNext(pickerWindow.tlCols)

            Keys.onEscapePressed: root.close()
          }

          Default.FlowLayout {
            Layout.alignment: Qt.AlignHCenter

            model: layout.filteredToplevels

            columns: pickerWindow.tlCols
            spacing: HyprlandConfig.gaps_out
            maxHeight: 800

            delegate: Default.Button {
              id: wsButton

              required property HyprlandToplevel modelData
              property bool isSelected: layout.selectingTl && (modelData === layout.filteredToplevels[layout.selectedTlIdx])
              property bool virtualFocus: isSelected || hovered

              Layout.alignment: Qt.AlignVCenter

              backgroundColor: GState.theme.hover_color
              backgroundOpacity: virtualFocus ? GState.hover_opac : 0

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
                  description: root.nameFormatter(wsButton.modelData)

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

  function ipcChoosePrelude() {
    if (pickerLoader.active)
      close();

    // Display in focused monitor
    root.targetMonitor = Hyprland.focusedMonitor;

    Hyprland.refreshToplevels();
  }

  IpcHandler {
    id: ipc
    target: "picker"

    signal windowPicked(windowAddress: string)

    function chooseWindow() {
      root.ipcChoosePrelude();

      // And the chosen monitors
      root.toplevels = Hyprland.toplevels;

      // Pretty props
      root.nameFormatter = function (tl: HyprlandToplevel): string {
        return `${tl.title} <b><u>ws:${tl.workspace.name}</u></b> <sup><i>${tl.lastIpcObject.size?.[0]}x${tl.lastIpcObject.size?.[1]}</i></sup>`;
      };

      root.open();
    }

    function chooseWindowInWorkspace(workspace: string) {
      root.ipcChoosePrelude();

      // And the chosen monitors
      let ws = Hyprland.workspaces.values.find(ws => ws.name === workspace);
      if (!ws)
        throw new Error("No such workspace");
      root.toplevels = ws.toplevels;

      // Pretty props
      root.nameFormatter = function (tl: HyprlandToplevel): string {
        return `${tl.title}`;
      };

      root.open();
    }
  }
}
