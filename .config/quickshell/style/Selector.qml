import QtQuick
import QtQuick.Layouts

import qs
import qs.style as Style
import qs.widgets as Widgets

RowLayout {
  id: root

  // ❮ ❯
  // ⟨ ⟩
  property list<string> arrows: ["⟨", "⟩"]
  property real arrowScale: 1.2
  required property bool enable
  required property color color

  required property string text

  signal previous
  signal next

  Style.IconButton {
    enabled: root.enable
    visible: root.enable
    onClicked: root.previous()

    Widgets.FontIcon {
      text: root.arrows[0]
      color: root.color
      fontType: Global.theme.defaultFont
      iconScale: root.arrowScale
    }
  }

  Widgets.LayoutSpacer {}

  Style.Text {
    color: root.color
    text: root.text
  }

  Widgets.LayoutSpacer {}

  Style.IconButton {
    enabled: root.enable
    visible: root.enable
    onClicked: root.next()

    Widgets.FontIcon {
      text: root.arrows[1]
      color: root.color
      fontType: Global.theme.defaultFont
      iconScale: root.arrowScale
    }
  }
}
