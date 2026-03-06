import QtQuick

import qs
import qs.default as Default

Item {
  id: root

  implicitHeight: inner.implicitHeight / (tall_icon ? 1 : 1.4) // alignment magic
  implicitWidth: inner.implicitWidth

  property bool tall_icon: false

  property alias text: inner.text
  property alias color: inner.color

  Default.Text {
    id: inner
    anchors.fill: parent

    font.family: GState.icon_font_family
    font.pixelSize: GState.font_size * 1.5 * (root.tall_icon ? 0.75 : 1)
  }
}
