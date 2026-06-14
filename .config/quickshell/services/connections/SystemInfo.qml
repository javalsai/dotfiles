import QtQuick

import Quickshell
import Quickshell.Io

Scope {
  id: root

  property alias cputime: cputime

  property int updateMs: 1000

  property real memoryUsage
  property real swapUsage

  Process {
    id: memoryProc
    command: ["awk", "/MemTotal/ {t=$2} /MemAvailable/ {a=$2} END {printf(\"%.0f\", (1 - a/t)*100)}", "/proc/meminfo"]
    running: true

    stdout: StdioCollector {
      onStreamFinished: root.memoryUsage = +this.text / 100
    }
  }

  // Swap
  Process {
    id: swapProc
    command: ["awk", "/SwapTotal/ {t=$2} /SwapFree/ {a=$2} END {printf(\"%.0f\", (1 - a/t)*100)}", "/proc/meminfo"]
    running: true

    stdout: StdioCollector {
      onStreamFinished: root.swapUsage = +this.text / 100
    }
  }

  Scope {
    id: cputime

    property int lastTotalJiffy
    property int lastIdleJiffy
    property int lastBusyJiffy: lastTotalJiffy - lastIdleJiffy

    property int totalJiffy
    property int idleJiffy
    property int busyJiffy: totalJiffy - idleJiffy

    property int deltaJiffy: totalJiffy - lastTotalJiffy
    property int deltaBusyJiffy: busyJiffy - lastBusyJiffy

    property real measuredUsage: cputime.deltaBusyJiffy / cputime.deltaJiffy
    // Memory

    Process {
      id: cputimeProc
      command: ["awk", "/^cpu / { total = 0; idle = $5 + $6; for (i=2; i<=NF; i++) total += $i; print total, idle }", "/proc/stat"]
      running: true

      stdout: StdioCollector {
        onStreamFinished: {
          cputime.lastTotalJiffy = cputime.totalJiffy;
          cputime.lastIdleJiffy = cputime.idleJiffy;

          let [total, idle] = this.text.split(' ');

          cputime.totalJiffy = +total;
          cputime.idleJiffy = +idle;
        }
      }
    }
  }

  Timer {
    interval: root.updateMs
    running: true
    repeat: true
    onTriggered: {
      memoryProc.running = true;
      swapProc.running = true;
      cputimeProc.running = true;
    }
  }
}
