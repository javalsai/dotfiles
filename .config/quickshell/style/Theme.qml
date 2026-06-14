import QtQuick

QtObject {
  required property color primary
  required property color accent

  required property int surfaceRounding
  required property color surfaceBackground
  required property color surfaceBorderColor

  required property int barHeight
  required property int barWidth
  required property int barSpacing

  required property color text
  required property color unimportantText
  required property color backgroundText

  required property color hoverColor

  required property color semanticPositiveGreen
  required property color semanticNegativeRed

  required property int groupRounding
  required property color groupBattery
  required property color groupVolume

  required property int buttonRounding
  required property real buttonHoverOpac
  required property int buttonHPadding
  required property int buttonVPadding

  required property int fontSize
  required property string defaultFont
  required property string nerdFont
  property string nerdFontMono: `${nerdFont} Mono`

  property int fastAnimationSpeed: animationSpeed / 3
  required property int animationSpeed
  required property int outEasing // Qt.Easing
}
