import QtQuick
import QtQuick.Layouts

Item {
  id: root

  property int spacing

  default property alias content: stash.data
  Item {
    id: stash
    visible: false
  }

  Loader {
    id: loader
    anchors.fill: parent
    sourceComponent: GState.vertical_layout ? col : row

    onLoaded: {
      for (var i = stash.data.length - 1; i >= 0; --i) {
        stash.data[i].parent = loader.item;
      }
    }
  }

  Component {
    id: col
    ColumnLayout {
      spacing: root.spacing
    }
  }

  Component {
    id: row
    RowLayout {
      spacing: root.spacing
    }
  }
}
