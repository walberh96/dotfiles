function safe_exit
    set -l action $argv[1]

    echo "Cerrando Steam..."
    pkill -15 steam
    sleep 2

    switch $action
        case shutdown
            echo "Shutting Down..."
            shutdown now
        case reboot
            echo "Rebooting..."
            reboot
        case logout
            echo "Logging out..."
            loginctl terminate-session (loginctl | grep $USER | awk '{print $1}')
        case '*'
            echo "help: safe_exit [shutdown|reboot|logout]"
    end
end
