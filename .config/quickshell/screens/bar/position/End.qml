import QtQuick
import QtQuick.Layouts

import qs
import qs.widgets as Widgets

import qs.screens.bar.component as BarComponent
import qs.screens.bar.component.group as BarGroup

Widgets.DirectionLayout {
  id: root

  spacing: Global.theme.barSpacing

  required property bool summaryGroups
  readonly property int popupAlignment: Qt.AlignLeft | Qt.AlignTop

  BarGroup.Volume {
    Layout.alignment: Qt.AlignCenter
    vertical: root.vertical
    summaryGroups: root.summaryGroups
    alignment: root.popupAlignment
  }

  BarGroup.Battery {
    Layout.alignment: Qt.AlignCenter
    vertical: root.vertical
    summaryGroups: root.summaryGroups
    alignment: root.popupAlignment
  }

  // TODO: teeny magin
  BarComponent.Bongocat {
    vertical: root.vertical
    Layout.alignment: Qt.AlignCenter
  }
}
