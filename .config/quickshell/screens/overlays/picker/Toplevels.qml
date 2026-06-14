pragma ComponentBehavior: Bound

import QtQuick

import Quickshell.Hyprland

import qs
import qs.style as Style
import qs.widgets as Widgets

import qs.screens.overlays.picker as Picker

import "../../../modules/util.js" as Util

Widgets.FlowLayout {
  id: root

  signal returnWith(window: var)

  required property var nameFormatter

  property string filterSearch: ""
  required property list<HyprlandToplevel> toplevels
  property list<HyprlandToplevel> filteredToplevels: filterSearch ? root.toplevels.filter(tl => {
    let extraInfo = '';
    if (tl.lastIpcObject.class) {
      extraInfo = `class:${tl.lastIpcObject.class} `;
    }
    let name = root.nameFormatter(tl);

    let searchString = extraInfo + name;
    return searchString.toLowerCase().indexOf(filter.text.toLowerCase()) != -1;
  }) : root.toplevels
  model: filteredToplevels

  property bool selectingKeyboard: false
  property int selectingIndex: 0

  property bool livePreviews: true
  property int buttonHeight: 300
  property int scrcpyConstraintWidth: scrcpyConstraintHeight * Global.constants.phi
  property int scrcpyConstraintHeight: 250

  function selectNext(n: int) {
    selectingKeyboard = true;
    selectingIndex += n;
    selectingIndex = Util.mod(selectingIndex, filteredToplevels.length);
  }

  function resetKeyboard() {
    selectingKeyboard = false;
    selectingIndex = 0;
  }

  function submit() {
    root.returnWith(filteredToplevels[selectingIndex].address);
  }

  delegate: Style.Button {
    id: wsButton

    required property HyprlandToplevel modelData

    virtualFocus: root.selectingKeyboard && (modelData === root.filteredToplevels[root.selectingIndex])
    onClicked: root.returnWith(modelData.address)

    property int margin: Global.theme.fontSize
    implicitWidth: tl.implicitWidth + margin
    // so with a given height I get big button which I think is better for clickability
    implicitHeight: Math.max(root.buttonHeight, tl.implicitHeight + margin)

    content: Item {
      implicitWidth: tl.implicitWidth
      implicitHeight: tl.implicitHeight

      anchors.centerIn: parent

      Picker.ToplevelView {
        id: tl
        anchors.centerIn: parent

        toplevel: wsButton.modelData.wayland
        description: root.nameFormatter(wsButton.modelData)

        live: root.livePreviews
        constraintWidth: root.scrcpyConstraintWidth
        constraintHeight: root.scrcpyConstraintHeight

        radius: Global.theme.surfaceRounding
        spacing: Global.theme.fontSize
      }
    }
  }
}
