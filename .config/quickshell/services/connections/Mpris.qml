import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris

import qs

Scope {
  function playerctldShift() {
    playerctldShift.running = true;
  }

  function playerctldUnshift() {
    playerctldUnshift.running = true;
  }

  Process {
    id: playerctldShift
    running: false
    command: ["playerctld", "shift"]
  }

  Process {
    id: playerctldUnshift
    running: false
    command: ["playerctld", "unshift"]
  }

  property bool isPlayerctld
  property MprisPlayer player: {
    const playerctld = Mpris.players.values.find(player => {
      return player.dbusName === Global.constants.playerctldDbusName;
    });

    isPlayerctld = playerctld !== null && playerctld !== undefined;
    if (isPlayerctld) {
      return playerctld;
    } else {
      return Mpris.players.values.filter(player => {
        return player.canTogglePlaying;
      }).sort((a, b) => b.isPlaying - a.isPlaying)[0] ?? null;
    }
  }
}
