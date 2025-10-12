import QtQuick
import Quickshell
import Quickshell.Hyprland

import qs.components as Components;

ShellRoot {
  Components.Bar {}

  Connections {
    target: Hyprland
    function onRawEvent(event) {
      // console.log(`${event.name}: ${event.data}`);

      if (event.name == "configreloaded")
        HyprlandConfig.reload();

      if (event.name.startsWith("monitor"))
        Hyprland.refreshMonitors();

      Hyprland.refreshWorkspaces();

      if (["changefloatingmode", "activewindow", "activewindowv2", "fullscreen", "movewindow", "movewindowv2"].some(event_name => event_name = event.name))
        Hyprland.refreshToplevels();
    }
  }
}
