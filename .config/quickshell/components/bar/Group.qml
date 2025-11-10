import QtQuick

import qs.default as Default

Default.Rectangle {
  id: bat_group

  implicitWidth: inner.implicitWidth + 14
  implicitHeight: inner.implicitHeight + 4

  default property alias content: inner.data

  Default.DLayout {
    id: inner
    anchors.centerIn: parent

    spacing: 10
  }
}
