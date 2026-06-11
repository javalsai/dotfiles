pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
  id: root

  required property int columns
  required property var model
  default property Component delegate

  required property int maxHeight

  property real spacing: 0

  implicitWidth: scroll.implicitWidth
  implicitHeight: childrenRect.height

  ScrollView {
    id: scroll

    width: parent.width
    height: Math.min(root.maxHeight, column.implicitHeight)

    ColumnLayout {
      id: column

      anchors.fill: parent
      spacing: root.spacing

      Repeater {
        model: Math.ceil(root.model.length / root.columns)

        RowLayout {
          id: row

          required property int modelData
          readonly property int startIndex: modelData * root.columns

          spacing: root.spacing
          Layout.alignment: Qt.AlignHCenter

          Repeater {
            model: root.model.slice(row.startIndex, row.startIndex + root.columns)
            delegate: root.delegate
          }
        }
      }
    }
  }
}
