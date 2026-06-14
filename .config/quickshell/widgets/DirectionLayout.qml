import QtQuick
import QtQuick.Layouts

GridLayout {
  id: layout

  property int spacing: 0
  required property bool vertical

  rowSpacing: spacing
  columnSpacing: spacing

  rows: vertical ? -1 : 1
  columns: vertical ? 1 : -1
}
