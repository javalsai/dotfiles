import QtQuick

import qs
import qs.style as Style

// So the icon should be always a square
//
// - `iconScale` scales the actual content to fit the context
// - `implicitScale` multiplies to both the render scale and bounding size so it can be used a general scaler
Item {
  id: root

  property real iconArea: 1.7 // TODO: try smaller ones and/or make it part of the theme
  implicitHeight: pixelHeight * iconArea
  implicitWidth: pixelHeight * iconArea

  required property string fontType

  property alias text: inner.text
  property alias color: inner.color
  property alias font: inner.font

  property real iconScale: 1.5
  property real implicitScale: 1

  readonly property real pixelHeight: Global.theme.fontSize * implicitScale
  readonly property real pixelRenderHeight: Global.theme.fontSize * iconScale * implicitScale

  Style.Text {
    id: inner
    anchors.centerIn: parent

    font.family: root.fontType
    font.pixelSize: root.pixelRenderHeight
  }
}
