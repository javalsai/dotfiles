pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs.style as Style

import qs.screens.overlays.picker as Picker

Style.Overlay {
  id: root

  property var toplevels: null
  property var nameFormatter: null
  property var onSelected: null

  readonly property int columns: 3
  readonly property int minWidth: 300
  readonly property int maxHeight: 800

  // I cannot get this to run after all the components are COMEPLTELY unloaded and I'm not gonna do null coalescing on them
  // onItemChanged: {
  //   if (item === null) {
  //     toplevels = null;
  //     nameFormatter = null;
  //     onSelected = null;
  //   }
  // }

  function returnWith(address: var) {
    if (onSelected !== null)
      if (address !== null)
        onSelected(`0x${address}`);
      else
        onSelected(null);

    root.silentClose();
  }

  onClosed: returnWith(null)

  function openOverlays(toplevels: var, nameFormatter: var, onSelected: var) {
    if (toplevels !== null) {
      root.close();
    }

    root.toplevels = toplevels;
    root.nameFormatter = nameFormatter;
    root.onSelected = onSelected;

    root.open();
  }

  ColumnLayout {
    spacing: 16 // TODO

    Style.TextInput {
      id: filter

      Layout.preferredHeight: implicitHeight
      Layout.fillWidth: true
      Layout.minimumWidth: root.minWidth
      Layout.alignment: Qt.AlignHCenter

      startFocused: true

      text: ""
      placeholderText: "Search"

      onTextChanged: picker.resetKeyboard()

      textField.Keys.onTabPressed: picker.selectNext(1)
      textField.Keys.onBacktabPressed: picker.selectNext(-1)
      textField.Keys.onReturnPressed: picker.submit()

      textField.Keys.onUpPressed: picker.selectNext(-root.columns)
      textField.Keys.onDownPressed: picker.selectNext(root.columns)

      Keys.onEscapePressed: root.close()
    }

    // Picker.ToplevelView {
    //   toplevel: root.toplevels.values[0].wayland

    //   live: true
    //   constraintWidth: 300
    //   constraintHeight: 300

    //   description: root.nameFormatter(root.toplevels.values[0])
    // }

    Picker.Toplevels {
      id: picker

      Layout.alignment: Qt.AlignHCenter

      filterSearch: filter.text
      toplevels: root.toplevels?.values ?? []

      columns: root.columns
      spacing: 8 // TODO
      maxHeight: root.maxHeight

      onReturnWith: a => root.returnWith(a)
      nameFormatter: root.nameFormatter
    }
  }
}
