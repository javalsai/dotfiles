hl.on('hyprland.start', function()
  hl.exec_cmd('nm-applet')
  hl.exec_cmd('blueman-applet')

  hl.exec_cmd('vicinae server')
  hl.exec_cmd('qs')

  hl.exec_cmd('hyprpaper')
  hl.exec_cmd('dunst')
  hl.exec_cmd('playerctld daemon')
  hl.exec_cmd('/usr/lib/xdg-desktop-portal-hyprland')

  hl.exec_cmd('hyprpm reload')

  hl.exec_cmd('dbus-update-activation-environment --systemd --all')

  -- preload
  hl.exec_cmd('kitty --start-as=hidden')
end)
