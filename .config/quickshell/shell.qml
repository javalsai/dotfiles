import Quickshell
import Quickshell.Hyprland

import qs
import qs.screens as Screens
import qs.screens.overlays as Overlays

import qs.ipc as Ipc

ShellRoot {
  Screens.Bar {
    readonly property var cfg: Global.services.persistentConfig

    vertical: cfg.verticalLayout
    onRotate: cfg.verticalLayout = !cfg.verticalLayout
    summaryGroups: cfg.summarizeGroups
    onSwitchSummaries: cfg.summarizeGroups = !cfg.summarizeGroups

    barWidth: Global.theme.barWidth
    barHeight: Global.theme.barHeight

    floatingGap: Global.services.hyprlandConfig.gaps_out
  }

  Overlays.WindowPicker {
    id: windowPickerOverlay
    monitor: Hyprland.focusedMonitor
  }

  Ipc.WindowPicker {
    windowPickerOverlay: windowPickerOverlay
  }
}
