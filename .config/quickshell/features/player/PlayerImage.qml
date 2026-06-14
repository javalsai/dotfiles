import QtQuick

import qs
import qs.widgets as Widgets

Widgets.RatioImage {
  readonly property int maxImageSize: 150
  required property string trackArtUrl

  property var changeGifOnUpdateOf

  maxWidth: maxImageSize
  maxHeight: maxImageSize
  radius: 10

  source: trackArtUrl || chosenGif

  readonly property string chosenGif: Qt.resolvedUrl(`${Global.constants.assetsUrl}/${chosenGifName}`)
  readonly property string chosenGifName: {
    changeGifOnUpdateOf;
    chooseGif();
  }

  function chooseGif() {
    return Global.services.gifsList[Math.floor(Math.random() * Global.services.gifsList.length)];
  }
}
