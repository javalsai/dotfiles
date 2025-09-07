import QtQuick
import QtQuick.Layouts

GridLayout {
  id: layout

  property int spacing: 0
  rowSpacing: spacing
  columnSpacing: spacing

  rows: GState.vertical_layout ? -1 : 1
  columns: GState.vertical_layout ? 1 : -1
}
