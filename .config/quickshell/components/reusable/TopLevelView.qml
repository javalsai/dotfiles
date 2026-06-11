import QtQuick

import Quickshell.Wayland
import Quickshell.Widgets

import qs
import qs.default as Default

Column {
  id: root

  default required property Toplevel toplevel
  required property int constraintWidth
  required property int constraintHeight
  property bool live: false
  property int radius: 0

  required property string description

  property int viewWidth: scrcpy.implicitWidth

  // logging ._.
  // Loader {
  //   active: scrcpy.hasContent

  //   sourceComponent: Component {
  //     Item {
  //       Component.onCompleted: {
  //         console.log("root.height =", root.height, "root.implicitHeight =", root.implicitHeight, "childrenRect.height =", root.childrenRect.height, "scrcpy.height =", scrcpy.height, "scrcpy.implicitHeight =", scrcpy.implicitHeight);
  //       }
  //     }
  //   }
  // }

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

  Default.WrapText {
    id: text
    horizontalAlignment: Text.AlignHCenter
    width: scrcpy.implicitWidth

    text: root.description

    font.pixelSize: GState.font_size * 0.75
    maximumLineCount: 2
  }
}
