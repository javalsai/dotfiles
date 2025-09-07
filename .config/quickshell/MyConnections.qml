import QtQuick

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

// Item {
//   Component.onCompleted: {
//     Hyprland.rawEvent.connect(rawEventHandler);
//   }

//   function rawEventHandler(event) {
//     // console.log(`Event: ${event.name}. Data: ${event.data}`);

//     if (["changefloatingmode", "activewindow", "activewindowv2", "fullscreen", "movewindow", "movewindowv2"].some(event_name => event_name = event.name)) {
//       Hyprland.refreshToplevels();
//     }
//   }
// }
