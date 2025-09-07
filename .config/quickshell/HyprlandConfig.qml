pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
  id: cfg

  property int gaps_out
  property int rounding

  signal reload

  onReload: {
    get_gaps_out.running = true;
    get_rounding.running = true;
  }

  Process {
    id: get_gaps_out
    command: ["hyprctl", "-j", "getoption", "general:gaps_out"]

    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        let output = JSON.parse(this.text);
        let gaps_out = parseInt(output.custom.split(" ")[0]);
        cfg.gaps_out = gaps_out;
      }
    }
  }

  Process {
    id: get_rounding
    command: ["hyprctl", "-j", "getoption", "decoration:rounding"]

    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        let output = JSON.parse(this.text);
        let rounding = output.int;
        cfg.rounding = rounding;
      }
    }
  }
}
