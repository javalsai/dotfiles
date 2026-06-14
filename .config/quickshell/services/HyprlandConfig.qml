import Quickshell
import Quickshell.Io

Scope {
  id: cfg

  property int gaps_out
  property int rounding
  property int animationSpeed

  signal reload

  onReload: {
    get_gaps_out.running = true;
    get_rounding.running = true;
    get_anim_speed.running = true;
  }

  Process {
    id: get_gaps_out
    command: ["hyprctl", "-j", "getoption", "general:gaps_out"]

    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        let output = JSON.parse(this.text);
        let gaps_out = parseInt(output.css.split(" ")[0]);
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

  Process {
    id: get_anim_speed
    command: ["hyprctl", "-j", "animations"]

    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        let output = JSON.parse(this.text);
        cfg.animationSpeed = output[0].find(e => e.name === "windows").speed * 100;
      }
    }
  }
}
