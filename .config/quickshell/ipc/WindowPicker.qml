pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

import qs.screens.overlays as Overlays

Scope {
  id: root

  required property Overlays.WindowPicker windowPickerOverlay

  function ipcChoosePrelude() {
    Hyprland.refreshToplevels();
  }

  IpcHandler {
    id: ipc
    target: "windowPicker"

    signal picked(windowAddress: string)

    function chooseAny() {
      root.ipcChoosePrelude();

      root.windowPickerOverlay.openOverlays(Hyprland.toplevels, function (tl: HyprlandToplevel): string {
        return `${tl.title} <b><u>ws:${tl.workspace.name}</u></b> <sup><i>${tl.lastIpcObject.size?.[0]}x${tl.lastIpcObject.size?.[1]}</i></sup>`;
      }, addr => ipc.picked(addr));
    }

    function chooseInWorkspace(workspace: string) {
      root.ipcChoosePrelude();

      // And the chosen monitors
      let ws = Hyprland.workspaces.values.find(ws => ws.name === workspace);
      if (!ws)
        throw new Error("No such workspace");

      root.windowPickerOverlay.openOverlays(ws.toplevels, function (tl: HyprlandToplevel): string {
        return `${tl.title}`;
      }, addr => ipc.picked(addr));
    }
  }
}
