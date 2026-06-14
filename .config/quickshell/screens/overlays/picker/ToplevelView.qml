import QtQuick

import Quickshell.Wayland
import Quickshell.Widgets

import qs.style as Style

Column {
  id: root

  default required property Toplevel toplevel
  required property int constraintWidth
  required property int constraintHeight
  property bool live: false
  property int radius: 0

  required property string description

  property int viewWidth: scrcpy.implicitWidth

  ClippingRectangle {
    implicitWidth: scrcpy.implicitWidth
    implicitHeight: scrcpy.implicitHeight

    radius: root.radius
    color: "transparent"

    ScreencopyView {
      id: scrcpy

      captureSource: root.toplevel

      live: root.live
      constraintSize.width: root.constraintWidth
      constraintSize.height: root.constraintHeight
    }
  }

  Style.Text {
    id: text
    width: scrcpy.implicitWidth

    text: root.description

    em: 0.75
    maximumLineCount: 2
  }
}
