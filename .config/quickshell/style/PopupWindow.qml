import QtQuick

import qs
import qs.widgets as Widgets

Widgets.PopupWindow {
  id: root

  required property Item content

  implicitWidth: content.implicitWidth + 4 * Global.services.hyprlandConfig.gaps_out
  implicitHeight: content.implicitHeight + 3 * Global.services.hyprlandConfig.gaps_out

  readonly property int effectiveBarOffset: vertical ? Global.theme.barHeight : Global.theme.barWidth
  gap: (effectiveBarOffset + Global.services.hyprlandConfig.gaps_out) / 2
}
