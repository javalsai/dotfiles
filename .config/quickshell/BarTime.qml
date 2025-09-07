import QtQuick
import Quickshell

Loader {
  id: root
  required property SystemClock clock

  source: GState.vertical_layout ? "VerticalClock.qml" : "HorizontalClock.qml"
}
