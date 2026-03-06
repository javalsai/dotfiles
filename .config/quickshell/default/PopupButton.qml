import QtQuick

import qs
import qs.default as Default

Default.Button {
  id: button

  backgroundColor: GState.theme.hover_color
  backgroundOpacity: hovered ? GState.hover_opac : 0

  clickable: true
  onClicked: popup_window.visible = !popup_window.visible

  required property PopupWindow popup_window
}
