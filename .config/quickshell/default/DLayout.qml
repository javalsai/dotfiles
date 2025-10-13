import QtQuick
import QtQuick.Layouts

import qs

GridLayout {
  id: layout

  property int spacing: GState.spacing
  rowSpacing: spacing
  columnSpacing: spacing

  rows: GState.vertical_layout ? -1 : 1
  columns: GState.vertical_layout ? 1 : -1
}
