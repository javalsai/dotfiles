import QtQuick

import qs
import qs.style as Style
import qs.widgets as Widgets

Item {
  id: root
  required property bool vertical
  property alias color: background.color

  default property alias content: content.data

  implicitWidth: content.implicitWidth
  implicitHeight: content.implicitHeight

  Rectangle {
    id: background

    radius: Global.theme.groupRounding
    anchors.fill: parent

    Behavior on opacity {
      Style.Animation {}
    }

    Behavior on radius {
      Style.Animation {}
    }
  }

  Widgets.DirectionLayout {
    id: content
    anchors.fill: parent
    vertical: root.vertical
  }
}
