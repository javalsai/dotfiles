import QtQuick

import qs
import qs.style as Style

Text {
  property real em: 1

  font.family: Global.theme.defaultFont
  font.pixelSize: Global.theme.fontSize * em

  horizontalAlignment: Text.AlignHCenter
  verticalAlignment: Text.AlignVCenter

  // thanks to the almighty @m7moud_el_zayat
  renderType: Text.NativeRendering
  font.hintingPreference: Font.PreferFullHinting

  elide: Text.ElideRight

  color: Global.theme.text
  Behavior on opacity {
    Style.Animation {}
  }
}
