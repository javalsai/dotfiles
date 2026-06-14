import qs.style as Style
import qs.widgets as Widgets

Style.Button {
  // TODO: make more generic icon type
  default required property Widgets.FontIcon contentIcon

  backgroundColor: contentIcon.color

  implicitWidth: contentIcon.implicitWidth
  implicitHeight: contentIcon.implicitHeight

  content: contentIcon
}
