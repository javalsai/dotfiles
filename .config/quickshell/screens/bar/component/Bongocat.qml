pragma ComponentBehavior: Bound

import QtQuick

import qs
import qs.style as Style

AnimatedImage {
  id: img
  required property bool vertical
  // onVerticalChanged: {
  //   sourceSize = undefined;
  // }

  // Component.onCompleted: {
  //   if (vertical) {
  //     sourceSize.width = Global.theme.barWidth;
  //     sourceSize.height = 0;
  //   } else {
  //     sourceSize.width = null;
  //     sourceSize.height = Global.theme.barHeight;
  //   }
  // }

  // technically undefined should be used for this, but we get warnings that cannot be assigned to int, not can a null (when everything in qml seems to allow null), and using 0 freezes the image after the rotating twice
  // -1 surprisingly doesn't complain or freeze
  //
  // Nevermind -1 doesn't work after resize, it stretches, nor do undefined or null
  sourceSize {
    width: vertical ? Global.theme.barWidth : -1
    height: vertical ? -1 : Global.theme.barHeight
  }

  // asynchronous: true
  source: Qt.resolvedUrl(`${Global.constants.assetsUrl}/bongocat.gif`)
  // measuredUsage ∈ (0, 1] (approx)
  // and I want to map it linearly to 0.4-1.5
  //
  // so that is
  // measuredUsage *1.1 + 0.4
  speed: Global.services.sysInfo.cputime.measuredUsage * 1.1 + 0.4

  layer.enabled: true
  // I know its overkill, I just wanted an excuse to use shaders
  layer.effect: ShaderEffect {
    // TODO: try to animate red changes

    function exp(x) {
      return (Math.exp(x) - 1) / (Math.E - 1);
    }

    property real redStrength: exp(Global.services.sysInfo.memoryUsage)
    fragmentShader: Qt.resolvedUrl(`${Global.constants.shadersUrl}/redify.frag.qsb`)

    Behavior on redStrength {
      Style.Animation {}
    }
  }
}
