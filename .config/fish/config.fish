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

starship init fish | source
