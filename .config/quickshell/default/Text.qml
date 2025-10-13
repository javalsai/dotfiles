import QtQuick
import qs

Text {
  font.family: GState.default_font_family
  font.pixelSize: GState.font_size

  horizontalAlignment: Text.AlignHCenter
  verticalAlignment: Text.AlignVCenter

  // thanks to the almighty @m7moud_el_zayat
  renderType: Text.NativeRendering
  font.hintingPreference: Font.PreferFullHinting

  color: GState.theme.text
}
