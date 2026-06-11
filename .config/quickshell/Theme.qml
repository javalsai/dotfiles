import QtQuick

QtObject {
  required property color primary
  required property color accent
  required property color background
  required property color backgroundBorder
  required property color text
  required property color unimportant_text

  required property color hover_color

  required property color positive_green
  required property color negative_red

  required property color battery_group
  required property color volume_group

  property int fastAnimationSpeed: animationSpeed / 3
  required property int animationSpeed
  required property int outEasing // Qt.Easing
}
