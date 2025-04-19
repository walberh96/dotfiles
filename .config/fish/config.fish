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

alias pydev='nix-shell ~/NixShells/python-dev.nix'


function mount-ntfs
    echo "lsblk"
    echo "sudo mount -t ntfs-3g /dev/sdXY /mount/point"
    echo "sudo umount /dev/sdXY"
end

starship init fish | source
