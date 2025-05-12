#!/usr/bin/env fish


set options "Shutdown\nReboot\nLogout"

set choice (echo -e $options | wofi --dmenu --width 200 --height 250 --x 1670 --y 20)

switch $choice
    case "Shutdown"
        safe_exit shutdown
    case "Reboot"
        safe_exit reboot
    case "Logout"
        safe_exit logout
    case "*"
        echo "No option selected or invalid choice"
end
