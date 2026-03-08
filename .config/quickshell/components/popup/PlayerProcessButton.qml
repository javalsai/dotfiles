import QtQuick
import Quickshell.Io

import qs
import qs.default as Default

Loader {
  id: root

  required property bool active
  required property list<string> command
  required property string text

  // active: root.is_playerctld

  Process {
    id: oneshot_process
    running: false
    command: root.command
  }

  sourceComponent: Component {
    Default.Button {
      clickable: true
      backgroundColor: GState.theme.hover_color
      backgroundOpacity: hovered ? GState.hover_opac : 0
      onClicked: oneshot_process.running = true

      Item {
        implicitWidth: GState.font_size * 1.7
        implicitHeight: GState.font_size * 1.7
        Default.Text {
          anchors.fill: parent
          text: root.text
          color: GState.theme.unimportant_text
        }
      }
    }
  }
}
