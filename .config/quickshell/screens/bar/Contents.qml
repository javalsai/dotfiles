import QtQuick
import QtQuick.Layouts

import qs
import qs.widgets as Widgets
import qs.screens.bar.position as BarPosition

Item {
  id: root

  signal rotate
  signal switchSummaries

  required property bool vertical
  required property bool summaryGroups

  property alias hyprMonitor: left.hyprMonitor

  BarPosition.Center {
    anchors.centerIn: parent
    vertical: root.vertical
  }

  Widgets.DirectionLayout {
    vertical: root.vertical

    property int startMargin: Global.attrs.leftBarEdgeMargins

    anchors {
      fill: parent
      leftMargin: root.vertical ? 0 : startMargin
      rightMargin: anchors.leftMargin
      topMargin: root.vertical ? startMargin : 0
      bottomMargin: anchors.topMargin
    }

    BarPosition.Start {
      id: left
      Layout.alignment: Qt.AlignCenter
      vertical: root.vertical

      hyprMonitor: root.hyprMonitor
      onRotate: root.rotate()
      onSwitchSummaries: root.switchSummaries()
    }

    Widgets.LayoutSpacer {}

    BarPosition.End {
      Layout.alignment: Qt.AlignCenter
      vertical: root.vertical
      summaryGroups: root.summaryGroups
    }
  }
}
