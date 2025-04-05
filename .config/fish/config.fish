if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -g fish_greeting ""

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
end

starship init fish | source
