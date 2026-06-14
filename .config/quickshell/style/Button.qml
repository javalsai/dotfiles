pragma ComponentBehavior: Bound

import QtQuick

import qs
import qs.style as Style
import qs.widgets as Widgets

// Optionally supports popupWindow and automatically attackes onClicked to it
Widgets.Button {
  id: root

  clickable: true

  property bool virtualHover: virtualFocus
  readonly property bool renderHover: hovered || virtualHover

  property color backgroundColor: Global.theme.hoverColor
  readonly property real implicitBackgroundOpacity: renderHover ? Global.theme.buttonHoverOpac : 0
  property real backgroundOpacity: implicitBackgroundOpacity

  background: Rectangle {
    anchors.fill: parent

    radius: Global.theme.buttonRounding
    color: root.backgroundColor
    opacity: root.backgroundOpacity

    Behavior on opacity {
      Style.Animation {}
    }
  }

  property PopupWindow popupWindow
  onClicked: if (popupWindow)
    popupWindow.visible = !popupWindow.visible
}
