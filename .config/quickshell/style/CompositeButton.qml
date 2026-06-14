// Small disaster in here
// TODO: modularize

import QtQuick
import QtQuick.Layouts

import qs
import qs.style as Style
import qs.widgets as Widgets

Style.Button {
  id: root

  default required property Component contentIcon
  required property Component description

  required property bool vertical
  required property bool summaryGroups

  readonly property int magicPadding: 14

  backgroundColor: Global.theme.hoverColor

  implicitWidth: layout.implicitWidth + (vertical || !textItem.isVisible ? 0 : magicPadding)
  implicitHeight: layout.implicitHeight + (!vertical || !textItem.isVisible ? 0 : magicPadding)

  Widgets.DirectionLayout {
    id: layout
    vertical: root.vertical

    Loader {
      sourceComponent: root.contentIcon
    }

    Item {
      id: textItem

      property bool isVisible: !root.summaryGroups || root.hasAnyFocus
      opacity: isVisible ? 1 : 0

      implicitWidth: description.implicitWidth
      implicitHeight: description.implicitHeight

      Layout.preferredWidth: root.vertical ? implicitHeight : (isVisible ? implicitWidth : 0)
      Layout.preferredHeight: root.vertical ? (isVisible ? implicitWidth : 0) : implicitHeight

      Behavior on Layout.preferredWidth {
        Style.Animation {}
      }

      Behavior on Layout.preferredHeight {
        Style.Animation {}
      }

      Behavior on opacity {
        Style.Animation {}
      }

      Item {
        id: visual

        anchors.centerIn: parent
        transformOrigin: Item.Center
        rotation: root.vertical ? 90 : 0

        implicitWidth: description.implicitWidth + (root.vertical ? root.magicPadding / 2 : 0)
        implicitHeight: description.implicitHeight + (root.vertical ? root.magicPadding / 2 : 0)

        Loader {
          id: description
          sourceComponent: root.description
        }
      }
    }
  }
}
