import QtQuick

import Quickshell
import Quickshell.Hyprland

Scope {
  id: root

  signal configReloaded

  Connections {
    target: Hyprland

    // https://github.com/hyprwm/Hyprland/discussions/13721 😭
    // https://github.com/hyprwm/Hyprland/pull/14089 :D
    function onRawEvent(event) {
      // console.log(`${event.name}: ${event.data}`);

      if (event.name == "configreloaded")
        root.configReloaded();

      if (event.name.startsWith("monitor"))
        Hyprland.refreshMonitors();

      Hyprland.refreshWorkspaces();

      if (["changefloatingmode", "activewindow", "activewindowv2", "fullscreen", "movewindow", "movewindowv2"].includes(event.name))
        Hyprland.refreshToplevels();
    }
  }
}
