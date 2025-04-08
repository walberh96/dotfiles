if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -g fish_greeting ""

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

function neofetch
    fastfetch $argv
end

function ls
    lsd $argv
end

function cat
    bat $argv
end

function dotf
    code ~/dotfiles
end



function mount-ntfs
    echo "lsblk"
    echo "sudo mount -t ntfs-3g /dev/sdXY /mount/point"
    echo "sudo umount /dev/sdXY"
end

function screenrec
    # List monitors using hyprctl with detailed information
    echo "Available Monitors:"
    hyprctl monitors | awk '/Monitor/ {print "Monitor " ++count " - " $2}'

    read -l -P "Enter monitor number: " monitor_num

    # Extract the monitor name based on user selection
    set monitor (hyprctl monitors | awk -v num=$monitor_num '/Monitor/ {if (++count == num) print $2}')

    # List audio inputs using PipeWire with full names
    echo "Available Audio Inputs:"
    wpctl status | awk '/Sources:/,/Filters:/' | awk '/\*/ {print $2, substr($0, index($0,$3))}'
    read -l -P "Enter audio input ID: " audio_input

    # Ask for output file path
    read -l -P "Enter output file name: " output_file

    # Run wl-screenrec with selected options
    wl-screenrec --filename "$output_file" --output "$monitor" --audio --audio-device "$audio_input" --low-power=off 
end

starship init fish | source
