//! MouseArea that picks month given an initial month based on mouse wheel
//!
//! `initialDate` must be the 1st of the month, `pickedDate` will be returned at the 1st of the month too

import QtQuick

import "../../../modules/dateUtil.js" as DateUtil

MouseArea {
  id: root

  required property date initialDate
  property date pickedDate
  Component.onCompleted: {
    pickedDate = DateUtil.copyDateDay(initialDate);
  }

  acceptedButtons: Qt.AllButtons
  onPressed: mouse => {
    if (mouse.button === Qt.MiddleButton) {
      // reset date
      root.pickedDate = DateUtil.copyDateMonth(root.initialDate);
      mouse.accepted = true;
    }
  // calendarChooser.date = new Date(calendarChooser.currentDate.getFullYear(), calendarChooser.currentDate.getMonth(), 1); // ???
  }

  scrollGestureEnabled: true
  onWheel: wheel => {
    let isBigStep = wheel.modifiers & Qt.ControlModifier;

    if (wheel.angleDelta.y > 0) {
      // up
      if (isBigStep) {
        root.pickedDate = DateUtil.addYears(root.pickedDate, -1);
      } else {
        root.pickedDate = DateUtil.addMonths(root.pickedDate, -1);
      }
      wheel.accepted = true;
    } else if (wheel.angleDelta.y < 0) {
      // down
      if (isBigStep) {
        root.pickedDate = DateUtil.addYears(root.pickedDate, +1);
      } else {
        root.pickedDate = DateUtil.addMonths(root.pickedDate, +1);
      }
      wheel.accepted = true;
    }
  }
}
